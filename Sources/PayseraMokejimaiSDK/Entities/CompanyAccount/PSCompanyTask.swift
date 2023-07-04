import ObjectMapper

public class PSCompanyTask: Mappable {
    public var id: String!
    public var countryCode: String!
    public var solution: String!

    public init(id: String, countryCode: String, solution: String) {
        self.id = id
        self.countryCode = countryCode
        self.solution = solution
    }
    
    required public init?(map: Map) {}
    
    public func mapping(map: Map) {
        id                  <- map["id"]
        countryCode         <- map["country_code"]
        solution            <- map["solution"]
    }
}
