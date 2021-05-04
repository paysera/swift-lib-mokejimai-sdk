import Alamofire
import Foundation
import PayseraCommonSDK

enum MokejimaiApiRequestRouter {
    // MARK: - GET
    case getManualTransferConfiguration(filter: PSBaseFilter)
    case getUserAccountsData(id: Int)
    case getCurrentUserAddresses
    case getUserAddresses(userIdentifier: String)
    case getAvailableIdentityDocuments(filter: PSAvailableIdentityDocumentsFilter)
    case getContactPhones(filter: PSContactFilter)
    case getContactEmails(filter: PSContactFilter)
    case getIdentityDocuments(userId: String, filter: PSBaseFilter)
    
    // MARK: - POST
    case createCompanyAccount(userId: Int, creationType: PSCompanyCreationType)
    case sendLog(userId: String, action: String, context:[String: String])
    case addContactPhone(request: PSAddContactPhoneRequest)
    case addContactEmail(request: PSAddContactEmailRequest)
    
    // MARK: - PUT
    case updateCurrentUserAddress(address: PSAddress)
    case updateUserAddress(userIdentifier: String, address: PSAddress)
    case confirmContactPhone(id: String, code: String)
    case setContactPhoneAsMain(id: Int)
    case confirmContactEmail(id: String, code: String)
    case setContactEmailAsMain(id: Int)
    case uploadAvatar(request: PSUploadAvatarRequest)
    case disableAvatar(userID: String)
    
    // MARK: - DELETE
    case deleteContactPhone(id: Int)
    case deleteContactEmail(id: Int)
    
    // MARK: - Declarations
    private static let baseURL = URL(string: "https://bank.paysera.com")!
    
    private var method: HTTPMethod {
        switch self {
        case .getManualTransferConfiguration,
             .getCurrentUserAddresses,
             .getUserAccountsData,
             .getUserAddresses,
             .getAvailableIdentityDocuments,
             .getContactPhones,
             .getContactEmails,
             .getIdentityDocuments:
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
             .disableAvatar:
            return .put
        case .deleteContactPhone,
             .deleteContactEmail:
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
            return "/user/rest/v1/users/current/addresses"
        case .updateCurrentUserAddress(let address):
            return "/user/rest/v1/users/current/addresses/\(address.type)"
        case .getUserAccountsData(let id):
            return "/user-accounts/rest/v1/accounts/\(id)"
        case .getUserAddresses(let userIdentifier):
            return "/user/rest/v1/users/\(userIdentifier)/addresses"
        case .updateUserAddress(let userIdentifier, let address):
            return "/user/rest/v1/users/\(userIdentifier)/addresses/\(address.type)"
        case .getAvailableIdentityDocuments:
            return "/identification/rest/v1/identity-document-illustrations"
        case .getContactPhones,
             .addContactPhone:
            return "/contact/rest/v1/phones"
        case .deleteContactPhone(let id):
            return "/contact/rest/v1/phones/\(id)"
        case .confirmContactPhone(let id, _):
            return "/contact/rest/v1/phones/\(id)/confirm"
        case .setContactPhoneAsMain(let id):
            return "/contact/rest/v1/phones/\(id)/main"
        case .getContactEmails,
             .addContactEmail:
            return "/contact/rest/v1/emails"
        case .deleteContactEmail(let id):
            return "/contact/rest/v1/emails/\(id)"
        case .confirmContactEmail(let id, _):
            return "/contact/rest/v1/emails/\(id)/confirm"
        case .setContactEmailAsMain(let id):
            return "/contact/rest/v1/emails/\(id)/main"
        case .getIdentityDocuments:
            return "/identity-document/rest/v1/identity-documents"
        case .uploadAvatar:
            return "avatar/rest/v1/avatars"
        case .disableAvatar(let userID):
            return "avatar/rest/v1/avatars/\(userID)/disable"
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
