import UIKit

class MarvelCharacterDetailsHeaderViewController: UIViewController {
    
    let characterThumbnail = MarvelCharacterThumbnail(frame: .zero)
    let characterNameLabel = MarvelTitleLabel(textAlignment: .center, fontSize: 20)
    let favouriteButton = MarvelFavoriteButton(frame: .zero)
    
    var character: Character!
    
    private let favouritesRepository: FavouritesRepository = FavouritesRepositoryUserDefaults(userDefaults: UserDefaults.standard)
    
    init(character: Character) {
        super.init(nibName: nil, bundle: nil)
        self.character = character
        setFavouriteState()
        configureGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(characterThumbnail)
        view.addSubview(characterNameLabel)
        view.addSubview(favouriteButton)
        
        let padding: CGFloat = 20
        
        characterThumbnail.downloadImage(from: character.thumbnail.fullPath(thumbnailSize: .landscapeXLarge))
        
        characterNameLabel.text = character.name
        characterNameLabel.numberOfLines = 0
        
        let characterThumbnailWidthAnchorConstraint = characterThumbnail.widthAnchor.constraint(equalToConstant: 150)
        let characterNameLabelLeadingAnchorConstraint = characterNameLabel.leadingAnchor.constraint(equalTo: characterThumbnail.trailingAnchor, constant: 12)
        characterThumbnailWidthAnchorConstraint.priority = UILayoutPriority(750)
        characterNameLabelLeadingAnchorConstraint.priority = UILayoutPriority(750)
        
        NSLayoutConstraint.activate([
            characterThumbnail.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            characterThumbnail.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            characterThumbnailWidthAnchorConstraint,
            characterThumbnail.heightAnchor.constraint(equalTo: view.heightAnchor),
            
            characterNameLabel.topAnchor.constraint(equalTo: characterThumbnail.topAnchor),
            characterNameLabelLeadingAnchorConstraint,
            characterNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            characterNameLabel.bottomAnchor.constraint(equalTo: characterThumbnail.bottomAnchor),
            
            favouriteButton.topAnchor.constraint(equalTo: characterThumbnail.topAnchor, constant: -6),
            favouriteButton.leadingAnchor.constraint(equalTo: characterThumbnail.leadingAnchor, constant: -6),
            favouriteButton.widthAnchor.constraint(equalToConstant: 20),
            favouriteButton.heightAnchor.constraint(equalTo: favouriteButton.widthAnchor)
        ])
    }
    
    private func setFavouriteState() {
        if favouritesRepository.isFavourite(character: character.id) {
            favouriteButton.isHidden = false
        } else {
            favouriteButton.isHidden = true
        }
    }
    
    private func configureGesture() {
        let recognizer = UILongPressGestureRecognizer(target: self, action: #selector(toggleFavourite))
        view.addGestureRecognizer(recognizer)
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
