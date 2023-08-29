//
//  HomeVC.swift
//  TravioApp
//
//  Created by Şevval Çakıroğlu on 29.08.2023.
//

import UIKit
import SnapKit

class HomeVC: UIViewController {
    
    private lazy var retangle: UIView = {
        let view = CustomView()
        
        return view
    }()
    
    private lazy var logo: UIImageView = {
        let logo = UIImageView()
        logo.image = UIImage(named: "traviogroup")
        logo.contentMode = .scaleAspectFit
        return logo
    }()
    
//    private lazy var travio: UIImageView = {
//        let logo = UIImageView()
//        logo.image = UIImage(named: "travio")
//        return logo
//
//    }()
    
    
    private lazy var tableView:UITableView = {
       let tv = UITableView()
        tv.delegate = self
        tv.dataSource = self
        tv.backgroundColor = Color.lightGray.color
        tv.separatorStyle = .none
        tv.rowHeight = UITableView.automaticDimension
        tv.estimatedRowHeight = 100
        tv.allowsSelection = false
//        tv.contentInset = UIEdgeInsets(top: 52, left: 0, bottom: 52, right: 0)
        //tv.rowHeight = 300
        tv.register(HomeTableViewCell.self, forCellReuseIdentifier: "HomeTableViewCell")
        return tv
    }()
    
//    private lazy var collectionView:UICollectionView = {
//
//        //MARK: -- CollectionView arayüzü için sağlanan layout protocolü.
//        let layout = UICollectionViewFlowLayout()
//        layout.minimumLineSpacing = 10
//        layout.minimumInteritemSpacing = 0
//        layout.scrollDirection = .horizontal
//
//
//
//        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        cv.delegate = self
//        cv.dataSource = self
//        cv.backgroundColor = .clear
//        cv.contentInsetAdjustmentBehavior = .never
//        cv.showsHorizontalScrollIndicator = false
//        cv.isPagingEnabled = true
//
//        cv.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: "CustomCell")
//
//        return cv
//    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let nib = UINib(nibName: "HomeTableViewCell", bundle: nil)
//        tableView.register(nib, forCellReuseIdentifier: "HomeTableViewCell")
        
        setupView()
    
        //print("")
    }
    
    func setupView(){
        
        
        view.backgroundColor = Color.turquoise.color
        navigationController?.navigationBar.isHidden = true
        view.addSubviews(retangle,logo)
        retangle.addSubview(tableView)
//        retangle.addSubview(collectionView)
        
        setupLayout()
    }
    
    
    func setupLayout(){
        
        logo.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(28)
            make.leading.equalToSuperview().offset(16)
            make.width.equalTo(170)
            make.height.equalTo(62)

        }
        
//        travio.snp.makeConstraints({make in
//            make.top.equalToSuperview().offset(44.28)
//            make.leading.equalTo(logo.snp.trailing)
//            make.trailing.equalToSuperview().offset(-202.46)
//            make.bottom.equalTo(retangle.snp.top).offset(-52.68)
//        })
        
        retangle.snp.makeConstraints { make in
            make.top.equalTo(logo.snp.bottom).offset(35)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        tableView.snp.makeConstraints({make in
//            make.edges.equalToSuperview()
            make.top.equalToSuperview().offset(44)
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()

        })
        
        
//        collectionView.snp.makeConstraints({make in
//            make.top.equalToSuperview().offset(87)
//            make.bottom.equalToSuperview().offset(-454)
//            make.leading.equalToSuperview().offset(24)
//            make.trailing.equalToSuperview()
//
//        })
        
        
    }
    
    
}



extension HomeVC: UITableViewDelegate{
    
    
}

extension HomeVC: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 262// Hücre yüksekliği
    }

    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 10 // Her bölümün üst tarafına 10 birim boşluk ekleyin
//    }

    
    
//    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        return 52 // Her bölümün alt tarafına 10 birim boşluk ekleyin
//    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as! HomeTableViewCell
        return cell
    }
    
    
}

