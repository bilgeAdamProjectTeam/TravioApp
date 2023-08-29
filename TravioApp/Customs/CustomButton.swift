//
//  CustomButton.swift
//  TravioApp
//
//  Created by Şevval Çakıroğlu on 28.08.2023.
//


import SnapKit
import UIKit

class CustomButton: UIButton {
    
    
    var labelText = "" {
        didSet{
            label.text = labelText
        }
    }

    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.text = "Button"
        label.font = Font.semiBold(size: 16).font
        label.textColor = .white
        
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor =   Color.turquoise.color
        setupViews()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
            
        let maskPath = UIBezierPath(roundedRect: bounds,
                                    byRoundingCorners: [.topLeft, .topRight, .bottomLeft],
                                    cornerRadii: CGSize(width: 12, height: 12))
        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        layer.mask = shape
    }

    func setupViews() {
        addSubview(label)
        setupLayouts()
    }

    func setupLayouts() {
        label.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.bottom.equalToSuperview().offset(-15)
            make.centerX.equalToSuperview()
        }
    }
}
