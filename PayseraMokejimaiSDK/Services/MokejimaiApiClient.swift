import Foundation
import Alamofire
import PromiseKit
import ObjectMapper
import PayseraCommonSDK

public class MokejimaiApiClient: PSBaseApiClient {
    public func getManualTransferConfiguration(filter: PSBaseFilter) -> Promise<PSMetadataAwareResponse<PSManualTransferConfiguration>> {
        return doRequest(requestRouter: MokejimaiApiRequestRouter.getManualTransferConfiguration(filter: filter))
    }
    
    public func createCompanyAccount(userId: Int, using creationType: PSCompanyCreationType) -> Promise<PSCompanyAccount> {
        return doRequest(requestRouter: MokejimaiApiRequestRouter.createCompanyAccount(userId: userId, creationType: creationType))
    }

    public func sendLog(userId: String, action: String, context:[String: String]) -> Promise<Any>{
        return doRequest(requestRouter: MokejimaiApiRequestRouter.sendLog(userId: userId, action: action, context: context))
    }
}
