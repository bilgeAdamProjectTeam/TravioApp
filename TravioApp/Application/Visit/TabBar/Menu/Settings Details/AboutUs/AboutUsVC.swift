//
//  AboutUsVC.swift
//  TravioApp
//
//  Created by Şevval Çakıroğlu on 14.09.2023.
//

import UIKit
import SnapKit
import WebKit

class AboutUsVC: UIViewController {
    
    private lazy var retangle: UIView = {
        let view = CustomView()
        
        return view
    }()
    
    private lazy var backButton: UIButton = {
        let image = UIButton()
        image.setImage(UIImage(named: "Vector"), for: .normal)
        image.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        
        return image
    }()
    
    private lazy var header: UILabel = {
        let label = UILabel()
        label.text = "About Us"
        label.font = Font.semiBold(size: 32).font
        label.textColor = .white
        return label
    }()

    private lazy var webView: WKWebView = {
       let wv = WKWebView()
        //wv.navigationDelegate = self
        if let url = URL(string: "https://www.thesprucepets.com/") {
            let request = URLRequest(url: url)
            wv.load(request)}
        return wv
    }()
    
    
    @objc func backTapped(){
        
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    

    func setupView(){
        
        navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = Color.turquoise.color
        
        self.view.addSubviews(backButton,header,retangle)
        retangle.addSubviews(webView)
        
        setupLayout()
    }
    
    func setupLayout(){
        
        retangle.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(125)
            make.leading.trailing.bottom.equalToSuperview().offset(0)
        }
        
        backButton.snp.makeConstraints({make in
            make.centerY.equalTo(header)
            make.leading.equalToSuperview().offset(24)
            make.height.equalTo(21.39)
            make.width.equalTo(24)
        })
        
        header.snp.makeConstraints({make in
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.leading.equalTo(backButton.snp.trailing).offset(24)
        })
        
        webView.snp.makeConstraints({make in
            make.top.leading.trailing.bottom.equalToSuperview()
        })
        
    }

}
