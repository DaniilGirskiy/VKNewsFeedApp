import Foundation

public struct API {
    public static let scheme = "https"
    public static let host = "api.vk.com"
    public static let version = "5.103"
    
    // methods:
    public static let newsFeed = "/method/newsfeed.get"
    
}

public protocol NetworkService {
    func getData(token: String, method: String, params: [String : String], then: @escaping (FeedResponse) -> Void)
}

class NetworkServiceImpl: NetworkService {
    
    func getData(token: String, method: String, params: [String : String], then: @escaping (FeedResponse) -> Void) {
        var allParams = params
        allParams["access_token"] = token
        allParams["v"] = API.version
        let url = self.getURL(from: method, params: allParams)
        print(url)
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                
                guard let data = data else { return }
                
                do {
                    let response = try JSONDecoder().decode(FeedResponseWrapped.self, from: data)
                    then(response.response)
                } catch {
                    print(error)
                    then(FeedResponse(items: [], profiles: [], groups: []))
                }
                
            }
        }.resume()
    }
    
    private func getURL(from path: String, params: [String : String]) -> URL {
        var components = URLComponents()
        
        components.scheme = API.scheme
        components.host = API.host
        components.path = path
        components.queryItems = params.map { URLQueryItem(name: $0, value: $1) }
    
        return components.url!
    }
    
    
    
    
    
}
