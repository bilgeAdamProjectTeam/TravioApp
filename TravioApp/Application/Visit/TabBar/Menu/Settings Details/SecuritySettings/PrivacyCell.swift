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
    
    weak var delegate: isOnSwitchDelegate?
    var index = 0
    
    private lazy var privacyView: CustomSwitchLabelView = {
        let customView = CustomSwitchLabelView()
        customView.labelText = "Camera"
        customView.backgroundColor = .white
        customView.toggleSwitch.addTarget(self, action: #selector(switchTapped), for: .valueChanged)
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
    
    @objc private func switchTapped(sender:UISwitch) {
        guard let delegate = delegate else { return }
        delegate.switchValueChanged(isOn: sender.isOn, sender: sender)
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
    
    func configure(data:PrivacyInfo, index: Int){
        
        privacyView.labelText = data.labelName
       
        
        privacyView.toggleSwitch.tag = index
//        if privacyView.toggleSwitch.isOn {
//            self.delegate?.switchValueChanged(isOn: true, index: index)
//        } else {
//            self.delegate?.switchValueChanged(isOn: false, index: index)
//        }
        
    }
    
    
}
