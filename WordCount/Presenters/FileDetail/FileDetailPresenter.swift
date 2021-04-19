//
//  FileDetailPresenter.swift
//  WordCount
//
//  Created by Franco Ghiotti on 18/4/21.
//

import Foundation

class FileDetailPresenter {
    
    // MARK: - Properties
    
    private let view: FileDetailDelegate
    private let file: TxtFile
    private var filterdWords: [Filter] = []
    
    // MARK: - Init
    init(view: FileDetailDelegate, file: TxtFile) {
        self.view = view
        self.file = file
        
        processFile()
    }

    // MARK: - Public Methods

    func processFile() {
        filterdWords = []
        let words = file.content.split(separator: " ")
        for word in words {
            filterdWords.append(Filter(word: String(word), number: 1))
        }
        
        view.setUp(numberOfWords: words.count)
    }
    
    func sorterAlphabetically() {
        processFile()
        
        filterdWords = filterdWords.sorted { $0.word.lowercased() < $1.word.lowercased() }

        view.reloadData()
    }
    
    func sorterNumberOfAparitionsWasPressed() {
        processFile()
        view.willProccessFilter()
        
        filterdWords = sorterNumberOfAparitions(array: filterdWords)
        view.reloadData()
        view.didEndProcessfilter()
    }
    
    func filterByText(filter: String) {
        processFile()

        if filter.isEmpty {
            view.reloadData()
            
            return
        }
        
        filterdWords = filterdWords.filter({ (word) -> Bool in
            return word.word.contains(filter)
        })
                
        filterdWords = sorterNumberOfAparitions(array: filterdWords)

        view.reloadData()
    }
    
    func numberOfRows() -> Int {
        return filterdWords.count
    }
    
    func dataForRow(row: Int) -> Filter {
        return filterdWords[row]
    }

    // MARK: - Private Methods

    private func sorterNumberOfAparitions(array: [Filter]) -> [Filter] {
        var numberOfAparitons: [Filter] = []
        
        var map: [String: Int] = [:]
        
        for word in array {
            map[word.word] = (map[word.word] ?? 0) + 1
        }
        
        for item in map {
            numberOfAparitons.append(Filter(word: item.key, number: item.value))
        }

        numberOfAparitons.sort { (firstFilter, secondFilter) -> Bool in
            return firstFilter.number > secondFilter.number
        }

        return numberOfAparitons
    }
}

// MARK: - FileDetailDelegate

protocol FileDetailDelegate: class {
    
    func reloadData()
    func setUp(numberOfWords: Int)
    func willProccessFilter()
    func didEndProcessfilter()
}
