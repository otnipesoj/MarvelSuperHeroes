import UIKit

protocol RefreshCharactersDataDelegate: class {
    func refreshData()
}

class CharactersViewController: MarvelDataLoadingViewController {
    
    enum Section { case main }
    
    var characters: [Character] = []
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Character>!
    
    var page = 0
    var hasMoreCharacters = true
    var isLoadingMoreCharacters = false
    var isSearching = false
    
    var timer: Timer?
    
    init() {
        super.init(nibName: nil, bundle: nil)
        title = "Characters"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureSearchController()
        configureCollectionView()
        configureDataSource()
        getCharacters(page: page)
    }
      
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
//        navigationController?.delegate = self
    }
    
    private func configureSearchController() {
        let searchController = UISearchController()
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search for a name"
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
    }
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.configureThreeColumnFlowLayout(in: view))
        collectionView.register(CharacterCell.self, forCellWithReuseIdentifier: CharacterCell.reuseId)
        collectionView.backgroundColor = .systemBackground
        collectionView.delegate = self
        view.addSubview(collectionView)
    }
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Character>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, character) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterCell.reuseId, for: indexPath) as! CharacterCell
            cell.set(character: character)
            return cell;
        })
    }
    
    private func getCharacters(page: Int, characterName: String? = nil) {
        showLoadingView()
        isLoadingMoreCharacters = true
        
        NetworkManager.shared.getCharacters(page: page, matching: characterName) { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()
            
            switch result {
            case .failure(let error):
                self.presentAlertOnMainThread(title: "Error on getting characters", message: error.rawValue, buttonTitle: "ok")
                
            case .success(let response):
                self.updateUI(with: response.data.results)
            }
            
            self.isLoadingMoreCharacters = false
        }
    }
    
    private func updateUI(with characters: [Character]) {
        if characters.count < 20 { self.hasMoreCharacters = false }
        
        self.characters.append(contentsOf: characters)
        self.updateData(on: self.characters)
    }
    
    private func updateData(on characters: [Character]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Character>()
        snapshot.appendSections([.main])
        snapshot.appendItems(characters)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
}

extension CharactersViewController: UICollectionViewDelegate {

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            guard hasMoreCharacters, !isLoadingMoreCharacters else { return }
            page += 1
            getCharacters(page: page, characterName: navigationItem.searchController?.searchBar.text)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let character = characters[indexPath.item]
        
        let characterDetailsViewController = CharacterDetailsViewController(character: character)
        characterDetailsViewController.delegate = self
        present(characterDetailsViewController, animated: true)
//        navigationController?.pushViewController(characterDetailsViewController, animated: true)
    }
}

extension CharactersViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        timer?.invalidate()
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
            if searchText.isEmpty {
                if self.isSearching {
                    self.restartCharactersLoad()
                }
                
                return
            }

            self.isSearching = true
            self.hasMoreCharacters = true
            self.page = 0
            self.characters.removeAll()
            self.collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
            self.getCharacters(page: self.page, characterName: searchText)
        })
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        restartCharactersLoad()
    }
    
    private func restartCharactersLoad() {
        self.isSearching = false
        self.hasMoreCharacters = true
        self.page = 0
        self.characters.removeAll()
        self.collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
        self.getCharacters(page: self.page)
    }
}

//extension CharactersViewController: UINavigationControllerDelegate {
//    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
//        if viewController == self {
//            self.collectionView.reloadData()
//        }
//    }
//}

extension CharactersViewController: RefreshCharactersDataDelegate {
    func refreshData() {
        collectionView.reloadData()
    }
}
