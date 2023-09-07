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
    let pageTypes: [UIViewController.Type] = [SecuritySettingsVC.self]

    
    
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
        img.image = UIImage(named: "userPhoto")
        img.contentMode = .scaleAspectFit
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
    
    private lazy var collectionView:UICollectionView = {
        
        //MARK: -- CollectionView arayüzü için sağlanan layout protocolü.
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .vertical
        //layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)

        
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        getUser()
        
    }
    
    @objc func showEditProfile(){
        let fullScreenVC = EditProfileVC()
        fullScreenVC.modalPresentationStyle = .fullScreen 
        present(fullScreenVC, animated: true, completion: nil)

        
    }
    
    func getUser(){
        
        viewModel.getUsername { result in
            self.userName.text = result.full_name
        }
    }
    
    func setupView(){
        self.view.backgroundColor = Color.turquoise.color
        navigationController?.navigationBar.isHidden = true
        
        self.view.addSubviews(settingTitle,retangle)
        retangle.addSubviews(collectionView,userPhoto,userName,editProfile)
        
        
        setupLayout()
    }
    
    
    func setupLayout(){
        
        settingTitle.snp.makeConstraints({make in
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.leading.equalToSuperview().offset(20)
        })
        
        retangle.snp.makeConstraints({make in
            make.top.equalToSuperview().offset(125)
            make.leading.trailing.bottom.equalToSuperview().offset(0)
        })
        
        userPhoto.snp.makeConstraints({make in
            make.top.equalToSuperview().offset(24)
            make.centerX.equalToSuperview()
//            make.leading.equalToSuperview().offset(135)
//            make.trailing.equalToSuperview().offset(-135)
            make.bottom.equalToSuperview().offset(-575)
            
        })
        
        userName.snp.makeConstraints({make in
            make.top.equalTo(userPhoto.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
//            make.leading.equalToSuperview().offset(150)
            //make.trailing.equalToSuperview().offset(-150)
            make.bottom.equalToSuperview().offset(-543)
        })
        
        editProfile.snp.makeConstraints({make in
            make.top.equalTo(userName.snp.bottom).offset(0)
            make.centerX.equalToSuperview()
//            make.leading.equalToSuperview().offset(164)
            //make.trailing.equalToSuperview().offset(-164)
            make.bottom.equalToSuperview().offset(-525)
        })
        
        collectionView.snp.makeConstraints({make in
            make.top.equalTo(editProfile.snp.bottom).offset(24)
            make.leading.trailing.bottom.equalToSuperview()
        })
        
    }
    
    
}


extension SettingsVC: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: collectionView.frame.width-32, height:54)
        //let size = CGSize(width: collectionView.frame.width * 0.91, height: collectionView.frame.height)
            return size
     }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let selectedPageType = pageTypes[indexPath.row]
        
        // Seçilen sayfa türüne göre bir sayfa örneği oluşturun
        let pageInstance = selectedPageType.init()
        pageInstance.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(pageInstance, animated: true)
    }

    
    
}

extension SettingsVC: UICollectionViewDataSource{
    
    
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
