import XCTest
import JWTDecode
import PayseraCommonSDK
import PromiseKit

@testable import PayseraMokejimaiSDK

class MokejimaiTokenTestRefresher: TokenRefresherProtocol {
    func refreshToken() -> Promise<Bool> {
        return Promise<Bool> { $0.reject(PSApiError.unauthorized()) }
    }
    
    func isRefreshing() -> Bool {
        return false
    }
}

class PayseraMokejimaiSDKTests: XCTestCase {
    private let jwtToken = "change_me"
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
        let credentials = MokejimaiApiCredentials(token: mokejimaiToken)
        
        return MokejimaiApiClientFactory.createTransferApiClient(
            headers: MokejimaiRequestHeaders(headers: [.acceptLanguage(language)]),
            credentials: credentials,
            tokenRefresher: MokejimaiTokenTestRefresher()
        )
    }
}
