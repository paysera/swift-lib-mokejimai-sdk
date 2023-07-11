import ObjectMapper

public class PSUserAccountDeactivation: Mappable {
    public var status: String!
    
    public init() {}
    
    required public init?(map: Map) {}
    
    public func mapping(map: Map) {
        status      <- map["status"]
    }
}
