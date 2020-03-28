import ObjectMapper

public class PSAddress: Mappable {
    public internal(set) var type: String!
    public internal(set) var countryCode: String!
    public internal(set) var countryName: String!
    public internal(set) var cityName: String!
    public internal(set) var transliteratedCityName: String!
    public internal(set) var postalCode: String!
    public internal(set) var legacyAddress: String!
    public internal(set) var streetName: String!
    public internal(set) var houseNumber: String!
    public internal(set) var apartmentNumber: String!

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
