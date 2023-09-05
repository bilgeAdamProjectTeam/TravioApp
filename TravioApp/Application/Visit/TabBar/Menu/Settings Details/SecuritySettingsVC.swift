//
//  SecuritySettingsVC.swift
//  TravioApp
//
//  Created by Şevval Çakıroğlu on 5.09.2023.
//

import UIKit
import SnapKit

class SecuritySettingsVC: UIViewController {
    
    private lazy var retangle: UIView = {
        let view = CustomView()
        
        return view
    }()
    
    private lazy var backButton: UIButton = {
        let image = UIButton()
        image.setImage(UIImage(named: "Vector"), for: .normal)
        //image.addTarget(self, action: #selector(backVectorTapped), for: .touchUpInside)
        
        return image
    }()
    
    private lazy var header: UILabel = {
        let label = UILabel()
        label.text = "Security Settings"
        label.font = Font.semiBold(size: 32).font
        label.textColor = .white
        return label
    }()
    
    private lazy var passwordStackview: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 8
        return sv
    }()

    private lazy var passwordLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Change Password"
        lbl.font = Font.semiBold(size: 16).font
        lbl.textColor = Color.turquoise.color
        return lbl
    }()
    
    private lazy var newPassword: CustomTextField = {
        let pw = CustomTextField()
        pw.labelText = "New Password"
        pw.txtField.isSecureTextEntry = true
        pw.txtField.placeholder = ""
        return pw
    }()
    
    private lazy var newPasswordConfirm: CustomTextField = {
        let pw = CustomTextField()
        pw.labelText = "New Password Confirm"
        pw.txtField.isSecureTextEntry = true
        pw.txtField.placeholder = ""
        return pw
    }()
    
    
    private lazy var privacyStackview: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 8
        return sv
    }()
    
    private lazy var privacyLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Privacy"
        lbl.font = Font.semiBold(size: 16).font
        lbl.textColor = Color.turquoise.color
        return lbl
    }()
    
    private lazy var camera: CustomSwitchLabelView = {
        let customView = CustomSwitchLabelView()
        customView.labelText = "Camera"
        return customView
    }()
    
    private lazy var photoLibrary: CustomSwitchLabelView = {
        let customView = CustomSwitchLabelView()
        customView.labelText = "Photo Library"
        return customView
    }()

    private lazy var location: CustomSwitchLabelView = {
        let customView = CustomSwitchLabelView()
        customView.labelText = "Location"
        return customView
    }()
    
    private lazy var saveButton: CustomButton = {
        let btn = CustomButton()
        btn.labelText = "Save"
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    
    func setupView(){
        
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = Color.turquoise.color
        
        view.addSubviews(backButton,header,retangle)
        retangle.addSubviews(passwordStackview,privacyStackview,saveButton)
        passwordStackview.addArrangedSubviews(passwordLabel,newPassword,newPasswordConfirm)
        privacyStackview.addArrangedSubviews(privacyLabel,camera,photoLibrary,location)
        
        
        setupLayout()
        
    }

    func setupLayout(){
        
        retangle.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(125)
            make.leading.trailing.bottom.equalToSuperview().offset(0)
        }
        
        backButton.snp.makeConstraints({make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(32)
            make.leading.equalToSuperview().offset(24)
            make.height.equalTo(21.39)
            make.width.equalTo(24)
        })
        
        header.snp.makeConstraints({make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(19)
            make.leading.equalTo(backButton.snp.trailing).offset(24)
        })
        
        passwordStackview.snp.makeConstraints({make in
            make.top.equalToSuperview().offset(44)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
        })
        
        privacyStackview.snp.makeConstraints({make in
            make.top.equalTo(passwordStackview.snp.bottom).offset(24)
            make.leading.equalTo(passwordStackview.snp.leading)
            make.trailing.equalTo(passwordStackview.snp.trailing)
            make.bottom.equalToSuperview().offset(-196)
        })
        
        saveButton.snp.makeConstraints({make in
            make.top.equalTo(privacyStackview.snp.bottom).offset(124)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.bottom.equalToSuperview().offset(-18)
        })
        
    }


}
