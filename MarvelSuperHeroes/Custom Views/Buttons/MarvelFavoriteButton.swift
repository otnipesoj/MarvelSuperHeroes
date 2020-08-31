import UIKit

class MarvelFavoriteButton : UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        setImage(UIImage(systemName: "heart.fill"), for: .normal)
        tintColor = .systemRed
        translatesAutoresizingMaskIntoConstraints = false
    }
}
