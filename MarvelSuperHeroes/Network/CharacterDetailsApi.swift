import Foundation

class CharacterDetailsApi : ApiClient {
    let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func getComics(containingCharacter characterId: Int, completed: @escaping(Result<ApiResponse<ApiItem>, MarvelError>) -> Void) {
        let endpoint = Endpoint.comics(containingCharacter: characterId)
        
        guard let url = endpoint.url else {
            completed(.failure(.invalidUrl))
            return
        }
        
        let request = URLRequest(url: url)
        perform(request: request, completed: parseDecodable(completed: completed))
    }
    
    func getEvents(containingCharacter characterId: Int, completed: @escaping(Result<ApiResponse<ApiItem>, MarvelError>) -> Void) {
        let endpoint = Endpoint.events(containingCharacter: characterId)
        
        guard let url = endpoint.url else {
            completed(.failure(.invalidUrl))
            return
        }
        
        let request = URLRequest(url: url)
        perform(request: request, completed: parseDecodable(completed: completed))
    }
    
    func getSeries(containingCharacter characterId: Int, completed: @escaping(Result<ApiResponse<ApiItem>, MarvelError>) -> Void) {
        let endpoint = Endpoint.series(containingCharacter: characterId)
        
        guard let url = endpoint.url else {
            completed(.failure(.invalidUrl))
            return
        }
        
        let request = URLRequest(url: url)
        perform(request: request, completed: parseDecodable(completed: completed))
    }
    
    func getStories(containingCharacter characterId: Int, completed: @escaping(Result<ApiResponse<ApiItem>, MarvelError>) -> Void) {
        let endpoint = Endpoint.stories(containingCharacter: characterId)
        
        guard let url = endpoint.url else {
            completed(.failure(.invalidUrl))
            return
        }
        
        let request = URLRequest(url: url)
        perform(request: request, completed: parseDecodable(completed: completed))
    }
}

extension CharacterDetailsApi {
    struct ApiItem: Codable {
        let title: String
        let description: String?
    }
}
