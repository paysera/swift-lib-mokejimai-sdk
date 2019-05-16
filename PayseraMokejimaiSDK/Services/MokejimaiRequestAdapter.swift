import Foundation
import Alamofire
import CommonCrypto

class MokejimaiRequestAdapter: RequestAdapter {
    private let headers: MokejimaiRequestHeaders
    private let credentials: MokejimaiApiCredentials
    
    init(credentials: MokejimaiApiCredentials, headers: MokejimaiRequestHeaders) {
        self.credentials = credentials
        self.headers = headers
    }
    
    public func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        var urlRequest = urlRequest
       
        urlRequest.setValue("Bearer " + (credentials.token?.string ?? ""), forHTTPHeaderField: "Authorization")
        
        headers.headers.forEach {
            urlRequest.setValue($0.value, forHTTPHeaderField: $0.headerKey)
        }
        
        return urlRequest
    }
}
