//
//  SorterButtonsView.swift
//  WordCount
//
//  Created by Franco Ghiotti on 18/4/21.
//

import UIKit

class SorterButtonsView: BaseView {
    
    private lazy var sorterTitleLabel = UILabel(frame: .zero)
    
    private lazy var sorterStackView = UIStackView(frame: .zero)
    lazy var sorterAlphabeticallyButton = UIButton(frame: .zero)
    lazy var sorterByNumberOAappearancesButton = UIButton(frame: .zero)
    
    private lazy var mainStackView = UIStackView(frame: .zero)
    
    override func addSubviews() {
        addSubview(mainStackView)
        
        sorterStackView.addArrangedSubview(sorterAlphabeticallyButton)
        sorterStackView.addArrangedSubview(sorterByNumberOAappearancesButton)
        
        mainStackView.addArrangedSubview(sorterTitleLabel)
        mainStackView.addArrangedSubview(sorterStackView)
    }
    
    override func addConstraints() {
        mainStackView.snp.makeConstraints { (make) in
            make.left.top.right.bottom.equalToSuperview()
        }
    }
    
    override func addConfigurations() {
        mainStackView.axis = .vertical
        mainStackView.alignment = .center
        mainStackView.distribution = .fill
        mainStackView.spacing = 8
        
        sorterStackView.axis = .horizontal
        sorterStackView.distribution = .fill
        sorterStackView.spacing = 5
    }
    
    override func addStyle() {
        sorterAlphabeticallyButton.setTitle(" Alfabeticamente ", for: .normal)
        sorterAlphabeticallyButton.layer.cornerRadius = 12
        sorterAlphabeticallyButton.setTitleColor(.secondary, for: .selected)
        sorterAlphabeticallyButton.setTitleColor(.black, for: .normal)
        sorterAlphabeticallyButton.layer.borderWidth = 1
        sorterAlphabeticallyButton.layer.borderColor = UIColor.secondary.cgColor
        
        sorterByNumberOAappearancesButton.setTitle(" Numero de apariciones ", for: .normal)
        sorterByNumberOAappearancesButton.layer.cornerRadius = 12
        sorterByNumberOAappearancesButton.setTitleColor(.secondary, for: .selected)
        sorterByNumberOAappearancesButton.setTitleColor(.black, for: .normal)
        sorterByNumberOAappearancesButton.layer.borderWidth = 1
        sorterByNumberOAappearancesButton.layer.borderColor = UIColor.secondary.cgColor

        sorterTitleLabel.text = "Ordenar por: "
    }
}
