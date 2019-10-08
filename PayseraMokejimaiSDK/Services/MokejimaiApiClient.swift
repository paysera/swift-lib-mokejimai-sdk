import Foundation
import Alamofire
import PromiseKit
import ObjectMapper
import PayseraCommonSDK

public class MokejimaiApiClient: PSBaseApiClient {
    public func getManualTransferConfiguration(filter: PSBaseFilter) -> Promise<PSMetadataAwareResponse<PSManualTransferConfiguration>> {
        return doRequest(requestRouter: MokejimaiApiRequestRouter.getManualTransferConfiguration(filter: filter))
    }
}
