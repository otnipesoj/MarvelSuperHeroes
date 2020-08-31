import Foundation

struct Character: Codable, Hashable {
    let id: Int
    let name: String
    let thumbnail: Thumbnail
}
