import XCTest
import JWTDecode
import PayseraCommonSDK
import PromiseKit

@testable import PayseraMokejimaiSDK

class PayseraMokejimaiSDKTests: XCTestCase {
    private let jwtToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiJtb2tlamltYWkiLCJpc3MiOiJhdXRoX2FwaSIsImV4cCI6MTU3NjYyODgzOCwianRpIjoieUYwUFd4cHZ0QXh4cE5mSHNmMTVGcmFiS1Q5WVRNZDEiLCJwc3I6cyI6WyJsb2dnZWRfaW4iLCJjb25maXJtZWRfbG9nX2luIl0sInBzcjp1IjoiMTAxMjAwNyIsInBzcjpzaWQiOiJLb0d4OWh0d1YzdVFUVUVad3FlWDhBWkp5WDRGU3dRQiIsInBzcjphIjp7InVzZXJfaWQiOiIxMDEyMDA3In0sImlhdCI6MTU3NjU4NTYzOH0.ATogdC6ikHaOnZ02S9fPJVSCsdZZidNab4ItcUkglcHGtY3WhY9qszI66Og4OeNvdZv_eBYWZO0FBEH98pjoGQS9tTm1wLVvzQQChs3VlyKpq506W1lKxbtdUgAzCqn8QBrGSudE5KnJdQ7tpyzo8rvvHas7BZPBTktnGUS164JSm4kgA4B-2KPt_t_QxqXnjczMgNynHZoWCQig6KENoAkDBJnkhWYmVy7x7dk1F6MMag4XkgZwbD3zg-SSviBnyXfrSF9M3OQuwSx5fEBKki13fHQk0GvEbBIOe-_p_k0ErGkKlfvCL8tUflzvCWNVGNSWL9qVzqMn-4Lh7dvRZApxn1r0Rz7K0FQTDzXyWsAMm6CAmLTY1sfbXSag-phN_1KgItyzLgTzpn3EelDYX54piQSnTGtoIu9srOtOMfFacFLLB_EMjKxVO8sPwAXJ-s5QYEwj6q3GfeXvEnUZQx4XUtYsK7C4HnWaysdGFiWso2LlfB7GZs8py9O2N6W1kl8ySuiI_PkI4IDCJRJ-G-qXqr90Mzd4pnqBxEYupP0JzNp9UiXTS_PEDy68lZc42dVapzMpvRGgPTaeNwYq-A2HgULf7hx_7oaWM6zAUQU9BGPcvQGHfLEItqM8CXVTGsJ3WPb2c59P_q9MKo1WTGAtx6SLcphRtXPeApq7pY4"
    private let language = "en"

    func testSendLog() {
        let userId = "1012007"
        let appVersion = "6.0.0"
        
        let action = "app_unlocked"
        let context = ["app_version": appVersion]
        let expectation = XCTestExpectation(description: "")
            
        createMokejimaiApiClient()
            .sendLog(userId: userId, action: action, context: context)
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
