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
        img.layer.shadowColor = Color.darkGray.color.cgColor
        img.layer.shadowOffset = CGSize(width: 0, height: 0)
        img.layer.shadowOpacity = 0.15
        img.layer.shadowRadius = 4
        img.clipsToBounds = false
        img.layer.cornerRadius = 16
        img.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMinYCorner]
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
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){

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
            //make.trailing.equalToSuperview().offset(-132)

        })
        
        vectorIcon.snp.makeConstraints({make in
            make.top.equalToSuperview().offset(155)
            make.bottom.equalToSuperview().offset(-11)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-254)
        })

        cityName.snp.makeConstraints({make in
            make.top.equalToSuperview().offset(152)
            make.bottom.equalToSuperview().offset(-5)
            make.leading.equalToSuperview().offset(31)
            //make.trailing.equalToSuperview().offset(-207)
        })
        
    }
    
    func configureCC(with place: HomePlace) {
        placeName.text = place.title
        cityName.text = place.place
        images.kf.setImage(with: URL(string: place.cover_image_url))
    }
    
//    func configure(with data: Any) {
//        if let homeResponse = data as? HomeResponse {
//            guard let places = homeResponse.data.places.first else { return }
//            placeName.text = homeResponse.data.places.first?.title
//            cityName.text = homeResponse.data.places.first?.place
//            images.kf.setImage(with: URL(string: places.cover_image_url))
//        } else if let visitResponse = data as? VisitResponse {
//            placeName.text = visitResponse.data.place.title
//            cityName.text = visitResponse.data.place.place
//            images.kf.setImage(with: URL(string: visitResponse.data.place.cover_image_url))
//        }
//    }
}

