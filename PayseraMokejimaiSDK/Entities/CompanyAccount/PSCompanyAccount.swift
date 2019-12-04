import ObjectMapper

public class PSCompanyAccount: Mappable {
    public var name: String!
    public var countryCode: String!
    public var companyCode: String!

    public init() {}
    
    required public init?(map: Map) {
    }
    
    public func mapping(map: Map) {
        name                <- map["name"]
        countryCode         <- map["country_code"]
        companyCode         <- map["company_code"]
    }
}
