import Foundation
import Alamofire
import PromiseKit
import ObjectMapper
import PayseraCommonSDK

public class MokejimaiApiClient: PSBaseApiClient {
    
    public func getCurrentUserAddresses() -> Promise<PSMetadataAwareResponse<PSAddress>> {
        return doRequest(requestRouter: MokejimaiApiRequestRouter.getCurrentUserAddresses)
    }
    
    public func getUserAddresses(userIdentifier: String) -> Promise<PSMetadataAwareResponse<PSAddress>> {
        return doRequest(requestRouter: MokejimaiApiRequestRouter.getUserAddresses(userIdentifier: userIdentifier))
    }
    
    public func updateCurrentUserAddress(_ address: PSAddress) -> Promise<PSAddress> {
        return doRequest(requestRouter: MokejimaiApiRequestRouter.updateCurrentUserAddress(address: address))
    }
    
    public func updateUserAddress(userIdentifier: String, address: PSAddress) -> Promise<PSAddress> {
        return doRequest(requestRouter: MokejimaiApiRequestRouter.updateUserAddress(userIdentifier: userIdentifier, address: address))
    }
    
    public func getManualTransferConfiguration(filter: PSBaseFilter) -> Promise<PSMetadataAwareResponse<PSManualTransferConfiguration>> {
        return doRequest(
            requestRouter: MokejimaiApiRequestRouter.getManualTransferConfiguration(
                filter: filter
            )
        )
    }
    
    public func createCompanyAccount(userId: Int, using creationType: PSCompanyCreationType) -> Promise<PSCompanyAccount> {
        return doRequest(
            requestRouter: MokejimaiApiRequestRouter.createCompanyAccount(
                userId: userId,
                creationType: creationType
            )
        )
    }

    public func sendLog(userId: String, action: String, context:[String: String]) -> Promise<Any>{
        return doRequest(
            requestRouter: MokejimaiApiRequestRouter.sendLog(
                userId: userId,
                action: action,
                context: context
            )
        )
    }
    
    public func getUserAccountsData(id: Int) -> Promise<PSMetadataAwareResponse<PSUserAccountData>> {
        return doRequest(requestRouter: MokejimaiApiRequestRouter.getUserAccountsData(id: id))
    }
    
    public func getAvailableIdentityDocuments(filter: PSAvailableIdentityDocumentsFilter) -> Promise<PSMetadataAwareResponse<PSIdentityDocument>> {
        return doRequest(requestRouter: MokejimaiApiRequestRouter.getAvailableIdentityDocuments(filter: filter))
    }
    
    public func getContactPhones(filter: PSContactFilter) -> Promise<PSMetadataAwareResponse<PSContactPhone>> {
        return doRequest(requestRouter: MokejimaiApiRequestRouter.getContactPhones(filter: filter))
    }
    
    public func deleteContactPhone(id: Int) -> Promise<Void> {
        return doRequest(requestRouter: MokejimaiApiRequestRouter.deleteContactPhone(id: id))
    }
    
    public func addContactPhone(request: PSAddContactPhoneRequest) -> Promise<PSContactPhone> {
        return doRequest(requestRouter: MokejimaiApiRequestRouter.addContactPhone(request: request))
    }
    
    public func confirmContactPhone(id: String, code: String) -> Promise<PSContactPhone> {
        return doRequest(requestRouter: MokejimaiApiRequestRouter.confirmContactPhone(id: id, code: code))
    }
    
    public func setContactPhoneAsMain(id: Int) -> Promise<PSContactPhone> {
        return doRequest(requestRouter: MokejimaiApiRequestRouter.setContactPhoneAsMain(id: id))
    }
    
    public func getContactEmails(filter: PSContactFilter) -> Promise<PSMetadataAwareResponse<PSContactEmail>> {
        return doRequest(requestRouter: MokejimaiApiRequestRouter.getContactEmails(filter: filter))
    }
    
    public func deleteContactEmail(id: Int) -> Promise<Void> {
        return doRequest(requestRouter: MokejimaiApiRequestRouter.deleteContactEmail(id: id))
    }
    
    public func addContactEmail(request: PSAddContactEmailRequest) -> Promise<PSContactEmail> {
        return doRequest(requestRouter: MokejimaiApiRequestRouter.addContactEmail(request: request))
    }
    
    public func confirmContactEmail(id: String, code: String) -> Promise<PSContactEmail> {
        return doRequest(requestRouter: MokejimaiApiRequestRouter.confirmContactEmail(id: id, code: code))
    }
    
    public func setContactEmailAsMain(id: Int) -> Promise<PSContactEmail> {
        return doRequest(requestRouter: MokejimaiApiRequestRouter.setContactEmailAsMain(id: id))
    }
    
    public func getIdentityDocuments(userId: String, filter: PSBaseFilter) -> Promise<PSMetadataAwareResponse<PSUploadedIdentityDocument>> {
        doRequest(requestRouter: MokejimaiApiRequestRouter.getIdentityDocuments(userId: userId, filter: filter))
    }
}
