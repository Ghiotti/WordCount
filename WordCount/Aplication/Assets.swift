//
//  Assets.swift
//  WordCount
//
//  Created by Franco Ghiotti on 17/4/21.
//

import UIKit

protocol AssetsProvider {
    var name: String { get }
    var image: UIImage { get }
}

enum HomeAssets: String, AssetsProvider {
    case addButton = "HommeAddButton"

    var name: String { rawValue }
    var image: UIImage { UIImage(named: rawValue)! }
}

