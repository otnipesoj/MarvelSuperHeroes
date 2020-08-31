import Foundation

enum ThumbnailSize: String {
    case standardXLarge = "standard_xlarge"
    case landscapeXLarge = "landscape_xlarge"
    case landscapeIncredible = "landscape_incredible"
}

struct Thumbnail: Codable, Hashable {
    let path: String
    let imageExtension: String
    
    func fullPath(thumbnailSize: ThumbnailSize) -> String {
        return "\(path)/\(thumbnailSize.rawValue).\(imageExtension)"
    }
    
    enum CodingKeys: String, CodingKey {
        case path = "path"
        case imageExtension = "extension"
    }
}
