//
//  MenuVC.swift
//  TravioApp
//
//  Created by Şevval Çakıroğlu on 29.08.2023.
//

import UIKit
import SnapKit

class SettingsVC: UIViewController {
    
    var viewModel = SettingsViewModel()
    let pageTypes: [UIViewController.Type] = [SecuritySettingsVC.self,
                                              SecuritySettingsVC.self,
                                              MyAddedPlacesVC.self,
                                              HelpAndSupportVC.self,
                                              AboutUsVC.self,
                                              TermOfUseVC.self]

    private lazy var retangle: UIView = {
        let view = CustomView()
        return view
    }()
    
    private lazy var settingTitle: UILabel = {
        let logo = UILabel()
        logo.text = "Settings"
        logo.textColor = .white
        logo.font = Font.semiBold(size: 32).font
        return logo
    }()
    
    private lazy var userPhoto: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "istanbul")
        img.contentMode = .scaleAspectFill
        img.layer.masksToBounds = true
        img.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        img.layer.cornerRadius = img.frame.size.width / 2
        img.clipsToBounds = true
        return img
    }()
    
    private lazy var userName: UILabel = {
        let lbl = UILabel()
        lbl.textColor = Color.darkGray.color
        lbl.font = Font.semiBold(size: 16).font
        lbl.text = "Şevval Çakıroğlu"
        lbl.textAlignment = .center
        return lbl
    }()
    
    private lazy var editProfile: UIButton = {
        let btn = UIButton()
        btn.setTitle("Edit Profile", for: .normal)
        btn.setTitleColor(.systemBlue, for: .normal)
        btn.titleLabel?.font = Font.regular(size: 12).font
        btn.addTarget(self, action: #selector(showEditProfile), for: .touchUpInside)
        return btn
    }()
    
    private lazy var buttonLogout: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "logOutIcon"), for: .normal)
        button.addTarget(self, action: #selector(buttonLogoutTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var collectionView:UICollectionView = {
        
        //MARK: -- CollectionView arayüzü için sağlanan layout protocolü.
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0)

        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = .clear
        cv.contentInsetAdjustmentBehavior = .never
        cv.showsHorizontalScrollIndicator = false
        cv.isPagingEnabled = true
        cv.register(SettingsCollectionViewCell.self, forCellWithReuseIdentifier: "CustomCell")
        return cv
    }()
    
    @objc func showEditProfile(){
        
        let fullScreenVC = EditProfileVC()
        fullScreenVC.modalPresentationStyle = .fullScreen 
        present(fullScreenVC, animated: true, completion: nil)
    }
    
    @objc func buttonLogoutTapped() {
        
        KeychainHelper.standard.delete("access-token", account: "ios-class")
        
        //TabBarController kaldırılıyor
        self.tabBarController?.removeFromParent()
        self.tabBarController?.view.removeFromSuperview()
        
        //Giriş sayfasına yönlendiriliyor ve yeni navigationController oluşturuluyor
        let launchScreenVC = LaunchScreenVC()
        let navigationController = UINavigationController(rootViewController: launchScreenVC)
        UIApplication.shared.windows.first?.rootViewController = navigationController
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getUser()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        
        getUser()
    }
    
    func setupViews(){
        self.view.backgroundColor = Color.turquoise.color
        navigationController?.navigationBar.isHidden = true
        
        self.view.addSubviews(settingTitle,
                              buttonLogout,
                              retangle)
        
        retangle.addSubviews(collectionView,
                             userPhoto,
                             userName,
                             editProfile)
        
        setupLayout()
    }
    
    
    func setupLayout(){
        
        settingTitle.snp.makeConstraints({make in
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.leading.equalToSuperview().offset(20)
        })
        
        retangle.snp.makeConstraints({make in
            make.top.equalToSuperview().offset(125)
            make.leading.trailing.bottom.equalToSuperview()
        })
        
        buttonLogout.snp.makeConstraints { make in
            make.centerY.equalTo(settingTitle)
            make.leading.equalTo(settingTitle.snp.trailing).offset(182)
        }
        
        userPhoto.snp.makeConstraints({make in
            make.top.equalToSuperview().offset(24)
            make.centerX.equalToSuperview()
            make.height.equalTo(100)
            make.width.equalTo(100)
        })
        
        userName.snp.makeConstraints({make in
            make.top.equalTo(userPhoto.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        })
        
        editProfile.snp.makeConstraints({make in
            make.top.equalTo(userName.snp.bottom)
            make.centerX.equalToSuperview()
        })
        
        collectionView.snp.makeConstraints({make in
            make.top.equalTo(editProfile.snp.bottom).offset(24)
            make.leading.trailing.bottom.equalToSuperview()
        })
    }
    
    func getUser(){
        
        viewModel.getUsername { result in
            self.userName.text = result.full_name
            self.userPhoto.kf.setImage(with: URL(string: result.pp_url))
        } errorCalback: { error in
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
}

extension SettingsVC: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: collectionView.frame.width - 32, height: 54)
        //let size = CGSize(width: collectionView.frame.width * 0.91, height: collectionView.frame.height)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let selectedPageType = pageTypes[indexPath.row]
        
        let pageInstance = selectedPageType.init()
        pageInstance.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(pageInstance, animated: true)
    }
}

extension SettingsVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.settingsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCell", for: indexPath) as! SettingsCollectionViewCell
        
        let object = viewModel.settingsArray[indexPath.row]
        cell.configure(data: object)
        
        return cell
    }
}
