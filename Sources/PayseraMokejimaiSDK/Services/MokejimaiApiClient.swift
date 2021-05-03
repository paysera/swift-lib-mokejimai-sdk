import PayseraCommonSDK
import PromiseKit

public class MokejimaiApiClient: PSBaseApiClient {
    
    public func getCurrentUserAddresses() -> Promise<PSMetadataAwareResponse<PSAddress>> {
        doRequest(requestRouter: MokejimaiApiRequestRouter.getCurrentUserAddresses)
    }
    
    public func getUserAddresses(
        userIdentifier: String
    ) -> Promise<PSMetadataAwareResponse<PSAddress>> {
        doRequest(
            requestRouter: MokejimaiApiRequestRouter.getUserAddresses(
                userIdentifier: userIdentifier
            )
        )
    }
    
    public func updateCurrentUserAddress(_ address: PSAddress) -> Promise<PSAddress> {
        doRequest(
            requestRouter: MokejimaiApiRequestRouter.updateCurrentUserAddress(address: address)
        )
    }
    
    public func updateUserAddress(
        userIdentifier: String,
        address: PSAddress
    ) -> Promise<PSAddress> {
        doRequest(
            requestRouter: MokejimaiApiRequestRouter.updateUserAddress(
                userIdentifier: userIdentifier,
                address: address
            )
        )
    }
    
    public func getManualTransferConfiguration(
        filter: PSBaseFilter
    ) -> Promise<PSMetadataAwareResponse<PSManualTransferConfiguration>> {
        doRequest(
            requestRouter: MokejimaiApiRequestRouter.getManualTransferConfiguration(
                filter: filter
            )
        )
    }
    
    public func createCompanyAccount(
        userId: Int,
        using creationType: PSCompanyCreationType
    ) -> Promise<PSCompanyAccount> {
        doRequest(
            requestRouter: MokejimaiApiRequestRouter.createCompanyAccount(
                userId: userId,
                creationType: creationType
            )
        )
    }

    public func sendLog(userId: String, action: String, context:[String: String]) -> Promise<Any> {
        doRequest(
            requestRouter: MokejimaiApiRequestRouter.sendLog(
                userId: userId,
                action: action,
                context: context
            )
        )
    }
    
    public func getUserAccountsData(
        id: Int
    ) -> Promise<PSMetadataAwareResponse<PSUserAccountData>> {
        doRequest(requestRouter: MokejimaiApiRequestRouter.getUserAccountsData(id: id))
    }
    
    public func getAvailableIdentityDocuments(
        filter: PSAvailableIdentityDocumentsFilter
    ) -> Promise<PSMetadataAwareResponse<PSIdentityDocument>> {
        doRequest(
            requestRouter: MokejimaiApiRequestRouter.getAvailableIdentityDocuments(filter: filter)
        )
    }
    
    public func getContactPhones(
        filter: PSContactFilter
    ) -> Promise<PSMetadataAwareResponse<PSContactPhone>> {
        doRequest(requestRouter: MokejimaiApiRequestRouter.getContactPhones(filter: filter))
    }
    
    public func deleteContactPhone(id: Int) -> Promise<Void> {
        doRequest(requestRouter: MokejimaiApiRequestRouter.deleteContactPhone(id: id))
    }
    
    public func addContactPhone(request: PSAddContactPhoneRequest) -> Promise<PSContactPhone> {
        doRequest(requestRouter: MokejimaiApiRequestRouter.addContactPhone(request: request))
    }
    
    public func confirmContactPhone(id: String, code: String) -> Promise<PSContactPhone> {
        doRequest(requestRouter: MokejimaiApiRequestRouter.confirmContactPhone(id: id, code: code))
    }
    
    public func setContactPhoneAsMain(id: Int) -> Promise<PSContactPhone> {
        doRequest(requestRouter: MokejimaiApiRequestRouter.setContactPhoneAsMain(id: id))
    }
    
    public func getContactEmails(
        filter: PSContactFilter
    ) -> Promise<PSMetadataAwareResponse<PSContactEmail>> {
        doRequest(requestRouter: MokejimaiApiRequestRouter.getContactEmails(filter: filter))
    }
    
    public func deleteContactEmail(id: Int) -> Promise<Void> {
        doRequest(requestRouter: MokejimaiApiRequestRouter.deleteContactEmail(id: id))
    }
    
    public func addContactEmail(request: PSAddContactEmailRequest) -> Promise<PSContactEmail> {
        doRequest(requestRouter: MokejimaiApiRequestRouter.addContactEmail(request: request))
    }
    
    public func confirmContactEmail(id: String, code: String) -> Promise<PSContactEmail> {
        doRequest(requestRouter: MokejimaiApiRequestRouter.confirmContactEmail(id: id, code: code))
    }
    
    public func setContactEmailAsMain(id: Int) -> Promise<PSContactEmail> {
        doRequest(requestRouter: MokejimaiApiRequestRouter.setContactEmailAsMain(id: id))
    }
    
    public func getIdentityDocuments(
        userId: String,
        filter: PSBaseFilter
    ) -> Promise<PSMetadataAwareResponse<PSUploadedIdentityDocument>> {
        doRequest(
            requestRouter: MokejimaiApiRequestRouter.getIdentityDocuments(
                userId: userId,
                filter: filter
            )
        )
    }
    
    public func uploadAvatar(request: PSUploadAvatarRequest) -> Promise<Void> {
        doRequest(requestRouter: MokejimaiApiRequestRouter.uploadAvatar(request: request))
    }
    
    public func disableAvatar(userID: String) -> Promise<Void> {
        doRequest(requestRouter: MokejimaiApiRequestRouter.disableAvatar(userID: userID))
    }
}
