//
//  HelpAndSupportCollectionViewCell.swift
//  TravioApp
//
//  Created by Şevval Çakıroğlu on 14.09.2023.
//

import UIKit
import SnapKit

class HelpAndSupportCollectionViewCell: UICollectionViewCell {
    
    
    private lazy var titleLabel: UILabel = {
        let tv = UILabel()
        tv.font = Font.medium(size: 14).font
        tv.textColor = Color.darkGray.color
        tv.numberOfLines = 0
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let tv = UILabel()
        tv.font = Font.light(size: 10).font
        tv.textColor = Color.darkGray.color
        tv.numberOfLines = 0
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    private lazy var icon: UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(named: "showVector")
        return icon
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){
       
        self.contentView.roundCornersWithShadow( [.topLeft,.topRight,.bottomLeft], radius: 16)
        self.contentView.backgroundColor = .white
        self.contentView.addSubviews(titleLabel,descriptionLabel,icon)
        
        setupLayout()
    }
    
    func setupLayout(){
        
        titleLabel.snp.makeConstraints({make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().offset(-46)
        })
        
        icon.snp.makeConstraints({make in
            make.top.equalToSuperview().offset(21)
            make.leading.equalTo(titleLabel.snp.trailing).offset(12)
            make.trailing.equalToSuperview().offset(-18)
        })
        
        descriptionLabel.snp.makeConstraints({make in
            make.top.equalTo(titleLabel.snp.bottom).offset(12)
            make.leading.equalTo(titleLabel.snp.leading)
            make.trailing.equalToSuperview().offset(-18)
        })
        
        
    }
    
    func configure(data:Helps){
        self.titleLabel.text = data.labelTitle
        self.descriptionLabel.text = data.labelDescription
        
    }
    
}
