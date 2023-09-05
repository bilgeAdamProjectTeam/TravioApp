//
//  PrivacyCell.swift
//  TravioApp
//
//  Created by Şevval Çakıroğlu on 5.09.2023.
//

import Foundation
import UIKit
import SnapKit



class PrivacyCell: UITableViewCell{
    
    
    private lazy var privacyView: CustomSwitchLabelView = {
        let customView = CustomSwitchLabelView()
        customView.labelText = "Camera"
        customView.backgroundColor = .white
        return customView
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
//        contentView.roundCorners(corners: [.topLeft,.topRight,.bottomLeft], radius: 16)
    }
    
    func setupView(){
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        //privacyView.roundCorners(corners: [.topLeft,.topRight,.bottomLeft], radius: 16)
        contentView.addSubviews(privacyView)
        setupLayout()
        
    }
    
    func setupLayout(){
        privacyView.snp.makeConstraints({make in
            //make.edges.equalToSuperview()
            make.top.equalToSuperview().offset(4)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.bottom.equalToSuperview().offset(-4)
        })
        
    }
    func configure(data:PrivacyInfo){
        
        privacyView.labelText = data.labelName
        privacyView.toggleSwitch.isOn = data.switchCheck
        
    }
    
    
}
