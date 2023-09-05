//
//  ChangePasswordCell.swift
//  TravioApp
//
//  Created by Şevval Çakıroğlu on 5.09.2023.
//

import Foundation
import UIKit
import SnapKit



class ChangePasswordCell: UITableViewCell{
    
    
    private lazy var passwordView: CustomTextField = {
        let pw = CustomTextField()
        pw.labelText = ""
        pw.txtField.isSecureTextEntry = true
        pw.txtField.placeholder = ""
        return pw
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupView(){
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        //passwordView.roundCorners(corners: [.topLeft,.topRight,.bottomLeft], radius: 16)
        contentView.addSubviews(passwordView)
        setupLayout()
    }
    
    func setupLayout(){
        passwordView.snp.makeConstraints({make in
            //make.edges.equalToSuperview()
            make.top.equalToSuperview().offset(4)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.bottom.equalToSuperview().offset(-4)
        })
        
    }
    func configure(data: ChangePassword){
        
        passwordView.labelText = data.labelName
        
    }
    
    
}
