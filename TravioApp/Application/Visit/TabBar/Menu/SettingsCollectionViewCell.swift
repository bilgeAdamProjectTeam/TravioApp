//
//  SettingCollectionViewCell.swift
//  TravioApp
//
//  Created by Şevval Çakıroğlu on 4.09.2023.
//

import Foundation
import UIKit
import SnapKit

class SettingsCollectionViewCell: UICollectionViewCell {
    

    //nextvector
    
    private lazy var icon: UIImageView = {
        let icon = UIImageView()
        //icon.image = UIImage(named: "miniVector")
        icon.backgroundColor = .white
        icon.contentMode = .scaleAspectFit
        return icon
    }()
    
    private lazy var label: UILabel = {
        let lbl = UILabel()
        lbl.textColor = Color.darkGray.color
        lbl.font = Font.light(size: 14).font
        return lbl
    }()
    
    private lazy var nextVector: UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(named: "nextvector")
        return icon
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        addShadow()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addShadow(){
        layer.shadowColor = Color.darkGray.color.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowOpacity = 0.15
        layer.shadowRadius = 4
        clipsToBounds = false
        layer.cornerRadius = 16
        layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMinYCorner]
        roundCorners(corners: [.topLeft, .topRight, .bottomLeft], radius: 16)
        
    }
    
    func setupView(){

        backgroundColor = .white
        
        addSubviews(icon,label,nextVector)
        
        setupLayout()
        
    }
    
    func setupLayout(){
        
        icon.snp.makeConstraints({make in
            make.top.equalToSuperview().offset(17)
            make.leading.equalToSuperview().offset(16.51)
            make.trailing.equalToSuperview().offset(-320.86)
            make.bottom.equalToSuperview().offset(-17)
        })
        
        label.snp.makeConstraints({make in
            make.top.equalToSuperview().offset(18)
            make.leading.equalTo(icon.snp.trailing).offset(7.86)
            make.trailing.equalToSuperview().offset(-66)
            make.bottom.equalToSuperview().offset(-15)
        })
        
        nextVector.snp.makeConstraints({make in
            make.top.equalToSuperview().offset(19)
            make.leading.equalTo(label.snp.trailing).offset(39.18)
            make.trailing.equalToSuperview().offset(-16.42)
            make.bottom.equalToSuperview().offset(-19.37)
        })
        
        
        
    }
    
    func configure(data: Settings){
        
        label.text = data.labelName
        icon.image = UIImage(named: data.icon)
    }
    
}
