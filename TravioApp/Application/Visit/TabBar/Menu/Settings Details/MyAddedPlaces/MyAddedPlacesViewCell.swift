//
//  MyAddedNewCell.swift
//  TravioApp
//
//  Created by Şevval Çakıroğlu on 13.09.2023.
//

import UIKit
import SnapKit
import Kingfisher

class MyAddedPlacesViewCell: UICollectionViewCell {
    
    private lazy var view: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var image: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleToFill
        img.kf.indicatorType = .activity
        return img
    }()
    
    private lazy var placeName: UILabel = {
        let lbl = UILabel()
        lbl.font = Font.semiBold(size: 24).font
        lbl.textColor = Color.darkGray.color
        return lbl
    }()
    
    private lazy var cityName: UILabel = {
        let lbl = UILabel()
        lbl.font = Font.light(size: 14).font
        lbl.textColor = Color.darkGray.color
        return lbl
    }()
    
    private lazy var vectorIcon: UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(named: "SeeAllLocationIcon")
        icon.frame = CGRect(x: 0, y: 0, width: 9, height: 12)
        icon.tintColor = Color.darkGray.color
        return icon
    }()
   
    override init(frame: CGRect) {
        super .init(frame: frame)
        
        self.radiusWithShadow(corners: [.bottomLeft,.topLeft,.topRight])
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){
        
        self.backgroundColor = .clear
        
        self.contentView.addSubviews(view)
        
        view.addSubviews(image,
                         placeName,
                         cityName,
                         vectorIcon)
        
        setupLayout()

    }
    
    func setupLayout(){
        
        view.snp.makeConstraints({make in
            make.edges.equalToSuperview()
        })
        
        image.snp.makeConstraints({make in
            make.top.leading.bottom.equalToSuperview()
            make.trailing.equalTo(placeName.snp.leading).offset(-8)
        })
        
        placeName.snp.makeConstraints({make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(98)
        })
        
        vectorIcon.snp.makeConstraints({make in
            make.top.equalTo(placeName.snp.bottom).offset(3)
            make.leading.equalTo(placeName.snp.leading)
        })
        
        cityName.snp.makeConstraints({make in
            make.top.equalTo(placeName.snp.bottom)
            make.leading.equalTo(vectorIcon.snp.trailing).offset(6)
        })
    }
    
    func configure(data: HomePlace) {
        image.kf.setImage(with: URL(string: data.cover_image_url))
        placeName.text = data.title
        cityName.text = data.place
    }
}

