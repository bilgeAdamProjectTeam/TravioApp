//
//  AddNewPlaceCVC.swift
//  TravioApp
//
//  Created by Şevval Çakıroğlu on 29.08.2023.
//

import UIKit
import SnapKit


class AddNewPlaceCVC: UICollectionViewCell {
    
    private lazy var images : UIImageView = {
        let img = UIImageView()
        img.backgroundColor = .white
        img.layer.shadowColor = Color.darkGray.color.cgColor
        img.layer.shadowOffset = CGSize(width: 0, height: 0)
        img.layer.shadowOpacity = 0.15
        img.layer.shadowRadius = 4
        img.clipsToBounds = false
        img.layer.cornerRadius = 16
        img.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMinYCorner]
        img.contentMode = .scaleAspectFit
        
        
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
    
    private lazy var stackView : UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 10
        sv.distribution = .fill
        sv.alignment = .center
        
        
        return sv
    }()
    

    
    override init(frame: CGRect) {
        super .init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupView(){
        addSubviews(images, stackView)
        stackView.addArrangedSubviews(icon,iconLbl)
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

