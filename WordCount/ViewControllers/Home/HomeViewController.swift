//
//  HomeViewController.swift
//  WordCount
//
//  Created by Franco Ghiotti on 17/4/21.
//

import UIKit
import UniformTypeIdentifiers
import SnapKit

class HomeViewController: BaseViewController {

    private lazy var filesTableView = UITableView(frame: .zero)
    private lazy var emptyFilesLabel = UILabel(frame: .zero)
    private lazy var addNewFileButton = UIButton(frame: .zero)
    
    private var presenter: HomePresenter!
    
    // MARK: - BaseViewController

    override func addSubviews() {
        view.addSubview(filesTableView)
        view.addSubview(emptyFilesLabel)
        view.addSubview(addNewFileButton)
    }
    
    override func addConstraints() {
        filesTableView.snp.makeConstraints { (make) in
            make.edges.equalTo(view.snp.edges)
        }
        
        emptyFilesLabel.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        
        addNewFileButton.snp.makeConstraints { (make) in
            make.height.width.equalTo(50)
            make.bottom.equalTo(view.snp.bottom).inset(16)
            make.trailing.equalToSuperview().inset(16)
        }
    }
    
    override func addConfiguration() {
        presenter = HomePresenter(view: self)
        emptyFilesLabel.text = "You don't have files press '+' to add one"
        addNewFileButton.addTarget(self, action:#selector(addButtonWasPresed), for: .touchUpInside)
        
        presenter.fetchFiles()
    }
    
    override func addStyle() {
        emptyFilesLabel.isHidden = true
//        addNewFileButton.setImage(HomeAssets.addButton.image, for: .normal)
        filesTableView.tableFooterView = UIView()
    }
    
    
    // MARK: - Private Methods

    private func perfomDataPicker() {
        let supportedTypes: [UTType] = [UTType.text]
        let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: supportedTypes, asCopy: true)
        documentPicker.allowsMultipleSelection = false
        documentPicker.delegate = self
        
        filesTableView.delegate = self
        filesTableView.dataSource = self

        present(documentPicker, animated: true, completion: nil)
    }
    
    @objc private func addButtonWasPresed() {
        presenter.addButtonPressed()
    }
}

// MARK: - UIDocumentPickerDelegate

extension HomeViewController: UIDocumentPickerDelegate {
    
    private func documentPicker(controller: UIDocumentPickerViewController, didPickDocumentAtURL url: NSURL) {
        debugPrint(url)
    }
}

// MARK: - HomeDelegate
extension HomeViewController: HomeDelegate {
    
    func showDataPicker() {
        self.perfomDataPicker()
    }
    
    func didNotHaveAnyFile() {
        emptyFilesLabel.isHidden = false
    }
    
    func didHaveAFiles() {
        emptyFilesLabel.isHidden = true
    }
    
    func didPressFile(text: String) {
        
    }
}

// MARK: - UITableViewDelegate

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

// MARK: - UITableViewDataSource

extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
