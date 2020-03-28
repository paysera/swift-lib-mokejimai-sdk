import ObjectMapper

public class PSAddress: Mappable {
    public private(set) var type: String!
    public private(set) var countryCode: String!
    public private(set) var countryName: String!
    public private(set) var cityName: String!
    public private(set) var transliteratedCityName: String!
    public private(set) var postalCode: String!
    public private(set) var legacyAddress: String!
    public private(set) var streetName: String!
    public private(set) var houseNumber: String!
    public private(set) var apartmentNumber: String!

    public init() {}
    
    required public init?(map: Map) {
    }
    
    public func mapping(map: Map) {
        type <- map["type"]
        countryCode <- map["country_code"]
        countryName <- map["county_name"]
        cityName <- map["city_name"]
        transliteratedCityName <- map["transliterated_city_name"]
        postalCode <- map["postal_code"]
        legacyAddress <- map["legacy_address"]
        streetName <- map["street_name"]
        houseNumber <- map["house_number"]
        apartmentNumber <- map["apartment_number"]
    }
}
