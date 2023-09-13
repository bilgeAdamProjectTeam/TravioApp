//
//  EditProfileVC.swift
//  TravioApp
//
//  Created by Şevval Çakıroğlu on 6.09.2023.
//

import UIKit
import SnapKit
import Kingfisher

class EditProfileVC: UIViewController {
    
    var viewModel = EditProfileViewModel()
    var userProfile: UserReturn?
    
    private lazy var retangle: UIView = {
        let view = CustomView()
        
        return view
    }()
    
    private lazy var exitButton: UIButton = {
        let image = UIButton()
        image.setImage(UIImage(named: "exit"), for: .normal)
        image.contentMode = .scaleAspectFit
        image.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        
        return image
    }()
    
    private lazy var header: UILabel = {
        let label = UILabel()
        label.text = "Edit Profile"
        label.font = Font.semiBold(size: 32).font
        label.textColor = .white
        return label
    }()
    
    private lazy var userPhoto: UIImageView = {
        let img = UIImageView()
        //img.image = UIImage(named: "userPhoto")
        //img.image = URL
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    private lazy var changePhoto: UIButton = {
        let btn = UIButton()
        btn.setTitle("Change Photo", for: .normal)
        btn.setTitleColor(.systemBlue, for: .normal)
        btn.titleLabel?.font = Font.regular(size: 12).font
        return btn
    }()
    
    private lazy var userName: UILabel = {
        let lbl = UILabel()
        lbl.textColor = Color.darkGray.color
        lbl.font = Font.semiBold(size: 24).font
        lbl.text = "Şevval Çakıroğlu"
        lbl.textAlignment = .center
        return lbl
    }()
    
    private lazy var stackView: UIStackView = {
        let sv = UIStackView()
        sv.spacing = 16
        sv.axis = .horizontal
        sv.distribution = .fillEqually
        return sv
    }()
    
    
    private lazy var birthday: CustomImageLabelView = {
        let view = CustomImageLabelView()
        view.icon.image = UIImage(named: "birthday")
        view.label.text = "30 Ağustos 2023"
        return view
    }()
    
    private lazy var userRole: CustomImageLabelView = {
        let view = CustomImageLabelView()
        view.icon.image = UIImage(named: "userRole")
        view.label.text = "Admin"
        return view
    }()
    
    private lazy var fullName: CustomTextField = {
        let tf = CustomTextField()
        
        tf.labelText = "Full Name"
        tf.placeholderName = "bilge_adam"
        
        return tf
    }()
    
    private lazy var mail: CustomTextField = {
        let tf = CustomTextField()
        tf.labelText = "Email"
        tf.placeholderName = "developer@bilgeadam.com"
        
        return tf
    }()
    
    private lazy var saveButton: CustomButton = {
        let btn = CustomButton()
        btn.labelText = "Save"
        btn.addTarget(self, action: #selector(editProfile), for: .touchUpInside)
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupView()
        getProfileInf()
        

    }
    
    @objc func backTapped(){
        self.dismiss(animated: true, completion: nil)
    }
    
    func getProfileInf(){
        
        viewModel.getUser { [self] data in
            
            
            
            if let imageURL = URL(string: data.pp_url) {
                self.userPhoto.kf.setImage(with: imageURL)
            }
            
            self.userName.text = data.full_name
            self.birthday.label.text = data.created_at
//            dateFormatter(createDate: data.created_at, label: self.birthday.label.text)
            self.birthday.label.text = self.convertDateFormat(inputDateString: data.created_at, outputDateFormat: "dd MMMM yyyy")
            self.userRole.label.text = data.role
            self.fullName.placeholderName = data.full_name
            self.mail.placeholderName = data.email
        } errorCallback: { error in
            
            if let error = error {
                CustomAlert.showAlert(
                    in: self,
                    title: "Error!",
                    message: error.localizedDescription,
                    okActionTitle: "Ok"
                )
            }
            
        }
        
    }

    func convertDateFormat(inputDateString: String, outputDateFormat: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ" // Gelen tarih formatı
        if let date = dateFormatter.date(from: inputDateString) {
            dateFormatter.dateFormat = outputDateFormat // Çıktı tarih formatı
            let result = dateFormatter.string(from: date)
            return result
        } else {
            return nil // Tarih dönüşümü başarısız olduysa nil döner
        }
    }
    
    
    
    @objc func editProfile() {
        
        CustomAlert.showAlert(
            in: self,
            title: "Alert",
            message: "Edit Profile",
            okActionTitle: "Ok",
            cancelActionTitle: "Cancel",
            okCompletion: { [self] in
                guard let fullname = fullName.txtField.text, let email = mail.txtField.text  else { return }
                
                let data = EditRequest(full_name: fullname, email: email, pp_url: "https://example.com/deneme.png")
                
                viewModel.updateUser(input: data) { error in
                    if let error = error {
                        CustomAlert.showAlert(
                            in: self,
                            title: "Error!",
                            message: error.localizedDescription,
                            okActionTitle: "Ok"
                        )
                    }else{
                        self.dismiss(animated: true, completion: nil)
                    }
                }
            }
        )
        

    }
    
    func setupView(){
        
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = Color.turquoise.color
        
        view.addSubviews(header,exitButton,retangle)
        retangle.addSubviews(userPhoto,changePhoto,userName,stackView,fullName,mail,saveButton)
        stackView.addArrangedSubviews(birthday,userRole)
        
        setupLayout()
    }
    
    func setupLayout(){
        
        retangle.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(125)
            make.leading.trailing.bottom.equalToSuperview().offset(0)
        }
        
        header.snp.makeConstraints({make in
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.leading.equalToSuperview().offset(24)
        })
        
        exitButton.snp.makeConstraints({make in
            make.centerY.equalTo(header)
            make.leading.equalTo(header.snp.trailing).offset(152)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(20)
            make.width.equalTo(20)
        })
        
        userPhoto.snp.makeConstraints({make in
            make.top.equalToSuperview().offset(24)
            make.leading.equalToSuperview().offset(135)
            make.trailing.equalToSuperview().offset(-135)
            
        })
        
        changePhoto.snp.makeConstraints({make in
            make.top.equalTo(userPhoto.snp.bottom).offset(7)
            make.centerX.equalToSuperview()
        })
        
        userName.snp.makeConstraints({make in
            make.top.equalTo(changePhoto.snp.bottom).offset(7)
            make.centerX.equalToSuperview()
        })
        
        stackView.snp.makeConstraints({make in
            make.top.equalTo(userName.snp.bottom).offset(21)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
        })
        
        fullName.snp.makeConstraints({make in
            make.top.equalTo(birthday.snp.bottom).offset(19)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
        })
        
        mail.snp.makeConstraints({make in
            make.top.equalTo(fullName.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
        })

        saveButton.snp.makeConstraints({make in
            //make.top.equalTo(tableView.snp.bottom)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-18)
        })
        
        
        
    }



}
