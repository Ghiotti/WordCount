//
//  BaseViewController.swift
//  WordCount
//
//  Created by Franco Ghiotti on 17/4/21.
//

import UIKit

// MARK: - BaseViewControllerProtocol

protocol BaseViewControllerProtocol {
    func addSubviews()
    func addConstraints()
    func addStyle()
    func showLoader()
    func hideLoader()
}

// MARK: - BaseViewController

class BaseViewController: UIViewController, BaseViewControllerProtocol {
        
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addSubviews()
        addConstraints()
        addStyle()
        addConfiguration()
        
//        navigationItem.backButtonTitle = ""
    }
    
    open func addSubviews() { }
    
    open func addConstraints() { }
    
    open func addStyle() { }
    
    open func addConfiguration() { }
    
    func showLoader() {
        view.showSpinner()
    }
    
    func hideLoader() {
        view.hideSpinner()
    }
}
