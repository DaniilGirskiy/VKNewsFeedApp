import Foundation

public class VKAuthServiceAssembly {
    private static let service = AuthServiceImpl()
    
    public init() {}
    
    public func service(with configuration: AuthServiceConfiguration, controller: UIViewController) -> AuthService {
        let service = VKAuthServiceAssembly.service
        service.configuration = configuration
        service.controller = controller
        return service
    }
    
    public func service() -> AuthService {
        return VKAuthServiceAssembly.service
    }
}
