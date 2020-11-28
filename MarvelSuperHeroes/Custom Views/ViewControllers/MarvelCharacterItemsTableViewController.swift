import UIKit

class MarvelCharacterItemsTableViewController : MarvelDataLoadingViewController {
    var character: Character!
    var itemsToDisplay: [Item] = []
    
    let tableView = UITableView()
    
    private let characterDetailsAPI = CharacterDetailsApi()
    
    init(character: Character) {
        super.init(nibName: nil, bundle: nil)
        self.character = character
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        layoutTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getComics()
    }
    
    private func configureTableView() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 600
        tableView.removeExcessCells()
        tableView.register(ItemCell.self, forCellReuseIdentifier: ItemCell.reuseIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func layoutTableView() {
        view.addSubview(tableView)
        tableView.pinToEdges(of: view)
    }
}

extension MarvelCharacterItemsTableViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsToDisplay.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ItemCell = tableView.dequeueReusableCell(for: indexPath)
        cell.set(item: itemsToDisplay[indexPath.row])
        return cell
    }
}

extension MarvelCharacterItemsTableViewController {
    func getComics() {
        guard character.comics.isEmpty else {
            itemsToDisplay = character.comics
            tableView.reloadData()
            return
        }
        
        showLoadingView()
        
        characterDetailsAPI.getComics(containingCharacter: character.id) { [weak self] result in
            guard let self = self else { return }
                self.dismissLoadingView()
    
                switch result {
                case .success(let response):
                    self.character.comics = response.data.results.map(Item.init)
                    self.itemsToDisplay = self.character.comics
                    self.tableView.reloadData()
                case .failure(let error):
                    self.presentAlertOnMainThread(title: "Error", message: error.rawValue, buttonTitle: "Ok")
                }
        }
    }
    
    func getEvents() {
        guard character.events.isEmpty else {
            itemsToDisplay = character.events
            tableView.reloadData()
            return
        }
        
        showLoadingView()
        
        characterDetailsAPI.getEvents(containingCharacter: character.id) { [weak self] result in
            guard let self = self else { return }
                self.dismissLoadingView()
    
                switch result {
                case .success(let response):
                    self.character.events = response.data.results.map(Item.init)
                    self.itemsToDisplay = self.character.events
                    self.tableView.reloadData()
                case .failure(let error):
                    self.presentAlertOnMainThread(title: "Error", message: error.rawValue, buttonTitle: "Ok")
                }
        }
    }
    
    func getSeries() {
        guard character.series.isEmpty else {
            itemsToDisplay = character.series
            tableView.reloadData()
            return
        }
        
        showLoadingView()
        
        characterDetailsAPI.getSeries(containingCharacter: character.id) { [weak self] result in
            guard let self = self else { return }
                self.dismissLoadingView()
    
                switch result {
                case .success(let response):
                    self.character.series = response.data.results.map(Item.init)
                    self.itemsToDisplay = self.character.series
                    self.tableView.reloadData()
                case .failure(let error):
                    self.presentAlertOnMainThread(title: "Error", message: error.rawValue, buttonTitle: "Ok")
                }
        }
    }
    
    func getStories() {
        guard character.stories.isEmpty else {
            itemsToDisplay = character.stories
            tableView.reloadData()
            return
        }
        
        showLoadingView()
        
        characterDetailsAPI.getStories(containingCharacter: character.id) { [weak self] result in
            guard let self = self else { return }
                self.dismissLoadingView()
    
                switch result {
                case .success(let response):
                    self.character.stories = response.data.results.map(Item.init)
                    self.itemsToDisplay = self.character.stories
                    self.tableView.reloadData()
                case .failure(let error):
                    self.presentAlertOnMainThread(title: "Error", message: error.rawValue, buttonTitle: "Ok")
                }
        }
    }
}
