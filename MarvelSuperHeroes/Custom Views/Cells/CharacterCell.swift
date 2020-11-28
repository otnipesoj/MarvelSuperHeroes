import UIKit

class CharacterCell: UICollectionViewCell {
    
    let characterName = MarvelTitleLabel(textAlignment: .center, fontSize: 16)
    let favouriteCharacter = MarvelFavouriteCharacter(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(character: Character) {
        favouriteCharacter.set(character: character)
        characterName.text = character.name
    }
    
    private func configure() {
        addSubview(favouriteCharacter)
        addSubview(characterName)
        
        let padding: CGFloat = 8
        
        NSLayoutConstraint.activate([
            favouriteCharacter.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            favouriteCharacter.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            favouriteCharacter.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            favouriteCharacter.heightAnchor.constraint(equalTo: favouriteCharacter.widthAnchor),
            
            characterName.topAnchor.constraint(equalTo: favouriteCharacter.bottomAnchor, constant: 12),
            characterName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            characterName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            characterName.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}
