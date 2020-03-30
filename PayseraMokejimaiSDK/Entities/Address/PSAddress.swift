import ObjectMapper

public class PSAddress: Mappable {
    public var type: String = ""
    public var countryCode: String!
    public var countryName: String!
    public var cityName: String!
    public var transliteratedCityName: String!
    public var postalCode: String!
    public var legacyAddress: String!
    public var streetName: String!
    public var houseNumber: String!
    public var apartmentNumber: String!

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
