import ObjectMapper

public class PSTaxInformationIdentifier: Mappable {
    public var tin: PSTin?
    public var expiresIn: Int?
    public var message: String?
    public var messageCode: String?
    
    public init() {}
    
    required public init?(map: Map) {}
    
    public func mapping(map: Map) {
        tin         <- map["tin"]
        expiresIn   <- map["expires_in"]
        message     <- map["message"]
        messageCode <- map["message_code"]
    }
}
