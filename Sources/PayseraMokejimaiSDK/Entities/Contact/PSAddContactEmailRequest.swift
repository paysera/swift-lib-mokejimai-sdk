import ObjectMapper

public class PSAddContactEmailRequest: Mappable {
    public var userId: String!
    public var email: String!

    public init(
        userId: String,
        email: String
    ) {
        self.userId = userId
        self.email = email
    }
    
    required public init?(map: Map) {}
    
    public func mapping(map: Map) {
        userId  <- map["user_id"]
        email   <- map["email"]
    }
}
