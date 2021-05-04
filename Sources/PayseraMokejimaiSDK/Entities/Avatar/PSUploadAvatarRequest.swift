import ObjectMapper

public class PSUploadAvatarRequest: Mappable {
    public var userId: String!
    public var contents: String!

    public init(
        userId: String,
        contents: String
    ) {
        self.userId = userId
        self.contents = contents
    }
    
    required public init?(map: Map) {}
    
    public func mapping(map: Map) {
        userId      <- map["user_id"]
        contents    <- map["contents"]
    }
}
