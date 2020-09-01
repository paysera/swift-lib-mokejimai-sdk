import ObjectMapper

public class PSUserAccountData: Mappable {
    public var id: Int!
    public var identifier: String!
    public var code: String?
    public var displayName: String?
    public var type: String!
    
    public init() {}
    
    required public init?(map: Map) {
    }
    
    public func mapping(map: Map) {
        id                  <- map["id"]
        identifier          <- map["identifier"]
        code                <- map["code"]
        displayName         <- map["display_name"]
        type                <- map["type"]
    }
}
