import ObjectMapper

public class PSTaxInformation: Mappable {
    public var messages: [PSTaxInformationIdentifier]?
    
    public init() {}
    
    required public init?(map: Map) {}
    
    public func mapping(map: Map) {
        messages <- map["messages"]
    }
}
