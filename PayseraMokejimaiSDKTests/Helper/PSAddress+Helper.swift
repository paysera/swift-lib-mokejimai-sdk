@testable import PayseraMokejimaiSDK

extension PSAddress {
    
    static let livingAddressKey = "living_address"
    
    class func createLivingAddress(
        countryCode: String,
        countryName: String?,
        cityName: String?,
        transliteratedCityName: String?,
        postalCode: String?,
        streetName: String?,
        houseNumber: String?,
        apartmentNumber: String?
    ) -> PSAddress {
        let address = PSAddress()
        address.type = livingAddressKey
        address.countryCode = countryCode
        address.countryName = countryName
        address.cityName = cityName
        address.transliteratedCityName = transliteratedCityName
        address.postalCode = postalCode
        address.streetName = streetName
        address.houseNumber = houseNumber
        address.apartmentNumber = apartmentNumber
        return address
    }
    
    func isEqual(_ address: PSAddress?) -> Bool {
        guard let address = address else {
            return false
        }
        return type == address.type
            && countryCode == address.countryCode
            && countryName == address.countryName
            && cityName == address.cityName
            && transliteratedCityName == address.transliteratedCityName
            && postalCode == address.postalCode
            && streetName == address.streetName
            && houseNumber == address.houseNumber
            && apartmentNumber == address.apartmentNumber
    }
    
    class func getLivingAddress(from addresses: [PSAddress]?) -> PSAddress? {
        return addresses?.first { $0.type == livingAddressKey }
    }
}
