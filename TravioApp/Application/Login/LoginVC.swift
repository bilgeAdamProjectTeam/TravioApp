//
//  ViewController.swift
//  TravioApp
//
//  Created by Şevval Çakıroğlu on 28.08.2023.
//

import SnapKit
import UIKit

class LoginVC: UIViewController {
    
    private lazy var viewModel: LoginViewModel = {
        let view = LoginViewModel()
        return view
    }()
    
    private lazy var logo: UIImageView = {
        let logo = UIImageView()
        logo.image = UIImage(named: "travioLogo")
        return logo
    }()
    
    private lazy var retangle: UIView = {
        let view = CustomView()
        return view
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .clear
        scrollView.isScrollEnabled = true
        return scrollView
    }()
    
    private lazy var scrollContentView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "Welcome to Travio"
        label.font =  Font.medium(size: 24).font
        label.textColor = Color.darkGray.color
        return label
    }()
    
    private lazy var txtMailView: CustomTextField = {
        let view = CustomTextField()
        view.labelText = "Email"
        view.placeholderName = "bilgeadam@gmail.com"
        view.txtField.text = "sevvalcakiroglu@gmail.com"
        
        
        return view
    }()
    
    private lazy var txtPasswordView: CustomTextField = {
        let view = CustomTextField()
        view.labelText = "Password"
        view.placeholderName = "*********"
        view.txtField.text = "123456789"
        view.txtField.isSecureTextEntry = true
        return view
    }()
    
    private lazy var loginButton: UIButton = {
        let btn = CustomButton()
        btn.labelText = "Login"
        btn.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        return btn
    }()
    
    private lazy var stackViewSignUp: UIStackView = {
        let stack = UIStackView()
        return stack
    }()
    
    private lazy var labelSignUp: UILabel = {
        let label = UILabel()
        label.text = "Don't have any account?"
        label.font = Font.semiBold(size: 14).font
        return label
    }()
    
    private lazy var buttonSignUp: UIButton = {
        let button = UIButton()
        button.setTitle(" Sign Up", for: .normal)
        button.titleLabel?.font =  Font.semiBold(size: 14).font
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(signUpTapped), for: .touchUpInside)
        return button
        
    }()
    
    @objc func signUpTapped() {
        
        let signUpVC = SignUpVC()
        navigationController?.pushViewController(signUpVC, animated: true)
    }
    
    @objc func loginButtonTapped() {
        
        guard let email = txtMailView.txtField.text,
              let password = txtPasswordView.txtField.text else { return }
        
        let data = LoginInfo(email: email, password: password)
        
        viewModel.login(input: data)
        
        let tabBarController = TabBarController()
        self.navigationController?.pushViewController(tabBarController, animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    func setupViews() {
        
        self.view.backgroundColor = Color.turquoise.color
        
        navigationController?.isNavigationBarHidden = true
        
        self.view.addSubviews(retangle,
                              logo)
        
        retangle.addSubview(scrollView)
        
        scrollView.addSubview(scrollContentView)
        
        scrollContentView.addSubviews(welcomeLabel,
                                      txtMailView,
                                      txtPasswordView,
                                      loginButton,
                                      stackViewSignUp)
        
        stackViewSignUp.addArrangedSubviews(labelSignUp,
                                            buttonSignUp)
        
        setupLayout()
    }
    
    func setupLayout() {
        
        retangle.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(246)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        logo.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.centerX.equalToSuperview()
        }
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        scrollContentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(self.view)
            make.bottom.equalTo(stackViewSignUp.snp.bottom).offset(16)
        }
        
        welcomeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(64)
            make.centerX.equalToSuperview()
        }
        
        txtMailView.snp.makeConstraints { make in
            make.top.equalTo(welcomeLabel.snp.bottom).offset(41)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
        }

        txtPasswordView.snp.makeConstraints { make in
            make.top.equalTo(txtMailView.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
        }

        loginButton.snp.makeConstraints { make in
            make.top.equalTo(txtPasswordView.snp.bottom).offset(48)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
        }

        stackViewSignUp.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).offset(141)
            make.leading.equalToSuperview().offset(74)
        }
            make.height.equalTo(54)
        }
        
        forgotStackView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-21)
            make.centerX.equalToSuperview()
        }
    }
    
    @objc func signUpTapped() {
        let vc = SignUpVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func loginButtonTapped() {
        
        guard let email = txtMailView.txtField.text, let password = txtPasswordView.txtField.text else { return }

        
        let data = LoginInfo(email: email, password: password)
       
        LoginViewModelInstance.login(input: data) { error in

            if let error = error {
                CustomAlert.showAlert(
                    in: self,
                    title: "Hata!",
                    message: error.localizedDescription,
                    okActionTitle: "Tamam",
                    okCompletion: {
                        print("Tamam düğmesine tıklandı.")
                    }
                )
            } else {
                
                let tabBarController = TabBarController()
                self.navigationController?.pushViewController(tabBarController, animated: true)
            }
        }
        }
       
    }
}



