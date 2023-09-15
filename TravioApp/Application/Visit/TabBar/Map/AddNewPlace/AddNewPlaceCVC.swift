//
//  AddNewPlaceCVC.swift
//  TravioApp
//
//  Created by Şevval Çakıroğlu on 29.08.2023.
//

import UIKit
import SnapKit


class AddNewPlaceCVC: UICollectionViewCell {
    
    
    lazy var images : UIImageView = {
        let img = UIImageView()
        img.backgroundColor = .clear
        img.contentMode = .scaleAspectFill
        img.roundCorners(corners:[.topLeft,.topRight,.bottomLeft], radius: 16)
        return img
    }()
    
    private lazy var icon : UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(named: "photo")
        icon.frame = CGRect(x: 0, y: 0, width: 40, height: 35)
        icon.contentMode = .scaleAspectFit
        return icon
    }()
    
    private lazy var iconLbl : UILabel = {
        let lbl = UILabel()
        lbl.text = "Add Photo"
        lbl.textColor = .systemGray
        lbl.font = Font.light(size: 12).font
        icon.frame = CGRect(x: 0, y: 0, width: 62, height: 18)
        return lbl
    }()
    
     lazy var stackView : UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 10
        sv.distribution = .fill
        sv.alignment = .center
        return sv
    }()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        
       //self.radiusWithShadow(corners: [.topLeft,.topRight,.bottomLeft])
        //self.contentView.roundCornersWithShadow([.topLeft,.topRight,.bottomLeft], radius: 16)
        
        setupViews()
    }
    
    required init?(coder : NSCoder) {
        super.init(coder: coder)
        
        self.setupViews()
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews(){
        
        self.contentView.roundCornersWithShadow([.topLeft,.topRight,.bottomLeft], radius: 16)
        
        self.contentView.backgroundColor = .white
        
        self.contentView.clipsToBounds = true
        
        self.contentView.addSubviews(images,
                         stackView)
        
        stackView.addArrangedSubviews(icon,
                                      iconLbl)
        setupLayout()
    }
    
    func setupLayout(){
        
        images.snp.makeConstraints({make in
            make.edges.equalToSuperview()
        })
        
        stackView.snp.makeConstraints({make in
            make.centerX.equalTo(images)
            make.centerY.equalTo(images)
        })
        
    }
    
}

