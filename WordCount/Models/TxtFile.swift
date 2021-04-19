//
//  TxtFile.swift
//  WordCount
//
//  Created by Franco Ghiotti on 17/4/21.
//

import Foundation

class TxtFile: Decodable, Encodable {
    
    let url: URL
    let name: String
    let content: String
    
    init(url: URL,
         name: String,
         content: String) {
        
        self.url = url
        self.name = name
        self.content = content
    }
}
