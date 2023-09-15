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
    

    
    private lazy var icon: UIImageView = {
        let icon = UIImageView()
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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){

        self.roundCornersWithShadow([.bottomLeft,.topLeft,.topRight], radius: 16)
        
        self.backgroundColor = .white
        
        self.contentView.addSubviews(icon,label,nextVector)
        
        setupLayout()
    }
    
    func setupLayout(){
        
        icon.snp.makeConstraints({make in
            make.top.equalToSuperview().offset(17)
            make.leading.equalToSuperview().offset(16.51)
        })
        
        label.snp.makeConstraints({make in
            make.top.equalToSuperview().offset(18)
            make.leading.equalTo(icon.snp.trailing).offset(7.86)
        })
        
        nextVector.snp.makeConstraints({make in
            make.top.equalToSuperview().offset(19)
            make.trailing.equalToSuperview().offset(-16.42)
        })
    }
    
    func configure(data: Settings){
        label.text = data.labelName
        icon.image = UIImage(named: data.icon)
    }
    
}
