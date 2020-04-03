import Foundation

public class VKNetworkServiceAssembly {
    public init() {}
    
    public var network: NetworkService {
        return NetworkServiceImpl()
    }
    
}
