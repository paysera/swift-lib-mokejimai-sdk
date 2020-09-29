import ObjectMapper
import PayseraCommonSDK

public class PSContactFilter: PSBaseFilter {
    public var userId: Int!
    
    public override func mapping(map: Map) {
        super.mapping(map: map)
        userId <- map["user_id"]
    }
}
