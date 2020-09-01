import Foundation

struct Item {
    let title: String
    let description: String?
}

extension Item {
    init(item: CharacterDetailsApi.ApiItem) {
        self.init(title: item.title, description: item.description)
    }
}
