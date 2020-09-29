import ObjectMapper

public class PSContactEmail: Mappable {
    public var id: Int!
    public var isMain: Bool!
    public var email: String!
    public var active: Bool!
    public var useForLogin: Bool!
    public var userId: String!

    public init() {}
    
    required public init?(map: Map) {}
    
    public func mapping(map: Map) {
        id          <- map["id"]
        isMain      <- map["main"]
        email       <- map["email"]
        active      <- map["active"]
        useForLogin <- map["use_for_login"]
        userId      <- map["user_id"]
    }
}
