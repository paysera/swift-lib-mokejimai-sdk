import ObjectMapper

public class PSTaxInformation: Mappable {
    public var message: String?
    public var messageCode: String?
    public var tins: [PSTaxInformationIdentifier]?
    
    public init() {}
    
    required public init?(map: Map) {}
    
    public func mapping(map: Map) {
        message         <- map["message"]
        messageCode     <- map["message_code"]
        tins            <- map["tins"]
    }
}
