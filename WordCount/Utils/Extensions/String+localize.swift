//
//  String+localize.swift
//  WordCount
//
//  Created by Franco Ghiotti on 18/4/21.
//

import Foundation

extension String {

    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
