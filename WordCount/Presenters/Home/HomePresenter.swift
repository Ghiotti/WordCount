//
//  HomePresentert.swift
//  WordCount
//
//  Created by Franco Ghiotti on 17/4/21.
//

import Foundation

class HomePresenter {
    
    private let view: HomeDelegate
    
    init(view: HomeDelegate) {
        self.view = view
    }
    
    func fetchFiles() {
        view.didNotHaveAnyFile()
    }
    
    func addButtonPressed() {
        view.showDataPicker()
    }
}

protocol HomeDelegate: class {
    
    func showDataPicker()
    func didNotHaveAnyFile()
    func didHaveAFiles()
    func didPressFile(text: String)
}
