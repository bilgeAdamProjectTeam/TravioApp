//
//  SeeAllCollectionViewCell.swift
//  TravioApp
//
//  Created by Şevval Çakıroğlu on 30.08.2023.
//


import UIKit
import SnapKit
import SDWebImage

class SeeAllCollectionViewCell: UICollectionViewCell {
    
    private lazy var view: UIView = {
        let view = UIView()
        //view.backgroundColor = .lightGray
        
        return view
    }()
    

    private lazy var image: UIImageView = {
        let img = UIImageView()
        img.backgroundColor = Color.darkGray.color
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
    

    func setupView(){
        backgroundColor = Color.lightGray.color
        
        addSubviews(view)
        view.addSubviews(image,placeName,cityName,vectorIcon)
        
        setupLayout()

    }
    
    func setupLayout(){
        
        view.snp.makeConstraints({make in
            make.edges.equalToSuperview()
        })
        
        image.snp.makeConstraints({make in
            make.height.equalTo(89)
            make.width.equalTo(90)
            make.leading.equalToSuperview().offset(0)
            make.trailing.equalToSuperview().offset(-252)
        })
        
        placeName.snp.makeConstraints({make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalTo(image.snp.trailing).offset(2)
        })
        vectorIcon.snp.makeConstraints({make in
            make.top.equalTo(placeName.snp.bottom).offset(3)
            make.height.equalTo(12)
            make.width.equalTo(9)
        })
        cityName.snp.makeConstraints({make in
            make.top.equalTo(placeName.snp.bottom)
            make.leading.equalTo(vectorIcon.snp.trailing).offset(6)
        })
        
    }
}

