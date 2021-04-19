//
//  HomePresentert.swift
//  WordCount
//
//  Created by Franco Ghiotti on 17/4/21.
//

import Foundation

class HomePresenter {
    
    private let view: HomeDelegate
    private var txtFiles: [TxtFile] = []
    
    // MARK: - Init
    
    init(view: HomeDelegate) {
        self.view = view
    }
    
    // MARK: - Public Methods

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
            showError(message: "home_file_already_added".localized)

            return
        }
                
        saveNewDocument(name: name, url: url)
    }
    
    func didSelectFile(fileNumber: Int) {
        let file = txtFiles[fileNumber]
        view.didPressFile(file: file)
    }
        
    // MARK: - Private Methods

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
            var content = try String(contentsOf: url, encoding: .utf8)
            content = content.replacingOccurrences(of: "\n", with: " ")
            content = content.replacingOccurrences(of: "\r", with: " ")
            content = content.replacingOccurrences(of: "\\u", with: " ")
            txtFiles.append(TxtFile(url: url, name: name, content: content))
            Session.shared.files = txtFiles
            view.didAddNewFile()
        } catch {
            showError(message: "home_error_generic".localized)
        }
    }
}

protocol HomeDelegate: class {
    
    func showDataPicker()
    func didNotHaveAnyFile()
    func didHaveAFiles()
    func didAddNewFile()
    func didPressFile(file: TxtFile)
    func didGetError(text: String)
}
