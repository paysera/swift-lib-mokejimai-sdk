import ObjectMapper
import PayseraCommonSDK

public class PSAvailableIdentityDocumentsFilter: PSBaseFilter {
    public var country: String?
    public var userId: String?
    
    public override func mapping(map: Map) {
        super.mapping(map: map)
        country       <- map["country"]
        userId        <- map["user_id"]
    }
}
