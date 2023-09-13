//
//  LaunchScreenVC.swift
//  TravioApp
//
//  Created by Şevval Çakıroğlu on 8.09.2023.
//

import UIKit
import SnapKit

class LaunchScreenVC: UIViewController {
    
    
    private lazy var logo: UIImageView = {
        let logo = UIImageView()
        logo.image = UIImage(named: "launchScreen")
        logo.contentMode = .scaleAspectFill
        return logo
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.asyncAfter(deadline: .now() +  1.0){
            self.goToLoginPage()
        }

       setupViews()
    }
    func goToLoginPage(){
        
        let vc = LoginVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func setupViews(){
        
        self.view.backgroundColor = Color.turquoise.color
        self.view.addSubviews(logo)
        
        setupLayout()
    }
    
    func setupLayout(){
        
        logo.snp.makeConstraints({make in
            make.top.equalToSuperview().offset(213)
            make.leading.equalToSuperview().offset(76)
            make.trailing.equalToSuperview().offset(-76)
            make.bottom.equalToSuperview().offset(-402)
        })
        
    }



}
