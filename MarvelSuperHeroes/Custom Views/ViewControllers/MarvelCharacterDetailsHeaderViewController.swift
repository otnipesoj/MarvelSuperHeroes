import UIKit

class MarvelCharacterDetailsHeaderViewController: UIViewController {
    
    let characterNameLabel = MarvelTitleLabel(textAlignment: .center, fontSize: 20)
    let favouriteCharacter = MarvelFavouriteCharacter(frame: .zero)
    
    private let favouritesRepository: FavouritesRepository = FavouritesRepositoryUserDefaults(userDefaults: UserDefaults.standard)
    
    init(character: Character) {
        super.init(nibName: nil, bundle: nil)
        setCharacterInSubViews(character: character)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayout()
    }
    
    private func setCharacterInSubViews(character: Character) {
        favouriteCharacter.set(character: character)
        characterNameLabel.text = character.name
    }
    
    private func configureLayout() {
        view.addSubview(favouriteCharacter)
        view.addSubview(characterNameLabel)

        let padding: CGFloat = 20
        
        characterNameLabel.numberOfLines = 0
        
        let characterNameTrailingAnchorConstraint = characterNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
        characterNameTrailingAnchorConstraint.priority = UILayoutPriority(999)

        NSLayoutConstraint.activate([
              favouriteCharacter.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
              favouriteCharacter.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
              favouriteCharacter.heightAnchor.constraint(equalToConstant: 100),
              favouriteCharacter.widthAnchor.constraint(equalTo: favouriteCharacter.heightAnchor),
  
              characterNameLabel.topAnchor.constraint(equalTo: favouriteCharacter.topAnchor),
              characterNameLabel.leadingAnchor.constraint(equalTo: favouriteCharacter.trailingAnchor, constant: 12),
              characterNameTrailingAnchorConstraint,
              characterNameLabel.bottomAnchor.constraint(equalTo: favouriteCharacter.bottomAnchor),
        ])
    }
}
