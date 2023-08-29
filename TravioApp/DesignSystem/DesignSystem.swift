//
//  DesignSystem.swift
//  TravioApp
//
//  Created by Şevval Çakıroğlu on 28.08.2023.
//


import UIKit



enum Font {
    case regular(size: CGFloat)
    case medium(size: CGFloat)
    case bold(size: CGFloat)
    case semiBold(size: CGFloat)
    case light(size: CGFloat)
    
    var font: UIFont {
        switch self {
        case .regular(let size):
            return UIFont(name: "Poppins-Regular", size: size) ?? UIFont.systemFont(ofSize: size)
        case .medium(let size):
            return UIFont(name: "Poppins-Medium", size: size) ?? UIFont.systemFont(ofSize: size)
        case .bold(let size):
            return UIFont(name: "Poppins-Bold", size: size) ?? UIFont.boldSystemFont(ofSize: size)
        case .semiBold(let size):
            return UIFont(name: "Poppins-SemiBold", size: size) ?? UIFont.boldSystemFont(ofSize: size)
        case .light(let size):
            return UIFont(name: "Poppins-Light", size: size) ?? UIFont.boldSystemFont(ofSize: size)
            
        }
    }
}

enum Color{
    case turquoise
    case darkGray
    case lightGray
    case iconGreen
    
    var color: UIColor{
        switch self {
        case .turquoise:
            return UIColor(red: 0.22, green: 0.678, blue: 0.663, alpha: 1)
            
        case .darkGray:
            return UIColor(red: 0.239, green: 0.239, blue: 0.239, alpha: 1)
            
        case .lightGray:
            return UIColor(red: 0.971, green: 0.971, blue: 0.971, alpha: 1)
        case .iconGreen:
            return UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1)
        }
    }
    
}
