import Alamofire
import Foundation
import PayseraCommonSDK

enum MokejimaiApiRequestRouter {
    /// GET
    case getManualTransferConfiguration(filter: PSBaseFilter)
    case getUserAccountsData(id: Int)
    case getCurrentUserAddresses
    case getUserAddresses(userIdentifier: String)
    case getAvailableIdentityDocuments(filter: PSAvailableIdentityDocumentsFilter)
    case getContactPhones(filter: PSContactFilter)
    case getContactEmails(filter: PSContactFilter)
    case getIdentityDocuments(userId: String, filter: PSBaseFilter)
    case getTaxInformation(userId: String)
    
    /// POST
    case createCompanyAccount(userId: Int, creationType: PSCompanyCreationType)
    case sendLog(userId: String, action: String, context:[String: String])
    case addContactPhone(request: PSAddContactPhoneRequest)
    case addContactEmail(request: PSAddContactEmailRequest)
    
    /// PUT
    case updateCurrentUserAddress(address: PSAddress)
    case updateUserAddress(userIdentifier: String, address: PSAddress)
    case confirmContactPhone(id: String, code: String)
    case setContactPhoneAsMain(id: Int)
    case confirmContactEmail(id: String, code: String)
    case setContactEmailAsMain(id: Int)
    case uploadAvatar(request: PSUploadAvatarRequest)
    case disableAvatar(userID: String)
    case requestDeletion
    case requestDeletionCancel
    case deactivate(userID: String)
    
    /// DELETE
    case deleteContactPhone(id: Int)
    case deleteContactEmail(id: Int)
    
    // MARK: - Declarations
    
    private static let baseURL = URL(string: "https://bank.paysera.com")!
    private static let usersRoute = "/user/rest/v1/users"
    private static let contactRoute = "/contact/rest/v1"
    private static let phonesRoute = Self.contactRoute + "/phones"
    private static let emailsRoute = Self.contactRoute + "/emails"
    private static let avatarsRoute = "avatar/rest/v1/avatars"
    
    private var method: HTTPMethod {
        switch self {
        case .getManualTransferConfiguration,
             .getCurrentUserAddresses,
             .getUserAccountsData,
             .getUserAddresses,
             .getAvailableIdentityDocuments,
             .getContactPhones,
             .getContactEmails,
             .getIdentityDocuments,
             .getTaxInformation:
            return .get
        case .createCompanyAccount,
             .sendLog,
             .addContactPhone,
             .addContactEmail:
            return .post
        case .updateCurrentUserAddress,
             .updateUserAddress,
             .confirmContactPhone,
             .setContactPhoneAsMain,
             .confirmContactEmail,
             .setContactEmailAsMain,
             .uploadAvatar,
             .disableAvatar,
             .requestDeletion,
             .requestDeletionCancel:
            return .put
        case .deleteContactPhone,
             .deleteContactEmail,
             .deactivate:
            return .delete
        }
    }
    
    private var path: String {
        switch self {
        case .getManualTransferConfiguration:
            return "/manual-transfer-configuration/rest/v1/configurations"
        case .createCompanyAccount:
            return "/company-account/rest/v1/company-accounts"
        case .sendLog:
            return "/log/rest/v1/logs"
        case .getCurrentUserAddresses:
            return Self.usersRoute + "/current/addresses"
        case .updateCurrentUserAddress(let address):
            return Self.usersRoute + "/current/addresses/\(address.type)"
        case .getUserAccountsData(let id):
            return "/user-accounts/rest/v1/accounts/\(id)"
        case .getUserAddresses(let userID):
            return Self.usersRoute + "/\(userID)/addresses"
        case .updateUserAddress(let userID, let address):
            return Self.usersRoute + "/\(userID)/addresses/\(address.type)"
        case .getAvailableIdentityDocuments:
            return "/identification/rest/v1/identity-document-illustrations"
        case .requestDeletion:
            return Self.usersRoute + "/me/request-deletion"
        case .requestDeletionCancel:
            return Self.usersRoute + "/me/request-deletion-cancel"
        case .deactivate(let userID):
            return Self.usersRoute + "/users/\(userID)/deactivate"
        case .getContactPhones,
             .addContactPhone:
            return Self.phonesRoute
        case .deleteContactPhone(let id):
            return Self.phonesRoute + "/\(id)"
        case .confirmContactPhone(let id, _):
            return Self.phonesRoute + "/\(id)/confirm"
        case .setContactPhoneAsMain(let id):
            return Self.phonesRoute + "/\(id)/main"
        case .getContactEmails,
             .addContactEmail:
            return Self.emailsRoute
        case .deleteContactEmail(let id):
            return Self.emailsRoute + "/\(id)"
        case .confirmContactEmail(let id, _):
            return Self.emailsRoute + "/\(id)/confirm"
        case .setContactEmailAsMain(let id):
            return Self.emailsRoute + "/\(id)/main"
        case .getIdentityDocuments:
            return "/identity-document/rest/v1/identity-documents"
        case .getTaxInformation(let id):
            return "tax-information/rest/v1/tax-information-identifier-messages/\(id)"
        case .uploadAvatar:
            return Self.avatarsRoute
        case .disableAvatar(let userID):
            return Self.avatarsRoute + "/\(userID)/disable"
        }
    }
    
    private var parameters: Parameters? {
        switch self {
        case .getManualTransferConfiguration(let filter):
            return filter.toJSON()
        case .createCompanyAccount(let userId, let creationType):
            return [
                "manager_id": userId,
                "type": creationType.rawValue,
            ].merging(creationType.toJSON()) { (first, _) in first }
        case .sendLog(let userId, let action, let context):
            return [
                "action" : action,
                "user_id": userId,
                "context": context
            ]
        case .updateCurrentUserAddress(let address),
             .updateUserAddress(_, let address):
            return address.toJSON()
        case .getAvailableIdentityDocuments(let filter):
            return filter.toJSON()
        case .getContactPhones(let filter),
             .getContactEmails(let filter):
            return filter.toJSON()
        case .addContactPhone(let request):
            return request.toJSON()
        case .confirmContactPhone(_, let code),
             .confirmContactEmail(_, let code):
            return ["code": code]
        case .addContactEmail(let request):
            return request.toJSON()
        case .getIdentityDocuments(let userId, let filter):
            var queryParameters = filter.toJSON()
            queryParameters["user_id"] = userId
            return queryParameters
        case .uploadAvatar(let request):
            return request.toJSON()
        default:
            return nil
        }
    }
}

extension MokejimaiApiRequestRouter: URLRequestConvertible {
    func asURLRequest() throws -> URLRequest {
        let url = Self.baseURL.appendingPathComponent(path)
        var urlRequest = URLRequest(url: url)
        urlRequest.method = method
        
        switch method {
        case .post,
             .put:
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: parameters)
        default:
            urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
        }
        
        return urlRequest
    }
}
