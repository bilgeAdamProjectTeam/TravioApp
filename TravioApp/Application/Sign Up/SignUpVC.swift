//
//  SignUpVCViewController.swift
//  TravioApp
//
//  Created by Şevval Çakıroğlu on 28.08.2023.
//

import UIKit
import SnapKit


class SignUpVC: UIViewController {
    
    var viewModel = SignUpViewModel()
   
    private lazy var retangle: UIView = {
        let view = CustomView()
        return view
    }()
    
    private lazy var username: CustomTextField = {
        let tf = CustomTextField()
        tf.labelText = "Username"
        tf.placeholderName = "bilge_adam"
        return tf
    }()
    
    private lazy var mail: CustomTextField = {
        let tf = CustomTextField()
        tf.labelText = "Email"
        tf.placeholderName = "developer@bilgeadam.com"
        return tf
    }()
    
    private lazy var password: CustomTextField = {
        let tf = CustomTextField()
        tf.labelText = "Password"
        tf.placeholderName = "******"
        tf.txtField.isSecureTextEntry = true
        return tf
    }()
    
    private lazy var passwordConfirm: CustomTextField = {
        let tf = CustomTextField()
        tf.labelText = "Password Confirm"
        tf.placeholderName = "******"
        tf.txtField.isSecureTextEntry = true
        return tf
    }()
    
    private lazy var registerButton: UIButton = {
        let btn = CustomButton()
        btn.labelText = "Register"
        btn.backgroundColor = Color.darkGray.color
        btn.isEnabled = false
        btn.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        return btn
    }()
    
    private lazy var backVector: UIButton = {
        let image = UIButton()
        image.setImage(UIImage(named: "Vector"), for: .normal)
        image.addTarget(self, action: #selector(backVectorTapped), for: .touchUpInside)
        return image
    }()
    
    private lazy var header: UILabel = {
        let label = UILabel()
        label.text = "Sign Up"
        label.font = Font.semiBold(size: 36).font
        label.textColor = .white
        return label
    }()
    
    @objc func registerButtonTapped() {
        guard let username = username.txtField.text, let email = mail.txtField.text, let password = password.txtField.text else { return }
        
        let data = RegisterInfo(full_name: username, email: email, password: password)
        
        viewModel.register(input: data) { error in
            if let error = error {
                CustomAlert.showAlert(
                    in: self,
                    title: "Error!",
                    message: error.localizedDescription,
                    okActionTitle: "Ok"
                )
            }else {
                self.navigationController?.popViewController(animated: true)
            }
            
           
        }
    }
    
    @objc func backVectorTapped() {
        
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        
        delegates()
    }

    func setupViews() {
        
        navigationController?.navigationBar.isHidden = true
        
        self.view.backgroundColor = Color.turquoise.color
        
        self.view.addSubviews(retangle,
                              backVector,
                              header)
        
        retangle.addSubviews(username,
                             mail,
                             password,
                             passwordConfirm,
                             registerButton)
        
        setupLayout()
    }
    
    func setupLayout() {
        
        retangle.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(104)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        backVector.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalTo(header.snp.leading).offset(-72)
            make.centerY.equalTo(header)
        }
        
        header.snp.makeConstraints { make in
            make.bottom.equalTo(retangle.snp.top).offset(-50)
            make.centerX.equalToSuperview()
        }
        
        username.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(72)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
        }
        
        mail.snp.makeConstraints { make in
            make.top.equalTo(username.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
        }
        
        password.snp.makeConstraints { make in
            make.top.equalTo(mail.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
        }
        
        passwordConfirm.snp.makeConstraints { make in
            make.top.equalTo(password.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
        }
        
        registerButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.bottom.equalToSuperview().offset(-23)
        }
        
        
    }
    
    func delegates() {
        
        username.txtField.delegate = self
        mail.txtField.delegate = self
        password.txtField.delegate = self
        passwordConfirm.txtField.delegate = self
    }
    
}

extension SignUpVC: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if (username.txtField.text?.count)! >= 12 &&
            mail.txtField.text?.isEmpty == false &&
            (password.txtField.text?.count)! >= 8 &&
            (passwordConfirm.txtField.text?.count)! >= 8 &&
            password.txtField.text == passwordConfirm.txtField.text &&
            viewModel.isValidEmail(mail.txtField.text!) == true
        {
            registerButton.backgroundColor = Color.turquoise.color
            registerButton.isEnabled = true
        } else {
            registerButton.backgroundColor = Color.darkGray.color
            registerButton.isEnabled = false
        }
    }
}

