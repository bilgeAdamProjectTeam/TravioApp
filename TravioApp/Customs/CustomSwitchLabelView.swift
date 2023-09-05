//
//  CustomSwitchLabelView.swift
//  TravioApp
//
//  Created by Şevval Çakıroğlu on 5.09.2023.
//

import Foundation

import SnapKit
import UIKit

class CustomSwitchLabelView: UIView {
    
    var labelText:String = "" {
        didSet {
            switchLabel.text = labelText
        }
    }


    private lazy var switchLabel: UILabel = {
        let label = UILabel()
        label.textColor = Color.darkGray.color
        label.font = Font.medium(size: 14).font
        label.textAlignment = .left
        return label
    }()
    
    private lazy var toggleSwitch: UISwitch = {
        let toggle = UISwitch()
        toggle.onTintColor = .systemGreen
        return toggle
    }()
    
    
    init() {
        super.init(frame: .zero)
        
        setupView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addShadow() {
        layer.shadowColor = Color.darkGray.color.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowOpacity = 0.15
        layer.shadowRadius = 4
        clipsToBounds = false
        layer.cornerRadius = 16
        layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
    
    func setupView() {
        
        addShadow()
        backgroundColor = .white
        addSubviews(switchLabel,toggleSwitch)
        
        setupLayouts()
    }
    
    func setupLayouts() {
        switchLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(25.51)
            make.leading.equalToSuperview().offset(16)
            //make.trailing.equalToSuperview().offset(-267)
            make.bottom.equalToSuperview().offset(-27.49)
        }
        
        toggleSwitch.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(21)
            //make.leading.equalTo(switchLabel.snp.trailing).offset(200)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-22)
        }
    }
}

