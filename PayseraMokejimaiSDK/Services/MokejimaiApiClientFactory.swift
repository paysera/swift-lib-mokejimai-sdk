import Foundation
import Alamofire
import PayseraCommonSDK

public class MokejimaiApiClientFactory {
    public static func createTransferApiClient(
        headers: PSRequestHeaders,
        credentials: PSApiJWTCredentials,
        tokenRefresher: PSTokenRefresherProtocol? = nil,
        logger: PSLoggerProtocol? = nil
    ) -> MokejimaiApiClient {
        let sessionManager = SessionManager()
        sessionManager.adapter = PSRequestAdapter(credentials: credentials, headers: headers)
        
        return MokejimaiApiClient(
            sessionManager: sessionManager,
            credentials: credentials,
            tokenRefresher: tokenRefresher,
            logger: logger
        )
    }
}
