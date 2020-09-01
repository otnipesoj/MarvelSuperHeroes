//
//  MarvelDataLoadingViewController.swift
//  MarvelSuperHeroes
//
//  Created by Jose Pinto on 23/05/2020.
//  Copyright © 2020 Jose Pinto. All rights reserved.
//

import UIKit

class MarvelDataLoadingViewController: UIViewController {

    var containerView: UIView!
    
    func showLoadingView() {
        containerView = UIView(frame: .zero)
        view.addSubview(containerView)
        
        containerView.backgroundColor = .systemBackground
        containerView.alpha = 0
        
        UIView.animate(withDuration: 0.25) { self.containerView.alpha = 0.8 }
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        containerView.pinToEdges(of: view)
        containerView.addSubview(activityIndicator)
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        ])
        
        activityIndicator.startAnimating()
    }

    func dismissLoadingView() {
        DispatchQueue.main.async {
            self.containerView.removeFromSuperview()
            self.containerView = nil
        }
    }
}
