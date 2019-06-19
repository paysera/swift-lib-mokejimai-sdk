import Foundation
import Alamofire
import PromiseKit
import ObjectMapper
import PayseraCommonSDK

public class MokejimaiApiClient {
    private let sessionManager: SessionManager
    private let credentials: MokejimaiApiCredentials
    private let tokenRefresher: TokenRefresherProtocol?
    private let logger: PSLoggerProtocol?
    private var requestsQueue = [ApiRequest]()
    
    public init(
        sessionManager: SessionManager,
        credentials: MokejimaiApiCredentials,
        tokenRefresher: TokenRefresherProtocol?,
        logger: PSLoggerProtocol? = nil
    ) {
        self.sessionManager = sessionManager
        self.tokenRefresher = tokenRefresher
        self.credentials = credentials
        self.logger = logger
    }
    
    public func getManualTransferConfiguration(filter: PSBaseFilter) -> Promise<PSMetadataAwareResponse<PSManualTransferConfiguration>> {
        return doRequest(requestRouter: MokejimaiApiRequestRouter.getManualTransferConfiguration(filter: filter))
    }
    
    // MARK: - Private request methods
    private func makeRequest(apiRequest: ApiRequest) {
        let lockQueue = DispatchQueue(label: String(describing: tokenRefresher), attributes: [])
        lockQueue.sync {
            if let tokenRefresher = tokenRefresher, tokenRefresher.isRefreshing() {
                requestsQueue.append(apiRequest)
            } else {
                self.logger?.log(level: .INFO, message: "--> \(apiRequest.requestEndPoint.urlRequest!.url!.absoluteString)")
                
                sessionManager
                    .request(apiRequest.requestEndPoint)
                    .responseJSON { (response) in
                        var logMessage = "<-- \(apiRequest.requestEndPoint.urlRequest!.url!.absoluteString)"
                        if let statusCode = response.response?.statusCode {
                            logMessage += " (\(statusCode))"
                        }
                        
                        self.logger?.log(level: .INFO, message: logMessage)
                        
                        let responseData = response.result.value
                        
                        guard let statusCode = response.response?.statusCode else {
                            let error = self.mapError(body: responseData)
                            apiRequest.pendingPromise.resolver.reject(error)
                            return
                        }
                        
                        if statusCode >= 200 && statusCode < 300 {
                            apiRequest.pendingPromise.resolver.fulfill(responseData)
                        } else {
                            let error = self.mapError(body: responseData)
                            if statusCode == 401 {
                                guard let tokenRefresher = self.tokenRefresher else {
                                    apiRequest.pendingPromise.resolver.reject(error)
                                    return
                                }
                                lockQueue.sync {
                                    if self.credentials.hasRecentlyRefreshed() {
                                        self.makeRequest(apiRequest: apiRequest)
                                        return
                                    }
                                    
                                    self.requestsQueue.append(apiRequest)
                                    
                                    if !tokenRefresher.isRefreshing() {
                                        tokenRefresher
                                            .refreshToken()
                                            .done { result in
                                                self.resumeQueue()
                                            }.catch { error in
                                                self.cancelQueue(error: error)
                                        }
                                    }
                                }
                            } else {
                                apiRequest.pendingPromise.resolver.reject(error)
                            }
                        }
                }
            }
        }
    }
    
    private func doRequest<RC: URLRequestConvertible, E: Mappable>(requestRouter: RC) -> Promise<[E]> {
        let request = createRequest(requestRouter)
        makeRequest(apiRequest: request)
        
        return request
            .pendingPromise
            .promise
            .then(createPromiseWithArrayResult)
    }
    
    private func doRequest<RC: URLRequestConvertible, E: Mappable>(requestRouter: RC) -> Promise<E> {
        let request = createRequest(requestRouter)
        makeRequest(apiRequest: request)
        
        return request
            .pendingPromise
            .promise
            .then(createPromise)
    }
    
    private func resumeQueue() {
        for request in requestsQueue {
            makeRequest(apiRequest: request)
        }
        requestsQueue.removeAll()
    }
    
    private func cancelQueue(error: Error) {
        for requests in requestsQueue {
            requests.pendingPromise.resolver.reject(error)
        }
        requestsQueue.removeAll()
    }
    
    private func createPromiseWithArrayResult<T: Mappable>(body: Any) -> Promise<[T]> {
        guard let objects = Mapper<T>().mapArray(JSONObject: body) else {
            return Promise(error: mapError(body: body))
        }
        return Promise.value(objects)
    }
    
    private func createPromise<T: Mappable>(body: Any) -> Promise<T> {
        guard let object = Mapper<T>().map(JSONObject: body) else {
            return Promise(error: mapError(body: body))
        }
        return Promise.value(object)
    }
    
    private func mapError(body: Any?) -> PSMokejimaiApiError {
        if let apiError = Mapper<PSMokejimaiApiError>().map(JSONObject: body) {
            return apiError
        }
        
        return PSMokejimaiApiError.unknown()
    }
    
    private func createRequest<T: ApiRequest, R: URLRequestConvertible>(_ endpoint: R) -> T {
        return T.init(pendingPromise: Promise<Any>.pending(), requestEndPoint: endpoint)
    }
}
