//
//  EditProfileVC.swift
//  TravioApp
//
//  Created by Şevval Çakıroğlu on 6.09.2023.
//

import UIKit
import SnapKit

class EditProfileVC: UIViewController {
    
    private lazy var retangle: UIView = {
        let view = CustomView()
        
        return view
    }()
    
    private lazy var exitButton: UIButton = {
        let image = UIButton()
        image.setImage(UIImage(named: "exit"), for: .normal)
        //image.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        
        return image
    }()
    
    private lazy var header: UILabel = {
        let label = UILabel()
        label.text = "Edit Profile"
        label.font = Font.semiBold(size: 32).font
        label.textColor = .white
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()

    }
    
    
    func setupView(){
        
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = Color.turquoise.color
        
        view.addSubviews(header,exitButton,retangle)
        
        setupLayout()
    }
    
    func setupLayout(){
        
        retangle.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(125)
            make.leading.trailing.bottom.equalToSuperview().offset(0)
        }
        
        header.snp.makeConstraints({make in
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.leading.equalToSuperview().offset(24)
        })
        
        exitButton.snp.makeConstraints({make in
            make.centerY.equalTo(header)
            make.leading.equalTo(header.snp.trailing).offset(152)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(20)
            make.width.equalTo(20)
        })
        
    }



}
