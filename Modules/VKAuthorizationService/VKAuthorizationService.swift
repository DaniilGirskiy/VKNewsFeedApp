import Foundation
import VK_ios_sdk

public protocol AuthService {
    var output: AuthServiceOutput? { get set }
    func start()
    
    var token: String? { get set }
    
//    func process(url: URL, fromApplication: String)
}

public protocol AuthServiceOutput {
    func goBackToVC()
}

public struct AuthServiceConfiguration {
    let appId: String
    let permissions: [String]
    
    public init(appId: String, permissions: [String]) {
        self.appId = appId
        self.permissions = permissions
    }
}

class AuthServiceImpl: NSObject, AuthService {
    var output: AuthServiceOutput?

    var token: String?
    var vkSdk: VKSdk?
    var configuration: AuthServiceConfiguration! // injected!
    weak var controller: UIViewController! // injected!
    
    
    func start() {
        vkSdk = VKSdk.initialize(withAppId: configuration.appId)
        vkSdk?.register(self)
        vkSdk?.uiDelegate = self
        
        VKSdk.wakeUpSession(configuration.permissions) { (state, error) in
            switch state {
            case .initialized:
                print("initialized")
                VKSdk.authorize(self.configuration.permissions)
            case .authorized:
                print("authorized")
                
                // callback:
                
                self.token = VKSdk.accessToken()?.accessToken
                
                self.output?.goBackToVC()
                
                // closure:
                
            default:
                break
            }
        }
    }
}

extension AuthServiceImpl: VKSdkDelegate {
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        print(#function)
        
        if result.token != nil {
            print("get token!")
        }
        
        self.token = VKSdk.accessToken()?.accessToken
        self.output?.goBackToVC()
    }
    
    func vkSdkUserAuthorizationFailed() {
        print(#function)
    }
    
    
}

extension AuthServiceImpl: VKSdkUIDelegate {
    func vkSdkShouldPresent(_ controller: UIViewController!) {
        print(#function)
        self.controller.present(controller, animated: true, completion: nil)
    }
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
        print(#function)
    }
    
    
}
