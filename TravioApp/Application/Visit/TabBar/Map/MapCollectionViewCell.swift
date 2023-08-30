//
//  MapCollectionViewCell.swift
//  TravioApp
//
//  Created by Şevval Çakıroğlu on 29.08.2023.
//

import UIKit
import SnapKit
import SDWebImage

class MapCollectionViewCell: UICollectionViewCell {
    
    private lazy var images : UIImageView = {
        let img = UIImageView()
        img.backgroundColor = Color.darkGray.color
        img.layer.shadowColor = Color.darkGray.color.cgColor
        img.layer.shadowOffset = CGSize(width: 0, height: 0)
        img.layer.shadowOpacity = 0.15
        img.layer.shadowRadius = 4
        img.clipsToBounds = false
//        img.layer.cornerRadius = 16
        img.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMinYCorner]
        img.contentMode = .scaleAspectFill
        
        
        return img
    }()
    
    private lazy var icon : UIButton = {
        let btn = UIButton()
        let image = UIImage(named: "isVisitMark")
        btn.setImage(image, for: .normal)
        
        return btn
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
        //icon.frame = CGRect(x: 0, y: 0, width: 9, height: 12)
        return icon
    }()
    
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with places: Place){
            placeName.text = places.title
            cityName.text = places.place
        
        if let imageUrl = URL(string: places.coverImageURL!) {
            DispatchQueue.global().async {
                if let imageData = try? Data(contentsOf: imageUrl),
                   let image = UIImage(data: imageData) {
                    DispatchQueue.main.async {
                        self.images.image = image
                    }
                }
            }
        }
        
    }
    
    func setupView(){
        
        addSubviews(images)
        images.addSubviews(icon,placeName,vectorIcon,cityName)

        setupLayout()
    }
    
    func setupLayout(){
        
        images.snp.makeConstraints({make in
            make.edges.equalToSuperview()
        })
        
        icon.snp.makeConstraints({make in
            make.leading.equalToSuperview().offset(264)
            make.bottom.equalToSuperview().offset(-138)
           
        })
        
        placeName.snp.makeConstraints({make in
            make.top.equalToSuperview().offset(113)
            make.bottom.equalToSuperview().offset(-29)
            make.leading.equalToSuperview().offset(22)
            make.trailing.equalToSuperview().offset(-48)

        })
        
        vectorIcon.snp.makeConstraints({make in
            make.top.equalToSuperview().offset(152)
            make.bottom.equalToSuperview().offset(-14)
            make.leading.equalToSuperview().offset(22)
            make.trailing.equalToSuperview().offset(-278)
        })

        cityName.snp.makeConstraints({make in
            make.top.equalToSuperview().offset(149)
            make.bottom.equalToSuperview().offset(-8)
            make.leading.equalToSuperview().offset(37)
            //make.trailing.equalToSuperview().offset(-216)
        })
        
    }
}

