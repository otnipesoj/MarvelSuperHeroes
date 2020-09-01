import UIKit

class MarvelCharacterThumbnail: UIImageView {

    let placeholderImage = Images.placeholder
    
    let imagesApi = ImagesApi()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        layer.cornerRadius = 10
        clipsToBounds = true
        image = placeholderImage
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func downloadImage(from url: String) {
        imagesApi.downloadImage(from: url) { [weak self] image in
            guard let self = self else { return }
            self.image = image
        }
    }
}
