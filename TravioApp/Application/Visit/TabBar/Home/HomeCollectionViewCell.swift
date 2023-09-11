//
//  HomeCollectionViewCell.swift
//  TravioApp
//
//  Created by Şevval Çakıroğlu on 30.08.2023.
//


import UIKit
import SnapKit
import Kingfisher

class HomeCollectionViewCell: UICollectionViewCell {
    
    private lazy var images : UIImageView = {
        let img = UIImageView()
        img.backgroundColor = .darkGray
        img.contentMode = .scaleAspectFill
        return img
    }()
    
    private lazy var placeName: UILabel = {
        let lbl = UILabel()
        lbl.font = Font.semiBold(size: 24).font
        lbl.textColor = Color.lightGray.color
        return lbl
    }()
    
    private lazy var cityName: UILabel = {
        let lbl = UILabel()
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
        
        setupView()
    }
   
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){
        
        self.radiusWithShadow(corners: [.bottomLeft,.topLeft,.topRight])

        self.contentView.addSubviews(images)
        
        images.addSubviews(placeName,
                           vectorIcon,
                           cityName)

        setupLayout()
    }
    
    func setupLayout(){
        
        images.snp.makeConstraints({make in
            make.edges.equalToSuperview()
        })
        
        placeName.snp.makeConstraints({make in
            make.top.equalToSuperview().offset(116)
            make.bottom.equalToSuperview().offset(-26)
            make.leading.equalToSuperview().offset(16)
        })
        
        vectorIcon.snp.makeConstraints({make in
            make.top.equalTo(placeName.snp.bottom).offset(3)
            make.bottom.equalToSuperview().offset(-11)
            make.leading.equalToSuperview().offset(16)
        })

        cityName.snp.makeConstraints({make in
            make.top.equalToSuperview().offset(152)
            make.bottom.equalToSuperview().offset(-5)
            make.leading.equalToSuperview().offset(31)
        })
    }
    
    func configureCollectionViewCell(with place: HomePlace) {
        placeName.text = place.title
        cityName.text = place.place
        images.kf.setImage(with: URL(string: place.cover_image_url))
    }
}

