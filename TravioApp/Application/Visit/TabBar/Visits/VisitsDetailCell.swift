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
        
        //        ImageR.image = UIImage(contentsOfFile: photos.image_url)
        //imageTitle.text = photos.title
        
        if let imageUrl = URL(string: photos.image_url) {
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
