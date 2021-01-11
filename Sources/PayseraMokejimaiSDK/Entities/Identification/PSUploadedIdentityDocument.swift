import ObjectMapper

public class PSUploadedIdentityDocument: Mappable {
    
    public var id: Int!
    public var type: String!
    public var dateOfExpiry: String?
    public var reviewStatus: String!
    
    public init() {}
    
    required public init?(map: Map) {}
    
    public func mapping(map: Map) {
        id              <- map["id"]
        type            <- map["type"]
        dateOfExpiry    <- map["date_of_expiry"]
        reviewStatus    <- map["review_status"]
    }
}
