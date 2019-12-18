import XCTest
import JWTDecode
import PayseraCommonSDK
import PromiseKit

@testable import PayseraMokejimaiSDK

class PayseraMokejimaiSDKTests: XCTestCase {
    private let jwtToken = "insert_me"
    private let language = "en"

    func testLogAppUnlocks() {
        let userId = "insert_me"
        let appVersion = "insert_me"
        let expectation = XCTestExpectation(description: "")
            
        createMokejimaiApiClient()
            .logAppUnlocks(userId: userId, appVersion: appVersion)
            .done { response in
                print(response)
            }.catch { error in
                print((error as? PSApiError)?.toJSON() ?? "")
            }.finally { expectation.fulfill() }
        
        wait(for: [expectation], timeout: 5.0)
    }

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
    
    func testCreateCompanyAccount() {
        var companyAccount: PSCompanyAccount?
        var apiError: PSApiError?
        let userId: Int = 0 // change me
        let expectation = XCTestExpectation(description: "Get createCompanyAccount should return some response")
        let companyIdentifier = PSCompanyIdentifier(countryCode: "lt", companyCode: "300060819")
        
        createMokejimaiApiClient()
            .createCompanyAccount(userId: userId, companyIdentifier: companyIdentifier)
            .done { response in
                companyAccount = response
            }
            .catch { error in
                apiError = error as? PSApiError
                print(apiError?.toJSON() ?? "")
            }
            .finally {
                expectation.fulfill()
            }

        wait(for: [expectation], timeout: 10.0)
        
        XCTAssertNotNil(apiError)
        XCTAssertEqual(apiError?.error, "manager_name_mismatch")
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
