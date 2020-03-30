import Foundation
import Alamofire
import PayseraCommonSDK

public enum MokejimaiApiRequestRouter: URLRequestConvertible {
    // MARK: - GET
    case getManualTransferConfiguration(filter: PSBaseFilter)
    case sendLog(userId: String, action: String, context:[String: String])
    // MARK: - POST
    case createCompanyAccount(userId: Int, creationType: PSCompanyCreationType)
    case getAddresses
    case setAddress(address: PSAddress)
    
    // MARK: - PUT
    
    // MARK: - Declarations
    static var baseURLString = "https://bank.paysera.com"
    
    private var method: HTTPMethod {
        switch self {
        case .getManualTransferConfiguration,
             .getAddresses:
            return .get
        case .createCompanyAccount,
             .sendLog:
            return .post
        case .setAddress:
            return .put
        }
    }
    
    private var path: String {
        switch self {
            
        case .getManualTransferConfiguration(_):
            return "/manual-transfer-configuration/rest/v1/configurations"
        case .createCompanyAccount:
            return "/company-account/rest/v1/company-accounts"
        case .sendLog:
            return "/log/rest/v1/logs"
        case .getAddresses:
            return "/user/rest/v1/users/current/addresses"
        case .setAddress(let address):
            return "/user/rest/v1/users/current/addresses/\(address.type)"
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
        case .setAddress(let address):
            return address.toJSON()
        default: return nil
        }
    }
    
    // MARK: - Method
    public func asURLRequest() throws -> URLRequest {
        
        let requestMethod = method
        let url = try! MokejimaiApiRequestRouter.baseURLString.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = requestMethod.rawValue
        
        switch requestMethod {
        case .post,
             .put:
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: parameters)
        default:
            urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
        }
        return urlRequest
    }
}
