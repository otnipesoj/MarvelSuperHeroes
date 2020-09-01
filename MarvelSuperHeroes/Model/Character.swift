import Foundation

class Character {
    var id: Int
    var name: String
    var thumbnail: Thumbnail
    var comics: [Item]
    var events: [Item]
    var stories: [Item]
    var series: [Item]
    
    init(id: Int, name: String, thumbnail: Thumbnail) {
        self.id = id
        self.name = name
        self.thumbnail = thumbnail
        self.comics = []
        self.events = []
        self.stories = []
        self.series = []
    }
}

extension Character {
    convenience init(character: CharactersApi.ApiCharacter) {
        self.init(id: character.id, name: character.name, thumbnail: Thumbnail(thumbnail: character.thumbnail))
    }
}

extension Character : Hashable {
    static func == (lhs: Character, rhs: Character) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
    }
}
