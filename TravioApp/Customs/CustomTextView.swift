//
//  CustomTextView.swift
//  TravioApp
//
//  Created by Şevval Çakıroğlu on 28.08.2023.
//



import SnapKit
import UIKit

class CustomTextView: UIView {
    
    
    
    var labelText:String = "" {
        didSet {
            label.text = labelText
        }
    }
    
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.text = "Label"
        label.font =  Font.medium(size: 14).font
        
        return label
    }()
    
    lazy var txtView: UITextView = {
        let txt = UITextView()
        txt.font = Font.light(size: 12).font
        txt.autocorrectionType = .no
        txt.autocapitalizationType = .none 
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
        roundCornersWithShadow([.topLeft,.topRight,.bottomLeft], radius: 16)
        addSubview(label)
        addSubview(txtView)
        setupLayouts()
    }
    
    func setupLayouts() {
        label.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalToSuperview().offset(16)
        }
        
        txtView.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-16)
        }
    }
}

