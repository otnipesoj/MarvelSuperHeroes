import UIKit

class CharacterCell: UICollectionViewCell {
    
    static let reuseId = "CharacterCell"
    
    var character: Character!
    
    let characterThumbnail = MarvelCharacterThumbnail(frame: .zero)
    let characterName = MarvelTitleLabel(textAlignment: .center, fontSize: 16)
    let favouriteButton = MarvelFavoriteButton(frame: .zero)
    
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
        characterThumbnail.downloadImage(from: character.thumbnail.fullPath(thumbnailSize: .standardXLarge))
        characterName.text = character.name
        
        if favouritesRepository.isFavourite(character: character.id) {
            favouriteButton.isHidden = false
        } else {
            favouriteButton.isHidden = true
        }
    }
    
    private func configure() {
        addSubview(characterThumbnail)
        addSubview(characterName)
        addSubview(favouriteButton)
        
        let padding: CGFloat = 8
        
        NSLayoutConstraint.activate([
            characterThumbnail.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            characterThumbnail.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            characterThumbnail.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            characterThumbnail.heightAnchor.constraint(equalTo: characterThumbnail.widthAnchor),
            
            characterName.topAnchor.constraint(equalTo: characterThumbnail.bottomAnchor, constant: 12),
            characterName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            characterName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            characterName.heightAnchor.constraint(equalToConstant: 20),
            
            favouriteButton.topAnchor.constraint(equalTo: characterThumbnail.topAnchor, constant: -6),
            favouriteButton.leadingAnchor.constraint(equalTo: characterThumbnail.leadingAnchor, constant: -6),
            favouriteButton.widthAnchor.constraint(equalToConstant: 20),
            favouriteButton.heightAnchor.constraint(equalTo: favouriteButton.widthAnchor)
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
            
            favouriteButton.isHidden = !favouriteButton.isHidden
        }
    }
}
