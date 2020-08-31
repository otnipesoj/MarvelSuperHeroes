import UIKit

class NetworkManager {
    static let shared = NetworkManager()
    
    private let cache = NSCache<NSString, UIImage>()
    
    private init() {}
    
    func getCharacters(page: Int, matching name: String?, completed: @escaping (Result<MarvelResponse<Character>, MarvelError>) -> Void) {
        let endpoint = Endpoint.characters(page: page, matching: name)
        getData(from: endpoint, completed: completed)
    }
    
    func getComics(containingCharacter characterId: Int, completed: @escaping(Result<MarvelResponse<Item>, MarvelError>) -> Void) {
        let endpoint = Endpoint.comics(containingCharacter: characterId)
        getData(from: endpoint, completed: completed)
    }
    
    func getEvents(containingCharacter characterId: Int, completed: @escaping(Result<MarvelResponse<Item>, MarvelError>) -> Void) {
        let endpoint = Endpoint.events(containingCharacter: characterId)
        getData(from: endpoint, completed: completed)
    }
    
    func getSeries(containingCharacter characterId: Int, completed: @escaping(Result<MarvelResponse<Item>, MarvelError>) -> Void) {
        let endpoint = Endpoint.series(containingCharacter: characterId)
        getData(from: endpoint, completed: completed)
    }
    
    func getStories(containingCharacter characterId: Int, completed: @escaping(Result<MarvelResponse<Item>, MarvelError>) -> Void) {
        let endpoint = Endpoint.stories(containingCharacter: characterId)
        getData(from: endpoint, completed: completed)
    }
    
    func downloadImage(from url: String, completed: @escaping (UIImage?) -> Void) {
        let cacheKey = NSString(string: url)
        
        if let image = cache.object(forKey: cacheKey) {
            completed(image)
            return
        }
        
        guard let url = URL(string: url) else {
            completed(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil,
                let response = response as? HTTPURLResponse, response.statusCode == 200,
                let data = data,
                let image = UIImage(data: data) else {
                    completed(nil)
                    return
            }
            
            self.cache.setObject(image, forKey: cacheKey)
            completed(image)
        }
        
        task.resume()
    }
    
    private func getData<T:Decodable>(from endpoint: Endpoint, completed: @escaping(Result<T, MarvelError>) -> Void) {
        guard let url = endpoint.url else {
            completed(.failure(.invalidUrl))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let response = try decoder.decode(T.self, from: data)
                completed(.success(response))
                return
            } catch {
                completed(.failure(.invalidData))
                return
            }
        }
        
        task.resume()
    }
}
