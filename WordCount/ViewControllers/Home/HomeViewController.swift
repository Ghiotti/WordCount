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
            make.bottom.equalTo(view.snp.bottom).inset(40)
            make.trailing.equalToSuperview().inset(20)
        }
    }
    
    override func addConfiguration() {
        filesTableView.delegate = self
        filesTableView.dataSource = self

        presenter = HomePresenter(view: self)
        emptyFilesLabel.text = "home_emprty_files".localized
        addNewFileButton.addTarget(self, action:#selector(addButtonWasPresed), for: .touchUpInside)
        
        presenter.fetchFiles()
    }
    
    override func addStyle() {
        navigationController?.navigationBar.barTintColor = .primary

        emptyFilesLabel.isHidden = true
        addNewFileButton.setImage(HomeAssets.addButton.image, for: .normal)
        filesTableView.tableFooterView = UIView()
    }
    
    
    // MARK: - Private Methods

    private func perfomDataPicker() {
        let supportedTypes: [UTType] = [UTType.text]
        let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: supportedTypes, asCopy: true)
        documentPicker.allowsMultipleSelection = false
        documentPicker.delegate = self
        
        present(documentPicker, animated: true, completion: nil)
    }
    
    @objc private func addButtonWasPresed() {
        presenter.addButtonPressed()
    }
}

// MARK: - UIDocumentPickerDelegate

extension HomeViewController: UIDocumentPickerDelegate {
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        presenter.didGetNewDocument(url: urls.first)
    }
}

// MARK: - HomeDelegate
extension HomeViewController: HomeDelegate {
    
    func didGetError(text: String) {
        let alertView = UIAlertController(title: "Error", message: text, preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: "Acept", style: .default, handler: nil))
        
        present(alertView, animated: true, completion: nil)
    }
    
    func didAddNewFile() {
        emptyFilesLabel.isHidden = true
        filesTableView.reloadData()
    }
    
    func showDataPicker() {
        self.perfomDataPicker()
    }
    
    func didNotHaveAnyFile() {
        emptyFilesLabel.isHidden = false
    }
    
    func didHaveAFiles() {
        emptyFilesLabel.isHidden = true
        filesTableView.reloadData()
    }
    
    func didPressFile(file text: TxtFile) {
        let detailViewController = FileDetailViewController()
        detailViewController.fileDetail = text
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}

// MARK: - UITableViewDelegate

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectFile(fileNumber: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - UITableViewDataSource

extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfFiles()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = presenter.titleForRow(row: indexPath.row)
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
}
