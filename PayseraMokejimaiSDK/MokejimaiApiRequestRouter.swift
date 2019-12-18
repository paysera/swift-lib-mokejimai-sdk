import Foundation
import Alamofire
import PayseraCommonSDK

public enum MokejimaiApiRequestRouter: URLRequestConvertible {
    // MARK: - GET
    case getManualTransferConfiguration(filter: PSBaseFilter)
    case logAppUnlocks(userId: String, appVersion: String)
    // MARK: - POST
    case createCompanyAccount(userId: Int, companyIdentifier: PSCompanyIdentifier)
    
    // MARK: - PUT
    
    // MARK: - Declarations
    static var baseURLString = "https://bank.paysera.com"
    
    private var method: HTTPMethod {
        switch self {
        case .getManualTransferConfiguration(_):
            return .get
        case .createCompanyAccount:
            return .post
        case .logAppUnlocks:
            return .post
        }
    }
    
    private var path: String {
        switch self {
            
        case .getManualTransferConfiguration(_):
            return "/manual-transfer-configuration/rest/v1/configurations"
        case .createCompanyAccount:
            return "/company-account/rest/v1/company-accounts"
        case .logAppUnlocks:
            return "/log/rest/v1/logs"
        }
    }
    
    private var parameters: Parameters? {
        switch self {
            case .getManualTransferConfiguration(let filter):
                return filter.toJSON()
            case .createCompanyAccount(let userId, let companyIdentifier):
                return [
                    "manager_id": userId,
                    "type": "company_identifier",
                    "company_identifier": companyIdentifier.toJSON()
                ]
            case .logAppUnlocks(let userId, let appVersion):
                return [
                    "action" : "app_unlocked",
                    "user_id": userId,
                    "context": ["app_version": appVersion]
            ]
            default:
                return nil
        }
    }
    
    // MARK: - Method
    public func asURLRequest() throws -> URLRequest {
        let url = try! MokejimaiApiRequestRouter.baseURLString.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        
        switch self {
            case (_) where method == .get:
                urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
            
            case (_) where method == .post:
                urlRequest = try JSONEncoding.default.encode(urlRequest, with: parameters)
            
            case (_) where method == .put:
                urlRequest = try JSONEncoding.default.encode(urlRequest, with: parameters)
            
            default:
                urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
        }
        
        return urlRequest
    }
}
