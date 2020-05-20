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
        let interceptor = PSRequestAdapter(credentials: credentials, headers: headers)
        let trustedSession = PSTrustedSession(
            interceptor: interceptor,
            hosts: ["bank.paysera.com"]
        )
        
        return MokejimaiApiClient(
            session: trustedSession,
            credentials: credentials,
            tokenRefresher: tokenRefresher,
            logger: logger
        )
    }
}
