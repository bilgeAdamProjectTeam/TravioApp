//
//  SecuritySettingsVC.swift
//  TravioApp
//
//  Created by Şevval Çakıroğlu on 5.09.2023.
//

import UIKit
import SnapKit

class SecuritySettingsVC: UIViewController {
    
    var viewModel = SecuritySettingsViewModel()
    var sectionArray = ["Change Password","Privacy"]
    //let cellTypes: [UITableViewCell.Type] = [ChangePasswordCell.self,PrivacyCell.self]
    
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
        label.text = "Security Settings"
        label.font = Font.semiBold(size: 32).font
        label.textColor = .white
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.delegate = self
        tv.dataSource = self
        tv.backgroundColor = Color.lightGray.color
        tv.separatorStyle = .none
        tv.rowHeight = UITableView.automaticDimension
        tv.estimatedRowHeight = 100
        tv.allowsSelection = false
        
         tv.register(PrivacyCell.self, forCellReuseIdentifier: "PrivacyCell")
         tv.register(ChangePasswordCell.self, forCellReuseIdentifier: "ChangePasswordCell")
         return tv
    }()
    
    private lazy var saveButton: CustomButton = {
        let btn = CustomButton()
        btn.labelText = "Save"
        return btn
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    @objc func backTapped(){
        
        navigationController?.popViewController(animated: true)
        
    }
    
    func setupView(){
        
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = Color.turquoise.color
        
        view.addSubviews(backButton,header,retangle)
        retangle.addSubviews(tableView,saveButton)
        
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
        
        tableView.snp.makeConstraints({make in
//            make.edges.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalTo(saveButton.snp.top).offset(-16)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()

        })
        
        saveButton.snp.makeConstraints({make in
            //make.top.equalTo(tableView.snp.bottom)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-18)
        })
        
        
        
    }


}

extension SecuritySettingsVC: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            let headerView = UIView()
            
        let label = UILabel()
        label.textColor = Color.turquoise.color// Başlık metin rengi
        label.font = Font.semiBold(size: 16).font
                
                if section == 0 {
                    label.text = sectionArray[section] // İlk bölümün başlığı
                } else if section == 1 {
                    label.text = sectionArray[section] // İkinci bölümün başlığı
                }
                
                headerView.addSubview(label)
                label.snp.makeConstraints { make in
                    make.leading.equalTo(headerView).offset(24) // Metin sol kenara göre ayarlanır
                    make.centerY.equalTo(headerView) // Metin dikey olarak hizalanır
                }
                
                return headerView
        }
    

    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 24 // Başlık yüksekliği
    }

    
    
}


extension SecuritySettingsVC: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 82// Hücre yüksekliği
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
           return 2
       }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return viewModel.changePassWordInfo.count
        } else {
            return  viewModel.privacyInfo.count
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ChangePasswordCell", for: indexPath) as! ChangePasswordCell
            let array = viewModel.changePassWordInfo[indexPath.row]
            cell.configure(data: array)
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PrivacyCell", for: indexPath) as! PrivacyCell
            let array = viewModel.privacyInfo[indexPath.row]
            cell.configure(data: array)
            
            return cell
        }
    }
    
}
    
    
    
    

