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
    
    lazy var labelPlaceName:UILabel = {
        let lbl = UILabel()
        lbl.text = "Place Name"
        lbl.font =  Font.semiBold(size: 30).font
        lbl.textColor = .white
        return lbl
    }()
    
    lazy var labelLocationName:UILabel = {
        let lbl = UILabel()
        lbl.text = "Location Name"
        lbl.font =  Font.light(size: 16).font
        lbl.textColor = .white
        return lbl
    }()
    
//    private lazy var gradient:UIImageView = {
//        let img = UIImageView()
//        img.image = UIImage(named: "gradient")
//        return img
//    }()
    
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        
        setupViews()
        
//        if traitCollection.userInterfaceStyle == .dark {
//            // Dark mode ise
//            gradient.image = UIImage(named: "gradient")
//        } else {
//            // Light mode ise
//            gradient.image = UIImage(named: "Rectangle")
//        }
        
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
        
        containerView.addSubviews(backgroundImage,
//                                  gradient,
                                  locationImage,
                                  labelPlaceName,
                                  labelLocationName)
        
        setupLayout()
    }
    
    func setupLayout() {
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview().offset(0)
        }
        
        backgroundImage.snp.makeConstraints { make in
            make.edges.equalToSuperview().offset(0)
        }
        
        locationImage.snp.makeConstraints { make in
            make.top.equalTo(labelPlaceName.snp.bottom).offset(2)
            make.leading.equalToSuperview().offset(8)
            make.bottom.equalToSuperview().offset(-10)        }
        
        labelPlaceName.snp.makeConstraints { make in
            make.top.equalTo(backgroundImage.snp.top).offset(142)
            make.leading.equalTo(backgroundImage.snp.leading).offset(8)
        }
        
        labelLocationName.snp.makeConstraints { make in
            make.leading.equalTo(locationImage.snp.trailing).offset(6)
            make.top.equalTo(labelPlaceName.snp.bottom)
        }
        
//        gradient.snp.makeConstraints { make in
//            make.leading.trailing.bottom.equalToSuperview().offset(0)
//            make.height.equalTo(110)
//        }
    }
    
    func configure(with visit: Visit) {
        labelPlaceName.text = visit.place.title
        labelLocationName.text = visit.place.place
        backgroundImage.sd_setImage(with: URL(string: visit.place.cover_image_url))
    }
     
}
