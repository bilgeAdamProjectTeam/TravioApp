//
//  VisitsCVC.swift
//  TravioApp
//
//  Created by Şevval Çakıroğlu on 29.08.2023.
//


import UIKit
import SnapKit
import Kingfisher

class VisitsCVC: UICollectionViewCell {
    
    lazy var backgroundImage:UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.backgroundColor = .clear
        return img
    }()
    
    private lazy var locationImage:UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "Vector2")
        return img
    }()
    
    lazy var labelPlaceName:UILabel = {
        let lbl = UILabel()
        lbl.font =  Font.semiBold(size: 30).font
        lbl.textColor = .white
        return lbl
    }()
    
    lazy var labelLocationName:UILabel = {
        let lbl = UILabel()
        lbl.font =  Font.light(size: 16).font
        lbl.textColor = .white
        return lbl
    }()
    
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        
        setupViews()
        
        
    }
    
    required init?(coder: NSCoder) {
        super .init(coder: coder)
        
    }
    
    func setupViews() {
        
        self.backgroundColor = .clear
        
        self.radiusWithShadow(corners: [.bottomLeft,.topLeft,.topRight])
        
        self.contentView.addSubviews(backgroundImage)
        
        backgroundImage.addSubviews(locationImage,
                                    labelPlaceName,
                                    labelLocationName)
        
        setupLayout()
    }
    
    func setupLayout() {
        
        backgroundImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        labelPlaceName.snp.makeConstraints { make in
            make.top.equalTo(backgroundImage.snp.top).offset(142)
            make.leading.equalToSuperview().offset(8)
        }
        
        locationImage.snp.makeConstraints { make in
            make.top.equalTo(labelPlaceName.snp.bottom).offset(2)
            make.leading.equalTo(labelPlaceName.snp.leading)
        }
        
        labelLocationName.snp.makeConstraints { make in
            make.leading.equalTo(locationImage.snp.trailing).offset(6)
            make.top.equalTo(labelPlaceName.snp.bottom)
        }
    }
    
    func configure(with visit: Visit) {
        labelPlaceName.text = visit.place.title
        labelLocationName.text = visit.place.place
        backgroundImage.kf.setImage(with: URL(string: visit.place.cover_image_url))
    }
     
}
