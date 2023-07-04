import ObjectMapper

public class PSCompanyTaskSolutionError: Mappable {
    public var id: String!
    public var countryCode: String!
    public var type: String!
    public var imageData: String!

    public init() {}
    
    required public init?(map: Map) {}
    
    public func mapping(map: Map) {
        id                  <- map["id"]
        countryCode         <- map["country_code"]
        type                <- map["type"]
        imageData           <- map["image_data"]
    }
}
