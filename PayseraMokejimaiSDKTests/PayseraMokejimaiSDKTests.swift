import XCTest
import JWTDecode
import PromiseKit

@testable import PayseraMokejimaiSDK

class MokejimaiTokenTestRefresher: TokenRefresherProtocol {
    func refreshToken() -> Promise<Bool> {
        return Promise<Bool> { $0.reject(PSMokejimaiApiError.unauthorized()) }
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
        
        let filter = BaseFilter()
        filter.limit = 200
        
        mokejimaiApiClient
            .getManualTransferConfiguration(filter: filter)
            .done { response in
                transferConfigurations = response.items
            }.catch { error in
                print((error as? PSMokejimaiApiError)?.toJSON() ?? "")
            }.finally {
                expectation.fulfill()
            }
    
        wait(for: [expectation], timeout: 10.0)
        XCTAssertNotNil(transferConfigurations)
    }
    
    func createMokejimaiApiClient() -> MokejimaiApiClient {
        let mokejimaiToken = try? decode(jwt: jwtToken)
        let mokejimaiCredentials = MokejimaiApiCredentials(token: mokejimaiToken)
        
        return MokejimaiApiClientFactory.createTransferApiClient(
            mokejimaiRequestHeaders: MokejimaiRequestHeaders(headers: [.jwtToken(jwtToken), .acceptLanguage(language)]),
            credentials: mokejimaiCredentials,
            tokenRefresher: MokejimaiTokenTestRefresher()
        )
    }
}
