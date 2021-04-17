//
//  HomePresentert.swift
//  WordCount
//
//  Created by Franco Ghiotti on 17/4/21.
//

import Foundation

class HomePresenter {
    
    private let view: HomeDelegate
    private var txtFiles: [TxtFiles] = []
    
    init(view: HomeDelegate) {
        self.view = view
    }
    
    func numberOfFiles() -> Int {
        return txtFiles.count
    }
    
    func titleForRow(row: Int) -> String {
        return txtFiles[row].name
    }
    
    func fetchFiles() {
        guard let files = Session.shared.files else {
            view.didNotHaveAnyFile()
            
            return
        }
        
        if files.isEmpty {
            view.didNotHaveAnyFile()
            
            return
        }
        
        txtFiles = files
        view.didHaveAFiles()
    }
    
    func addButtonPressed() {
        view.showDataPicker()
    }
    
    func didGetNewDocument(url: URL?) {
        guard let url = url else {
            return
        }
        
        let name = url.lastPathComponent
        
        if txtIsAlreadyAdded(name: name) {
            showError(message: "Este archivo ya esta agregado, por favor selecciona otro")

            return
        }
                
        saveNewDocument(name: name, url: url)
    }
        
    private func showError(message: String) {
        view.didGetError(text: message)
    }
    
    private func txtIsAlreadyAdded(name: String) -> Bool {
        return txtFiles.contains { (txt) -> Bool in
            return txt.name == name
        }
    }
    
    private func saveNewDocument(name: String, url: URL) {
        do {
            let content = try String(contentsOf: url, encoding: .utf8)
            txtFiles.append(TxtFiles(url: url, name: name, content: content))
            Session.shared.files = txtFiles
            view.didAddNewFile()
        } catch {
            showError(message: "Ups, ha ocurrido un error, por favor intente con otro archivo")
        }
    }
}

protocol HomeDelegate: class {
    
    func showDataPicker()
    func didNotHaveAnyFile()
    func didHaveAFiles()
    func didAddNewFile()
    func didPressFile(text: String)
    func didGetError(text: String)
}
