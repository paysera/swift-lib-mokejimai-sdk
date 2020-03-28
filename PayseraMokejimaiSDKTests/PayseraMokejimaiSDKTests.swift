import XCTest
import JWTDecode
import PayseraCommonSDK
import PromiseKit

@testable import PayseraMokejimaiSDK

class PayseraMokejimaiSDKTests: XCTestCase {
    private let jwtToken = "insert_me"
    private let language = "en"

    func testSendLog() {
        let userId = "insert_me"
        let appVersion = "insert_me"
        
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
    
    func testCreatingLithuanianCompanyAccount() {
        var companyAccount: PSCompanyAccount?
        var apiError: PSApiError?
        let userId: Int = 0 // change me
        let expectation = XCTestExpectation(description: "createCompanyAccount should return some response")
        let companyIdentifier = PSCompanyIdentifier(countryCode: "LT", companyCode: "300060819")
        
        createMokejimaiApiClient()
            .createCompanyAccount(userId: userId, using: .identifier(companyIdentifier))
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
    
    func testCreatinngBulgarianCompanyAccount() {
            var companyAccount: PSCompanyAccount?
            var apiError: PSApiError?
            var solutionError: PSCompanyTaskSolutionError?
            let userId: Int = 0 // change me
            let expectation = XCTestExpectation(description: "createCompanyAccount should return some response")
            let companyIdentifier = PSCompanyIdentifier(countryCode: "BG", companyCode: "204037635")
            
            createMokejimaiApiClient()
                .createCompanyAccount(userId: userId, using: .identifier(companyIdentifier))
                .done { response in
                    companyAccount = response
                }
                .catch { error in
                    apiError = error as? PSApiError
                    if let json = apiError?.data as? [String: Any] {
                        solutionError = PSCompanyTaskSolutionError(JSON: json)
                    }
                    print(apiError?.toJSON() ?? "")
                }
                .finally {
                    expectation.fulfill()
                }

            wait(for: [expectation], timeout: 10.0)
            
            XCTAssertNotNil(apiError)
            XCTAssertNotNil(solutionError)
            XCTAssertEqual(apiError?.error, "task_solution_required")
    }
    
    func testSolvingTask() {
        var companyAccount: PSCompanyAccount?
        var apiError: PSApiError?
        let userId: Int = 0 // change me
        let expectation = XCTestExpectation(description: "createCompanyAccount should return some response")
        let companyTask = PSCompanyTask(id: "5XMVigNsGD", countryCode: "BG", solution: "RYGG5")
        
        print(companyTask)
        
        createMokejimaiApiClient()
            .createCompanyAccount(userId: userId, using: .task(companyTask))
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
    
    func testGetUserAddresses() {
        var addresses: [PSAddress]?
        let expectation = XCTestExpectation(description: "User address must match with the user's country")
        let userId = 0
        let expectedCountry = "insert_me"
        
        createMokejimaiApiClient()
            .getUserAddresses(userId: userId)
            .done { response in
                addresses = response.items
            }.catch { error in
                print("Error: \((error as? PSApiError)?.toJSON() ?? [:])")
            }.finally {
                expectation.fulfill()
            }
        
        wait(for: [expectation], timeout: 10.0)
        XCTAssertEqual(addresses?.first?.countryCode, expectedCountry)
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
