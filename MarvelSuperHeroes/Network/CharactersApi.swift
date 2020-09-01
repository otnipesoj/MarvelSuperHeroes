import Foundation

class CharactersApi : ApiClient {
    let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func getCharacters(page: Int, matching name: String?, completed: @escaping (Result<ApiResponse<ApiCharacter>, MarvelError>) -> Void) {
        let endpoint = Endpoint.characters(page: page, matching: name)
        
        guard let url = endpoint.url else {
            completed(.failure(.invalidUrl))
            return
        }
        
        let request = URLRequest(url: url)
        perform(request: request, completed: parseDecodable(completed: completed))
    }
}

extension CharactersApi {
    struct ApiCharacter: Codable {
        let id: Int
        let name: String
        let thumbnail: ApiThumbnail
    }

    struct ApiThumbnail: Codable {
        let path: String
        let imageExtension: String
        
        enum CodingKeys: String, CodingKey {
            case path = "path"
            case imageExtension = "extension"
        }
    }
}
