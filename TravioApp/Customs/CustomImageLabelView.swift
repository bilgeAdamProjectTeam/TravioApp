//
//  CustomImageLabelView.swift
//  TravioApp
//
//  Created by Şevval Çakıroğlu on 7.09.2023.
//

import Foundation
import SnapKit
import UIKit

class CustomImageLabelView: UIView {
    
    
    lazy var icon: UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(named: "userRole")
        icon.contentMode = .scaleAspectFit
        return icon
    }()

    
   lazy var label: UILabel = {
        let label = UILabel()
        label.text = "Label"
        label.font =  Font.medium(size: 12).font
        label.textColor = Color.darkGray.color
        return label
    }()
    
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .white
        
        setupViews()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    func setupViews() {

        roundCornersWithShadow([.topLeft,.topRight,.bottomLeft], radius: 16)
        
        addSubviews(icon, label)
        
        setupLayouts()
    }
    
    func setupLayouts() {
        
        icon.snp.makeConstraints({make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-20)
        })
        
        label.snp.makeConstraints({make in
            make.centerY.equalTo(icon)
            make.leading.equalTo(icon.snp.trailing).offset(8)
            
        })
        
    }
}
