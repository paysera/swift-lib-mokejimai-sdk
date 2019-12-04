import ObjectMapper

public class PSCompanyIdentifier: Mappable {
    public var countryCode: String!
    public var companyCode: String!

    public init(countryCode: String, companyCode: String) {
        self.countryCode = countryCode
        self.companyCode = companyCode
    }
    
    required public init?(map: Map) {
    }
    
    public func mapping(map: Map) {
        countryCode         <- map["country_code"]
        companyCode         <- map["company_code"]
    }
}
