import Foundation
import Alamofire
import PayseraCommonSDK

public class MokejimaiApiClientFactory {
    public static func createTransferApiClient(
        headers: MokejimaiRequestHeaders,
        credentials: MokejimaiApiCredentials,
        tokenRefresher: TokenRefresherProtocol? = nil,
        logger: PSLoggerProtocol? = nil
    ) -> MokejimaiApiClient {
        let sessionManager = SessionManager()
        sessionManager.adapter = MokejimaiRequestAdapter(credentials: credentials, headers: headers)
        
        return MokejimaiApiClient(
            sessionManager: sessionManager,
            credentials: credentials,
            tokenRefresher: tokenRefresher,
            logger: logger
        )
    }
}
