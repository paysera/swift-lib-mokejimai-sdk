import XCTest
import JWTDecode
import PayseraCommonSDK
import PromiseKit

@testable import PayseraMokejimaiSDK

class PayseraMokejimaiSDKTests: XCTestCase {
    private let jwtToken = "insert_me"
    private let language = "en"
    
    func testGetManualTransferConfiguration() {
        var transferConfigurations: [PSManualTransferConfiguration]?
        let expectation = XCTestExpectation(description: "Manual Transfer Configuration should be not nil")
        
        let mokejimaiApiClient = createMokejimaiApiClient()
        
        let filter = PSBaseFilter()
        filter.limit = 200
        
        mokejimaiApiClient
            .getManualTransferConfiguration(filter: filter)
            .done { response in
                transferConfigurations = response.items
            }.catch { error in
                print((error as? PSApiError)?.toJSON() ?? "")
            }.finally {
                expectation.fulfill()
            }
    
        wait(for: [expectation], timeout: 10.0)
        XCTAssertNotNil(transferConfigurations)
    }
    
    func createMokejimaiApiClient() -> MokejimaiApiClient {
        let mokejimaiToken = try? decode(jwt: jwtToken)
        let credentials = PSApiJWTCredentials(token: mokejimaiToken)
        
        return MokejimaiApiClientFactory.createTransferApiClient(
            headers: PSRequestHeaders(headers: [.acceptLanguage(language)]),
            credentials: credentials
        )
    }
}
