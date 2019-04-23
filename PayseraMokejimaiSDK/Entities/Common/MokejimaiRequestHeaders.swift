import ObjectMapper

public class MokejimaiRequestHeaders {
    public var headers: [URLRequestHeader]
    
    public init(headers: [URLRequestHeader]) {
        self.headers = headers
    }
    
    public func updateHeader(_ header: URLRequestHeader) {
        headers.removeAll(where: { $0.headerKey == header.headerKey })
        headers.append(header)
    }
}
