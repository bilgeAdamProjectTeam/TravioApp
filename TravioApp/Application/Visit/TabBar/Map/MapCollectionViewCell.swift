//
//  MapCollectionViewCell.swift
//  TravioApp
//
//  Created by Şevval Çakıroğlu on 29.08.2023.
//

import UIKit
import SnapKit
import Kingfisher

class MapCollectionViewCell: UICollectionViewCell {
    
    private lazy var images : UIImageView = {
        let img = UIImageView()
        img.backgroundColor = .clear
        img.kf.indicatorType = .activity
        img.contentMode = .scaleAspectFill
        return img
    }()
    
    
    private lazy var placeName: UILabel = {
        let lbl = UILabel()
        lbl.text = "Süleymaniye Cami"
        lbl.font = Font.semiBold(size: 24).font
        lbl.textColor = Color.lightGray.color
        return lbl
    }()
    
    private lazy var cityName: UILabel = {
        let lbl = UILabel()
        lbl.text = "İstanbul"
        lbl.font = Font.light(size: 14).font
        lbl.textColor = Color.lightGray.color
        return lbl
    }()
    
    private lazy var vectorIcon: UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(named: "miniVector")
        return icon
    }()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        
        self.radiusWithShadow(corners: [.bottomLeft,.topLeft,.topRight])
        self.roundCorners(corners:  [.bottomLeft,.topLeft,.topRight], radius: 16)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews(){
        
        self.backgroundColor = .clear
        
        self.addSubviews(images)
        
        images.addSubviews(placeName,vectorIcon,cityName)

        setupLayout()
    }
    
    func setupLayout(){
        
        images.snp.makeConstraints({make in
            make.edges.equalToSuperview()
        })
        
        placeName.snp.makeConstraints({make in
            make.top.equalToSuperview().offset(113)
            make.leading.equalToSuperview().offset(22)
            make.bottom.equalToSuperview().offset(-29)

        })
        
        vectorIcon.snp.makeConstraints({make in
            make.top.equalTo(placeName.snp.bottom).offset(3)
            make.leading.equalTo(placeName.snp.leading)
            make.bottom.equalToSuperview().offset(-14)
        })

        cityName.snp.makeConstraints({make in
            make.top.equalTo(placeName.snp.bottom)
            make.leading.equalTo(vectorIcon.snp.trailing).offset(6)
            make.bottom.equalToSuperview().offset(-8)
        })
        
    }
    
    func configure(with places: Place){
            placeName.text = places.title
            cityName.text = places.place
        
        if let imageUrl = URL(string: places.coverImageURL!) {
            self.images.kf.setImage(with: imageUrl)
        }
    }
}

