import UIKit

class MarvelFavouriteCharacter : UIView {
    
    var thumbnail = MarvelCharacterThumbnail(frame: .zero)
    let favourite = MarvelFavoriteButton(frame: .zero)
    
    var character: Character!
    
    private let favouritesRepository: FavouritesRepository = FavouritesRepositoryUserDefaults(userDefaults: UserDefaults.standard)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        configureGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(character: Character) {
        self.character = character
        thumbnail.downloadImage(from: self.character.thumbnail.fullPath(thumbnailSize: .standardXLarge))
        
        if favouritesRepository.isFavourite(character: self.character.id) {
            favourite.isHidden = false
        } else {
            favourite.isHidden = true
        }
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(thumbnail)
        addSubview(favourite)
        
        NSLayoutConstraint.activate([
            thumbnail.topAnchor.constraint(equalTo: topAnchor),
            thumbnail.leadingAnchor.constraint(equalTo: leadingAnchor),
            thumbnail.trailingAnchor.constraint(equalTo: trailingAnchor),
            thumbnail.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            favourite.topAnchor.constraint(equalTo: thumbnail.topAnchor, constant: -6),
            favourite.leadingAnchor.constraint(equalTo: thumbnail.leadingAnchor, constant: -6),
            favourite.widthAnchor.constraint(equalToConstant: 20),
            favourite.heightAnchor.constraint(equalTo: favourite.widthAnchor)
        ])
    }
    
    private func configureGesture() {
        let recognizer = UILongPressGestureRecognizer(target: self, action: #selector(toggleFavourite))
        self.addGestureRecognizer(recognizer)
    }
    
    @objc private func toggleFavourite(_ gestureRecognizer: UILongPressGestureRecognizer) {
        if gestureRecognizer.state == .began {
            let generator = UIImpactFeedbackGenerator(style: .medium)
            generator.impactOccurred()
            
            if favouritesRepository.isFavourite(character: character.id) {
                favouritesRepository.removeFromFavourites(character: character.id)
            } else {
                favouritesRepository.addToFavourites(character: character.id)
            }
            
            favourite.isHidden.toggle()
        }
    }
}
