import ObjectMapper

public class PSIdentityDocument: Mappable {
    
    public var documentType: String!
    public var country: String!
    public var type: String!
    public var imageSource: String!
    
    public init() {}
    
    required public init?(map: Map) {
    }
    
    public func mapping(map: Map) {
        documentType   <- map["document_type"]
        country        <- map["country"]
        type           <- map["type"]
        imageSource    <- map["src"]
    }
}
