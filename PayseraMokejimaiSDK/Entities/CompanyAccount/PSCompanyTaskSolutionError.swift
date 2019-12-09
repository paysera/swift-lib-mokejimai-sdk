import ObjectMapper

public class PSCompanyTaskSolutionError: Mappable {
    public var id: String!
    public var countryCode: String!
    public var type: PSCompanyTaskType!
    public var imageData: String!

    public init() {
    }
    
    required public init?(map: Map) {
    }
    
    public func mapping(map: Map) {
        let rawTaskTypeValue = map.JSON["type"] as! String
        
        id                  <- map["id"]
        countryCode         <- map["country_code"]
        type                = PSCompanyTaskType(rawValue: rawTaskTypeValue)
        imageData           <- map["image_data"]
    }
}
