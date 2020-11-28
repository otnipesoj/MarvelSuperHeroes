import UIKit

class CharacterDetailsViewController: UIViewController {
    
    let headerView = UIView()
    let itemsView = UIView()
    
    var character: Character!
    
    weak var delegate: RefreshCharactersDataDelegate!
    
    init(character: Character) {
        super.init(nibName: nil, bundle: nil)
        self.character = character
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureUIElements()
        layoutUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        delegate.refreshData()
    }
        
    func configureViewController() {
        view.backgroundColor = .systemBackground
    }
    
    private func configureUIElements() {
        self.add(childVC: MarvelCharacterDetailsHeaderViewController(character: character), to: headerView)
        self.add(childVC: MarvelCharacterDetailsFooterViewController(character: character), to: itemsView)
    }
    
    private func layoutUI() {
        view.addSubview(headerView)
        view.addSubview(itemsView)
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        itemsView.translatesAutoresizingMaskIntoConstraints = false
        
        let padding: CGFloat = 20
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 120),
            
            itemsView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemsView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            itemsView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            itemsView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}
