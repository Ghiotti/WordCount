//
//  Session.swift
//  WordCount
//
//  Created by Franco Ghiotti on 17/4/21.
//

import Foundation

class Session {
    
    static let shared = Session()
    
    private init() { }
    
    // MARK: Properties
    
    private var defaults: UserDefaults = .standard

    var files: [TxtFiles]? {
            get {
                if let userData = defaults.object(forKey: Constants.UserDefaults.filesKey) as? Data {
                    let decoder = JSONDecoder()
                    if let personDataDecode = try? decoder.decode([TxtFiles].self, from: userData) {
                        return personDataDecode
                    }
                }
                return nil
            }

            set(newValue) {
                let encoder = JSONEncoder()
                if let encoded = try? encoder.encode(newValue) {
                    defaults.set(encoded, forKey: Constants.UserDefaults.filesKey)
                }
            }
        }
}
