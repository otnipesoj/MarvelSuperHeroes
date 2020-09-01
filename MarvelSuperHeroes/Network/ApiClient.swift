import Foundation

protocol ApiClient {
    var session: URLSession { get }
}

extension ApiClient {
    func parseDecodable<T: Decodable>(completed: @escaping (Result<T, MarvelError>) -> Void) -> (Result<Data, MarvelError>) -> Void {
        return { result in
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let object = try decoder.decode(T.self, from: data)
                    DispatchQueue.main.async {
                        completed(.success(object))
                    }
                } catch {
                    DispatchQueue.main.async {
                        completed(.failure(.invalidData))
                    }
                }
                
            case .failure(let error):
                DispatchQueue.main.async {
                    completed(.failure(error))
                }
            }
        }
    }
    
    @discardableResult
    func perform(request: URLRequest, completed: @escaping (Result<Data, MarvelError>) -> Void) -> URLSessionDataTask {
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error as NSError? {
                if error.domain == NSURLErrorDomain && error.code == NSURLErrorCancelled {
                    return
                }
                
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
            
            completed(.success(data))
        }
        
        task.resume()
        return task
    }
}

struct ApiResponse<T: Codable>: Codable {
    let code : Int
    let status : String
    let data : ApiData<T>
}

struct ApiData<T: Codable>: Codable {
    let offset:  Int
    let limit: Int
    let total: Int
    let count: Int
    let results: [T]
}
