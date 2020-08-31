import Foundation

protocol FavouritesRepository {
    func addToFavourites(character id: Int)
    func removeFromFavourites(character id: Int)
    func isFavourite(character id: Int) -> Bool
    func save(character id: Int, asFavourite isFavourite: Bool)
}

class FavouritesRepositoryUserDefaults : FavouritesRepository {
    private let favouritesKey = "FavouriteCharacters"
    private let defaults: UserDefaults
    
    init(userDefaults: UserDefaults) {
        self.defaults = userDefaults
    }
    
    func addToFavourites(character id: Int) {
        var favouriteCharacters = getFavouriteCharacters()
        if !favouriteCharacters.contains(id) {
            favouriteCharacters.append(id)
        }
        save(favouriteCharacters)
    }
    
    func removeFromFavourites(character id: Int) {
        let favouriteCharacters = getFavouriteCharacters()
        guard !favouriteCharacters.isEmpty else { return }
        save(favouriteCharacters.filter{ $0 != id })
    }
    
    func isFavourite(character id: Int) -> Bool {
        return getFavouriteCharacters().contains(id)
    }
    
    func save(character id: Int, asFavourite isFavourite: Bool) {
        if isFavourite {
            addToFavourites(character: id)
        } else {
            removeFromFavourites(character: id)
        }
    }
    
    private func getFavouriteCharacters() -> [Int] {
        return defaults.array(forKey: favouritesKey) as? [Int] ?? []
    }
    
    private func save(_ favouriteCharacters: [Int]) {
        defaults.set(favouriteCharacters, forKey: favouritesKey)
    }
}

