//
//  ViewController.swift
//  WordCount
//
//  Created by Franco Ghiotti on 17/4/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        present(HomeViewController(), animated: true, completion: nil)
    }
}

