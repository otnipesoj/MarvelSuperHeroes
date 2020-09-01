import UIKit

class MarvelCharacterDetailsItemsViewController: MarvelDataLoadingViewController {
    
    let elementsSegmentedControl = UISegmentedControl(items: ["Comics", "Events", "Stories", "Series"])
    let itemsTable = UITableView()
    
    var character: Character!
    var itemsToDisplay: [Item] = []
    
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
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getComics()
    }
    
    private func configure() {
        view.addSubview(elementsSegmentedControl)
        view.addSubview(itemsTable)
        
        itemsTable.rowHeight = UITableView.automaticDimension
        itemsTable.estimatedRowHeight = 600
        itemsTable.dataSource = self
        itemsTable.delegate = self
        itemsTable.register(ItemCell.self, forCellReuseIdentifier: ItemCell.reuseIdentifier)
        itemsTable.removeExcessCells()
        
        let padding: CGFloat = 20
        
        elementsSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        itemsTable.translatesAutoresizingMaskIntoConstraints = false
        
        let elementsSegmentedControlLeadingAnchorConstraint = elementsSegmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding)
        let itemsTableLeadingAnchorConstraint = itemsTable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding)
        let itemsTableTopAnchorConstraint = itemsTable.topAnchor.constraint(equalTo: elementsSegmentedControl.bottomAnchor, constant: padding)
        elementsSegmentedControlLeadingAnchorConstraint.priority = UILayoutPriority(750)
        itemsTableLeadingAnchorConstraint.priority = UILayoutPriority(750)
        itemsTableTopAnchorConstraint.priority = UILayoutPriority(750)
        
        NSLayoutConstraint.activate([
            elementsSegmentedControl.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            elementsSegmentedControlLeadingAnchorConstraint,
            elementsSegmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            
            itemsTableTopAnchorConstraint,
            itemsTableLeadingAnchorConstraint,
            itemsTable.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            itemsTable.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding)
        ])
        
        elementsSegmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
        elementsSegmentedControl.selectedSegmentIndex = 0
    }
    
    @objc func segmentedControlValueChanged(_ segmentedControl: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            getComics()
        case 1:
            getEvents()
        case 2:
            getSeries()
        case 3:
            getStories()
        default:
            break
        }
    }
    
    private func getComics() {
        guard character.comics.isEmpty else {
            self.itemsToDisplay = character.comics
            DispatchQueue.main.async {
                self.itemsTable.reloadData()
                self.view.bringSubviewToFront(self.itemsTable)
            }
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
                    self.itemsTable.reloadData()
                    self.view.bringSubviewToFront(self.itemsTable)
                case .failure(let error):
                    self.presentAlertOnMainThread(title: "Error", message: error.rawValue, buttonTitle: "Ok")
                }
        }
    }
    
    private func getEvents() {
        guard character.events.isEmpty else {
            self.itemsToDisplay = character.events
            DispatchQueue.main.async {
                self.itemsTable.reloadData()
                self.view.bringSubviewToFront(self.itemsTable)
            }
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
                    self.itemsTable.reloadData()
                    self.view.bringSubviewToFront(self.itemsTable)
                case .failure(let error):
                    self.presentAlertOnMainThread(title: "Error", message: error.rawValue, buttonTitle: "Ok")
                }
        }
    }
    
    private func getSeries() {
        guard character.series.isEmpty else {
            self.itemsToDisplay = character.series
            DispatchQueue.main.async {
                self.itemsTable.reloadData()
                self.view.bringSubviewToFront(self.itemsTable)
            }
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
                    self.itemsTable.reloadData()
                    self.view.bringSubviewToFront(self.itemsTable)
                case .failure(let error):
                    self.presentAlertOnMainThread(title: "Error", message: error.rawValue, buttonTitle: "Ok")
                }
        }
    }
    
    private func getStories() {
        guard character.stories.isEmpty else {
            self.itemsToDisplay = character.stories
            DispatchQueue.main.async {
                self.itemsTable.reloadData()
                self.view.bringSubviewToFront(self.itemsTable)
            }
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
                    self.itemsTable.reloadData()
                    self.view.bringSubviewToFront(self.itemsTable)
                case .failure(let error):
                    self.presentAlertOnMainThread(title: "Error", message: error.rawValue, buttonTitle: "Ok")
                }
        }
    }
}

extension MarvelCharacterDetailsItemsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsToDisplay.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ItemCell = tableView.dequeueReusableCell(for: indexPath)
        cell.set(item: itemsToDisplay[indexPath.row])
        return cell
    }
}
