//
//  UITableViewExtensions.swift
//  MarvelSuperHeroes
//
//  Created by Jose Pinto on 27/06/2020.
//  Copyright © 2020 Jose Pinto. All rights reserved.
//

import UIKit

extension UITableView {
    
    func removeExcessCells() {
        tableFooterView = UIView(frame: .zero)
    }
    
}
