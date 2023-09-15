//
//  CustomTextField.swift
//  TravioApp
//
//  Created by Şevval Çakıroğlu on 28.08.2023.
//


import SnapKit
import UIKit

class CustomTextField: UIView {
    

    var placeholderName = "" {
        didSet{
            txtField.placeholder = placeholderName
        }
    }
    
    var labelText:String = "" {
        didSet {
            label.text = labelText
        }
    }
    
   private lazy var label: UILabel = {
        let label = UILabel()
        label.text = "Label"
        label.font =  Font.medium(size: 14).font
       label.textColor = Color.darkGray.color
        return label
    }()
    
    lazy var txtField: UITextField = {
        let txt = UITextField()
        txt.placeholder = "placeholder"
        txt.font = Font.light(size: 12).font
        txt.autocorrectionType = .no
        txt.autocapitalizationType = .none
        txt.textColor = Color.darkGray.color
        
        return txt
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        setupViews()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupViews() {
        roundCornersWithShadow([.bottomLeft,.topLeft,.topRight], radius: 16)
        addSubview(label)
        addSubview(txtField)
        setupLayouts()
    }
    
    func setupLayouts() {
        label.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().offset(100)
        }
        
        txtField.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().offset(-12)
            make.bottom.equalToSuperview().offset(-19)
        }
    }
}
