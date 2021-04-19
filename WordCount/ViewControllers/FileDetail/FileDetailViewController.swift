//
//  FileDetailViewController.swift
//  WordCount
//
//  Created by Franco Ghiotti on 18/4/21.
//

import UIKit

class FileDetailViewController: BaseViewController {
    
    // MARK: - Properties
    
    private lazy var numberOfWordsTitle = UILabel(frame: .zero)
    private lazy var wordsCountLabel = UILabel(frame: .zero)
    private lazy var wordsCountStackView = UIStackView(frame: .zero)
    
    private lazy var searchBar = UISearchBar(frame: .zero)
    private lazy var selectFilterView = SorterButtonsView(frame: .zero)
    private lazy var wordsDetailTableView = UITableView(frame: .zero)
    
    private var presenter: FileDetailPresenter!
    
    private var defaultIdentifier = "DefaultCell"
    
    var fileDetail: TxtFile!

    // MARK: - BaseViewController

    override func addSubviews() {
        view.addSubview(wordsCountStackView)
        view.addSubview(searchBar)
        view.addSubview(selectFilterView)
        view.addSubview(wordsDetailTableView)
        
        wordsCountStackView.addArrangedSubview(numberOfWordsTitle)
        wordsCountStackView.addArrangedSubview(wordsCountLabel)
    }
    
    override func addConstraints() {
        wordsCountStackView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(16)
            make.top.equalTo(view.snp.top).inset(100)
        }
        
        searchBar.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(16)
            make.top.equalTo(wordsCountStackView.snp.bottom).offset(20)
            make.height.equalTo(50)
        }
        
        selectFilterView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(16)
            make.top.equalTo(searchBar.snp.bottom).offset(40)
        }
        
        wordsDetailTableView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(16)
            make.top.equalTo(selectFilterView.snp.bottom).offset(20)
            make.bottom.equalTo(view.snp.bottom)
        }
    }
    
    override func addConfiguration() {
        wordsDetailTableView.register(UITableViewCell.self, forCellReuseIdentifier: defaultIdentifier)

        presenter = FileDetailPresenter(view: self, file: fileDetail)
        
        wordsCountStackView.axis = .vertical
        
        wordsDetailTableView.dataSource = self
        searchBar.delegate = self
        
        selectFilterView.sorterAlphabeticallyButton.addTarget(self, action:#selector(sortByAlphabeticallyWasPressed), for: .touchUpInside)
        selectFilterView.sorterByNumberOAappearancesButton.addTarget(self, action:#selector(sortByNumberOfApparencesWasPressed), for: .touchUpInside)
        
        wordsDetailTableView.tableFooterView = UIView()
        
        numberOfWordsTitle.text = "Número de palabras: "
    }
    
    override func addStyle() {
        view.backgroundColor = .white
        wordsDetailTableView.allowsSelection = false
    }
    
    // MARK: - Private Methods

    @objc private func sortByAlphabeticallyWasPressed() {
        selectFilterView.sorterAlphabeticallyButton.isSelected = true
        selectFilterView.sorterByNumberOAappearancesButton.isSelected = false
        presenter.sorterAlphabetically()
    }
    
    @objc private func sortByNumberOfApparencesWasPressed() {
        selectFilterView.sorterAlphabeticallyButton.isSelected = false
        selectFilterView.sorterByNumberOAappearancesButton.isSelected = true
        presenter.sorterNumberOfAparitionsWasPressed()
    }
}

// MARK: - UITableViewDataSource

extension FileDetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: defaultIdentifier) else {
            return UITableViewCell(style: .value2, reuseIdentifier: self.defaultIdentifier)
        }
        
        let data = presenter.dataForRow(row: indexPath.row)
        cell.textLabel?.text = data.word
        cell.detailTextLabel?.text = data.number.description
        
        return cell
    }
}

// MARK: - UISearchBarDelegate

extension FileDetailViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter.filterByText(filter: searchText)
    }
}

// MARK: - FileDetailDelegate

extension FileDetailViewController: FileDetailDelegate {
    
    func willProccessFilter() {
        wordsDetailTableView.showSpinner()
    }
    
    func didEndProcessfilter() {
        wordsDetailTableView.hideSpinner()
    }
    
    func setUp(numberOfWords: Int) {
        wordsCountLabel.text = numberOfWords.description
    }
    
    func reloadData() {
        wordsDetailTableView.reloadData()
    }
}
