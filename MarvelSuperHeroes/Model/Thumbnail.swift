import Foundation

enum ThumbnailSize: String {
    case standardXLarge = "standard_xlarge"
    case landscapeXLarge = "landscape_xlarge"
    case landscapeIncredible = "landscape_incredible"
}

struct Thumbnail: Hashable {
    let path: String
    let imageExtension: String
    
    func fullPath(thumbnailSize: ThumbnailSize) -> String {
        return "\(path)/\(thumbnailSize.rawValue).\(imageExtension)"
    }
}

extension Thumbnail {
    init(thumbnail: CharactersApi.ApiThumbnail) {
        self.init(path: thumbnail.path, imageExtension: thumbnail.imageExtension)
    }
}
