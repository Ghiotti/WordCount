//
//  SplashViewController.swift
//  WordCount
//
//  Created by Franco Ghiotti on 17/4/21.
//

import UIKit

class SplashViewController: BaseViewController {
    
    private lazy var showAppIcon = UIImageView(frame: .zero)
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let navigationController = UINavigationController(rootViewController: HomeViewController())
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true, completion: nil)
    }
}
