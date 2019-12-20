import Foundation

public enum PSCompanyCreationType {
    case task(PSCompanyTask)
    case identifier(PSCompanyIdentifier)
    
    var rawValue: String {
        switch self {
        case .task:
            return "company_task"
        case .identifier:
            return "company_identifier"
        }
    }
    
    func toJSON() -> [String: Any] {
        switch self {
        case .identifier(let identifier):
            return [rawValue: identifier.toJSON()]
        case .task(let task):
            return [rawValue: task.toJSON()]
        }
    }
}
