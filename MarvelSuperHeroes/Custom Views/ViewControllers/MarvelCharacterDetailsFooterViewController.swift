import UIKit

class MarvelCharacterDetailsFooterViewController : UIViewController {
    
    let elementsSegmentedControl = UISegmentedControl(items: ["Comics", "Events", "Stories", "Series"])
    let tableView = UIView()
    
    var itemsTable: MarvelCharacterItemsTableViewController!
    
    var character: Character!
    
    
    init(character: Character) {
        super.init(nibName: nil, bundle: nil)
        self.character = character
        itemsTable = MarvelCharacterItemsTableViewController(character: character)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        view.addSubview(elementsSegmentedControl)
        view.addSubview(tableView)
        add(childVC: itemsTable, to: tableView)
        
        let padding: CGFloat = 20
        
        elementsSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        let elementsSegmentedControlLeadingAnchorConstraint = elementsSegmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding)
        let itemsTableLeadingAnchorConstraint = tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding)
        let itemsTableTopAnchorConstraint = tableView.topAnchor.constraint(equalTo: elementsSegmentedControl.bottomAnchor, constant: padding)
        
        elementsSegmentedControlLeadingAnchorConstraint.priority = UILayoutPriority(750)
        itemsTableLeadingAnchorConstraint.priority = UILayoutPriority(750)
        itemsTableTopAnchorConstraint.priority = UILayoutPriority(750)
        
        NSLayoutConstraint.activate([
            elementsSegmentedControl.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            elementsSegmentedControlLeadingAnchorConstraint,
            elementsSegmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            
            itemsTableTopAnchorConstraint,
            itemsTableLeadingAnchorConstraint,
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding)
        ])
        
        elementsSegmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
        elementsSegmentedControl.selectedSegmentIndex = 0
    }
    
    @objc func segmentedControlValueChanged(_ segmentedControl: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            itemsTable.getComics()
        case 1:
            itemsTable.getEvents()
        case 2:
            itemsTable.getSeries()
        case 3:
            itemsTable.getStories()
        default:
            break
        }
    }
}
