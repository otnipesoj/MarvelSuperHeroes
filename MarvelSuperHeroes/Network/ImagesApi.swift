import UIKit

class ImagesApi : ApiClient {
    let session: URLSession
    
    private let cache = NSCache<NSString, UIImage>()
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func downloadImage(from url: String, completed: @escaping (UIImage?) -> Void) {
        let cacheKey = NSString(string: url)
        
        if let image = cache.object(forKey: cacheKey) {
            DispatchQueue.main.async {
                completed(image)
            }
            return
        }
        
        guard let url = URL(string: url) else {
            DispatchQueue.main.async {
                completed(nil)
            }
            return
        }
        
        let task = session.dataTask(with: url) { data, response, error in
            guard error == nil,
                let response = response as? HTTPURLResponse, response.statusCode == 200,
                let data = data,
                let image = UIImage(data: data) else {
                    DispatchQueue.main.async {
                        completed(nil)
                    }
                    return
            }
            
            self.cache.setObject(image, forKey: cacheKey)
            DispatchQueue.main.async {
                completed(image)
            }
        }
        
        task.resume()
    }
}
