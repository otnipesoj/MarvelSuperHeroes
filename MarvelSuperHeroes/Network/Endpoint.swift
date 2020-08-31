import Foundation

struct Endpoint {
    var path: String
    var queryItems: [URLQueryItem] = []
}

extension Endpoint {
    private static let publicKey = "ed1e9c57464de5314611b7d2269480c2"
    private static let privateKey = "3e5bfbd79226966ce81045017e64c50c1dd8da62"
    
    private static let basePath = "/v1/public"
    
    var url: URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "gateway.marvel.com"
        urlComponents.port = 443
        urlComponents.path = Endpoint.basePath + "/" +  path
        urlComponents.queryItems = queryItems
        urlComponents.queryItems?.append(contentsOf: Endpoint.authQueryItems)
        
        return urlComponents.url
    }
    
    private static var authQueryItems: [URLQueryItem] {
        let timeStamp = String(Date().timeIntervalSince1970)
        let hash = generateHash(timeStamp: timeStamp)
        return [URLQueryItem(name: "ts", value: timeStamp), URLQueryItem(name: "hash", value: hash), URLQueryItem(name: "apikey", value: publicKey)]
    }
    
    private static func generateHash(timeStamp: String) -> String {
        return "\(timeStamp)\(privateKey)\(publicKey)".md5
    }
}

extension Endpoint {
    private static let pageSize = 20
    private static let itemsLimit = 3
    
    static func characters(page: Int) -> Self {
        Endpoint(path: "characters", queryItems: [URLQueryItem(name: "limit", value: String(pageSize)), URLQueryItem(name: "offset", value: String(page * pageSize))])
    }
       
    static func characters(page: Int, matching name: String?) -> Self {
        var queryItems = [URLQueryItem(name: "limit", value: String(pageSize)), URLQueryItem(name: "offset", value: String(page * pageSize))]
        
        if let name = name, !name.isEmpty {
            queryItems.append(URLQueryItem(name: "nameStartsWith", value: name))
        }
        
        return Endpoint(path: "characters", queryItems: queryItems)
    }
    
    static func comics(containingCharacter characterId: Int) -> Self {
        Endpoint(path: "characters/\(characterId)/comics", queryItems: [URLQueryItem(name: "limit", value: String(itemsLimit))])
    }
    
    static func events(containingCharacter characterId: Int) -> Self {
        Endpoint(path: "characters/\(characterId)/events", queryItems: [URLQueryItem(name: "limit", value: String(itemsLimit))])
    }
    
    static func series(containingCharacter characterId: Int) -> Self {
        Endpoint(path: "characters/\(characterId)/series", queryItems: [URLQueryItem(name: "limit", value: String(itemsLimit))])
    }
    
    static func stories(containingCharacter characterId: Int) -> Self {
        Endpoint(path: "characters/\(characterId)/stories", queryItems: [URLQueryItem(name: "limit", value: String(itemsLimit))])
    }
}
