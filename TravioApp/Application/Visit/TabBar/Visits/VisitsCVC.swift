//
//  VisitsCVC.swift
//  TravioApp
//
//  Created by Şevval Çakıroğlu on 29.08.2023.
//


import UIKit
import SnapKit
import SDWebImage

class VisitsCVC: UICollectionViewCell {
    static let imageCache = NSCache<NSString, UIImage>()
    
    private lazy var containerView:UIView = {
        let view = UIView()
     
        
        return view
    }()
    
    lazy var backgroundImage:UIImageView = {
       let img = UIImageView()
        img.image = UIImage(named: "istanbul")
        return img
    }()
    
    private lazy var locationImage:UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "Vector2")
        
        return img
    }()
    
    lazy var name:UILabel = {
        let lbl = UILabel()
        lbl.text = "placeName"
        lbl.font =  Font.light(size: 16).font
        lbl.textColor = .white
        
        return lbl
    }()

    private lazy var gradient:UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "gradient")
       return img
    }()
    
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        setupViews()
        
        if traitCollection.userInterfaceStyle == .dark {
            // Dark mode ise
            gradient.image = UIImage(named: "gradient")
        } else {
            // Light mode ise
            gradient.image = UIImage(named: "Rectangle")
        }
        
    }
    
    required init?(coder: NSCoder) {
        super .init(coder: coder)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
            
        let maskPath = UIBezierPath(roundedRect: bounds,
                                    byRoundingCorners: [.topLeft, .topRight, .bottomLeft],
                                    cornerRadii: CGSize(width: 16, height: 16))
        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        layer.mask = shape
    }
    
    

    
    func setupViews() {
        addSubviews(containerView)
        containerView.addSubviews(backgroundImage,gradient,locationImage,name)
        setupLayouts()
   
    }
    
    func setupLayouts() {
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview().offset(0)
        }
        backgroundImage.snp.makeConstraints { make in
            make.edges.equalToSuperview().offset(0)
        }
        
        locationImage.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(8)
            make.bottom.equalToSuperview().offset(-10)
            make.width.equalTo(15)
            make.height.equalTo(20)
        }
        
        name.snp.makeConstraints { make in
            make.leading.equalTo(locationImage.snp.trailing).offset(15)
            make.bottom.equalToSuperview().offset(-8)
        }
        
        gradient.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview().offset(0)
            make.height.equalTo(110)
        }
    }

    
    func configure(with travel: Travel) {
        name.text = travel.location
        backgroundImage.sd_setImage(with: URL(string: travel.image_url))
    }
    

}
