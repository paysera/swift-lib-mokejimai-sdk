import ObjectMapper

public class PSTin: Mappable {
    public var uuid: String!
    public var userID: String!
    public var userType: String!
    public var country: String!
    public var tin: String!
    public var updatedAt: Int!
    
    public init() {}
    
    required public init?(map: Map) {}
    
    public func mapping(map: Map) {
        uuid        <- map["uuid"]
        userID      <- map["user_id"]
        userType    <- map["user_type"]
        country     <- map["country"]
        tin         <- map["tin"]
        updatedAt   <- map["updated_at"]
    }
}
