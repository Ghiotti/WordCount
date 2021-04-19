//
//  UIView+ActivityIndicator.swift
//  WordCount
//
//  Created by Franco Ghiotti on 18/4/21.
//

import UIKit

var vSpinner : UIView?

extension UIView {

    func showSpinner() {
        vSpinner = UIView.init(frame: self.bounds)
        vSpinner?.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(style: .large)

        DispatchQueue.main.async {
            vSpinner?.addSubview(ai)

            guard let vSpinner = vSpinner else {
                return
            }

            self.addSubview(vSpinner)

            vSpinner.snp.makeConstraints { (make) in
                make.center.equalToSuperview()
                make.edges.equalToSuperview()
            }

            ai.snp.makeConstraints { (make) in
                make.center.equalToSuperview()
                make.edges.equalToSuperview()
            }
        }

        ai.startAnimating()
    }

    func hideSpinner() {
        DispatchQueue.main.async {
            vSpinner?.removeFromSuperview()
            vSpinner = nil
        }
    }
}
