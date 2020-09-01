//
//  ItemCell.swift
//  MarvelSuperHeroes
//
//  Created by Jose Pinto on 31/05/2020.
//  Copyright © 2020 Jose Pinto. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {

    let itemTitle = MarvelTitleLabel(textAlignment: .left, fontSize: 15)
    let itemDescription = MarvelBodyLabel(textAlignment: .left)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(item: Item) {
        itemTitle.text = item.title
        itemDescription.text = item.description ?? ""
    }
    
    private func configure() {
        itemTitle.numberOfLines = 0
        
        itemDescription.numberOfLines = 0
        itemDescription.lineBreakMode = .byTruncatingTail
        
        addSubview(itemTitle)
        addSubview(itemDescription)
        
        NSLayoutConstraint.activate([
            itemTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            itemTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            itemTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            itemTitle.bottomAnchor.constraint(equalTo: itemDescription.topAnchor, constant: -10),
            
            itemDescription.topAnchor.constraint(equalTo: itemTitle.bottomAnchor, constant: 10),
            itemDescription.leadingAnchor.constraint(equalTo: itemTitle.leadingAnchor),
            itemDescription.trailingAnchor.constraint(equalTo: itemTitle.trailingAnchor),
            itemDescription.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
        ])
    }
}
