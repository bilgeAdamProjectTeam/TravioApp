//
//  CustomView.swift
//  TravioApp
//
//  Created by Şevval Çakıroğlu on 28.08.2023.
//


import UIKit

class CustomView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Color.lightGray.color
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let maskPath = UIBezierPath(roundedRect: bounds,
                                    byRoundingCorners: [.topLeft], // Burada istediğin köşeyi seçebilirsin
                                    cornerRadii: CGSize(width: 80, height: 80))
        
        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        layer.mask = shape
    }
}
