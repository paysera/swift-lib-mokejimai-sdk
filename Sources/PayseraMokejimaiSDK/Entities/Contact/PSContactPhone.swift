import ObjectMapper

public class PSContactPhone: Mappable {
    public var id: Int!
    public var isMain: Bool!
    public var number: String!
    public var status: String!
    public var useForLogin: Bool!
    public var userId: String!

    public init() {}
    
    required public init?(map: Map) {}
    
    public func mapping(map: Map) {
        id              <- map["id"]
        isMain          <- map["main"]
        number          <- map["number"]
        status          <- map["status"]
        useForLogin     <- map["use_for_login"]
        userId          <- map["user_id"]
    }
}
