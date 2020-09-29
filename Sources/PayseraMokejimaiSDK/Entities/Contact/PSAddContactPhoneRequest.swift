import ObjectMapper

public class PSAddContactPhoneRequest: Mappable {
    public var userId: String!
    public var number: String!
    public var status: String!

    public init(
        userId: String,
        number: String,
        status: String
    ) {
        self.userId = userId
        self.number = number
        self.status = status
    }
    
    required public init?(map: Map) {}
    
    public func mapping(map: Map) {
        userId  <- map["user_id"]
        number  <- map["number"]
        status  <- map["status"]
    }
}
