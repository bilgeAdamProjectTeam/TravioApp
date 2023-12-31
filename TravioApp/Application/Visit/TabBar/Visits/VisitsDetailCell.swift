//
//  VisitsDetailCell.swift
//  travio
//
//  Created by Şevval Çakıroğlu on 21.08.2023.
//

import UIKit
import SnapKit

class VisitsDetailCell: UICollectionViewCell {
    
  //var viewModel = VisitsViewModel()
    
    private lazy var images : UIImageView = {
        let img = UIImageView()
        return img
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configure(with photos: Image){

        if let imageUrl = URL(string: photos.image_url) {
            
            self.images.kf.setImage(with: imageUrl)
        } 
    }
        
    //view.frame = CGRect(x: 0, y: 0, width: 390, height: 249)
    func setupView(){
        addSubviews(images)
        setupLayout()
    }
    
    func setupLayout(){
        
        images.snp.makeConstraints({make in
            make.edges.equalToSuperview()
        })
        
    }
        
        
}
