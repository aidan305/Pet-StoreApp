//
//  LoadingViewController.swift
//  Pet StoreApp
//
//  Created by aidan egan on 12/08/2020.
//  Copyright © 2020 aidan egan. All rights reserved.
//

import UIKit
import SwiftUI

class LoadingViewController: UIViewController {
    
    let loadingTextLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

        showModal()
    }
    
    func showModal() {
        view.backgroundColor = UIColor(white: 1, alpha: 0.5)
        view.isOpaque = false
        let loadingViewController = LoadingViewController()
        loadingViewController.modalPresentationStyle = .currentContext
        present(loadingViewController, animated: false, completion: nil)
    }
    
    func setupUI(){
        let spinner = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        spinner.transform = CGAffineTransform(scaleX: 3, y: 3)
        spinner.color = UIColor(named: "Primary Green")
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        view.addSubview(spinner)
        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

        loadingTextLabel.textColor = UIColor.black
        loadingTextLabel.text = "Processing..."
        loadingTextLabel.font = UIFont(name: "SanFranciscoDisplay-Regular", size: 30)
        loadingTextLabel.sizeToFit()
        loadingTextLabel.center = CGPoint(x: spinner.center.x, y: spinner.center.y + 30)
        spinner.addSubview(loadingTextLabel)
    }
}




