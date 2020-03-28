import Foundation
import Alamofire
import PromiseKit
import ObjectMapper
import PayseraCommonSDK

public class MokejimaiApiClient: PSBaseApiClient {
    
    public func setLivingAddress(_ address: PSAddress) -> Promise<PSAddress> {
        return requestRouter(.setLivingAddress(address: address))
    }
    
    public func getUserAddresses() -> Promise<PSMetadataAwareResponse<PSAddress>> {
        return requestRouter(.getUserAddresses)
    }
    
    public func getManualTransferConfiguration(filter: PSBaseFilter) -> Promise<PSMetadataAwareResponse<PSManualTransferConfiguration>> {
        return requestRouter(.getManualTransferConfiguration(filter: filter))
    }
    
    public func createCompanyAccount(userId: Int, using creationType: PSCompanyCreationType) -> Promise<PSCompanyAccount> {
        return requestRouter(.createCompanyAccount(userId: userId, creationType: creationType))
    }

    public func sendLog(userId: String, action: String, context:[String: String]) -> Promise<Any>{
        return requestRouter(.sendLog(
                userId: userId,
                action: action,
                context: context
            )
        )
    }
}

//MARK: HELPER
fileprivate extension MokejimaiApiClient {
    
    func requestRouter<E>(
        _ requestRouter: MokejimaiApiRequestRouter
    ) -> Promise<[E]> where E : Mappable {
        return doRequest(requestRouter: requestRouter)
    }
    
    func requestRouter<E>(
        _ requestRouter: MokejimaiApiRequestRouter
    ) -> Promise<E> where E : Mappable {
        return doRequest(requestRouter: requestRouter)
    }
    
    func requestRouter(
        _ requestRouter: MokejimaiApiRequestRouter
    ) -> Promise<Any> {
        return doRequest(requestRouter: requestRouter)
    }
    
    func requestRouter(
        _ requestRouter: MokejimaiApiRequestRouter
    ) -> Promise<Void> {
        return doRequest(requestRouter: requestRouter)
    }
}
