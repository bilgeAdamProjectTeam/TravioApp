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
    var profileImage: UIImage?
    var imageData: [Data?] = []
    var imageUrl: String?
    let imagePicker = UIImagePickerController()
    let dispatchGroup = DispatchGroup()
    
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
        img.contentMode = .scaleAspectFill
        img.layer.masksToBounds = true
        img.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        img.layer.cornerRadius = img.frame.size.width / 2
        img.clipsToBounds = true
        return img
    }()
    
    private lazy var changePhoto: UIButton = {
        let btn = UIButton()
        btn.setTitle("Change Photo", for: .normal)
        btn.setTitleColor(.systemBlue, for: .normal)
        btn.titleLabel?.font = Font.regular(size: 12).font
        btn.addTarget(self, action: #selector(changeButtonTapped), for: .touchUpInside)
        return btn
    }()
    
    private lazy var userName: UILabel = {
        let lbl = UILabel()
        lbl.textColor = Color.darkGray.color
        lbl.font = Font.semiBold(size: 24).font
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
        btn.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        return btn
    }()
    
    @objc func changeButtonTapped() {
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            present(imagePicker, animated: true, completion: nil)
        } else {
            CustomAlert.showAlert(in: self,
                                  title: "Error",
                                  message: "Camera permission required",
                                  okActionTitle: "OK")
        }
    }
    
    @objc func backTapped(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func saveButtonTapped() {
        
        CustomAlert.showAlert(in: self,
                              title: "Alert",
                              message: "Are you sure you want to update the profile?",
                              okActionTitle: "OK",
                              cancelActionTitle: "Cancel", okCompletion: {
            self.updateUser()
            self.dismiss(animated: true)
        }, cancelCompletion: {
            self.dismiss(animated: true)
        })
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
       
        setupViews()
        
        getProfileInf()
    }
    
    func setupViews() {
        
        navigationController?.navigationBar.isHidden = true
        
        view.backgroundColor = Color.turquoise.color
        
        view.addSubviews(header,
                         exitButton,
                         retangle)
        
        retangle.addSubviews(userPhoto,
                             changePhoto,
                             userName,
                             stackView,
                             fullName,
                             mail,
                             saveButton)
        
        stackView.addArrangedSubviews(birthday,
                                      userRole)
        
        setupLayout()
    }
    
    func setupLayout() {
        
        retangle.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(125)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        header.snp.makeConstraints({make in
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.leading.equalToSuperview().offset(24)
        })
        
        exitButton.snp.makeConstraints({make in
            make.centerY.equalTo(header)
            make.leading.equalTo(header.snp.trailing).offset(152)
        })
        
        userPhoto.snp.makeConstraints({make in
            make.top.equalToSuperview().offset(24)
            make.centerX.equalToSuperview()
            make.height.equalTo(100)
            make.width.equalTo(100)
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
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-18)
        })
    }
    
    func getProfileInf() {
        
        viewModel.getUser { [self] data, error in
            if let data = data{
                if let imageURL = URL(string: data.pp_url) {
                    self.userPhoto.kf.setImage(with: imageURL)
                }
                
                self.userName.text = data.full_name
                self.birthday.label.text = data.created_at
                self.birthday.label.text = self.convertDateFormat(inputDateString: data.created_at, outputDateFormat: "dd MMMM yyyy")
                self.userRole.label.text = data.role
                self.fullName.placeholderName = data.full_name
                self.mail.placeholderName = data.email
            }
            
            if let error = error{
                CustomAlert.showAlert(
                    in: self,
                    title: "Error!",
                    message: error.localizedDescription,
                    okActionTitle: "Ok")
                
            }
        }
    }
    
//    func updateUser() {
//
//        self.dispatchGroup.enter()
//        self.viewModel.uploadPhoto(image: self.imageData) { result in
//            guard let result = result.first else { return }
//            self.imageUrl = result
//            self.dispatchGroup.leave()
//        } errorCallback: { error in
//            if let error = error {
//                CustomAlert.showAlert(in: self,
//                                      title: "Error!",
//                                      message: error.localizedDescription,
//                                      okActionTitle: "OK")
//            } else {
//                self.dismiss(animated: true)
//            }
//        }
//
//        self.dispatchGroup.enter()
//        guard let fullname = self.fullName.txtField.text,
//              let email = self.mail.txtField.text,
//              let url = self.imageUrl else { return }
//
//        let data = EditRequest(full_name: fullname, email: email, pp_url: url)
//        self.viewModel.updateUser(input: data) { error in
//            if let error = error {
//                CustomAlert.showAlert(in: self,
//                                      title: "Error!",
//                                      message: error.localizedDescription,
//                                      okActionTitle: "OK")
//            } else {
//                self.dispatchGroup.leave()
//                self.dismiss(animated: true)
//            }
//
//        }
//        self.dispatchGroup.notify(queue: .main) {
//            print("tamamlandı")
//        }
//
//    }
    
//    func updateUser() {
//        dispatchGroup.enter()
//        self.viewModel.uploadPhoto(image: self.imageData) { result in
//            guard let result = result.first else { return }
//            self.imageUrl = result
//            self.dispatchGroup.leave()
//        }
//
//        dispatchGroup.enter()
//        guard let fullname = self.fullName.txtField.text,
//              let email = self.mail.txtField.text,
//              let url = self.imageUrl else { return }
//
//        let data = EditRequest(full_name: fullname, email: email, pp_url: url)
//        self.viewModel.updateUser(input: data) {
//            self.dispatchGroup.leave()
//        }
//
//        self.dispatchGroup.notify(queue: .main) {
//            self.dismiss(animated: true)
//        }
//    }
    
    func updateUser() {
        
        self.viewModel.uploadPhoto(image: self.imageData) { result, error in
            if let result = result{
                guard let result = result.first else { return }
                self.imageUrl = result
                
                guard let fullname = self.fullName.txtField.text,
                      let email = self.mail.txtField.text,
                      let url = self.imageUrl else { return }
                
                let data = EditRequest(full_name: fullname, email: email, pp_url: url)
                
                self.viewModel.updateUser(input: data, callback: {error in
                    if let error = error{
                        CustomAlert.showAlert(in: self,
                                              title: "Error!",
                                              message: error.localizedDescription,
                                              okActionTitle: "Ok")
                    }
                })
            }

            if let error = error{
                CustomAlert.showAlert(in: self,
                                      title: "Error!",
                                      message: error.localizedDescription,
                                      okActionTitle: "Ok")
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
}

extension EditProfileVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
           if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
               
               let imageToData = image.jpegData(compressionQuality: 0.5)
               self.imageData.append(imageToData)
               DispatchQueue.main.async {
                   self.userPhoto.image = image
               }
               profileImage = image
           }
        
           picker.dismiss(animated: true, completion: nil)
       }
       
       func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
           picker.dismiss(animated: true, completion: nil)
       }
}

