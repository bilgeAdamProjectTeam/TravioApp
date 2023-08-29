//
//  FileHomeTableViewCell.swift
//  TravioApp
//
//  Created by Şevval Çakıroğlu on 29.08.2023.
//

import UIKit
import SnapKit

class HomeTableViewCell: UITableViewCell{
    
    private lazy var title: UILabel = {
        let lbl = UILabel()
        lbl.text = "Popular Places"
        lbl.font = Font.medium(size: 20).font
        return lbl
    }()
    
    
    private lazy var customView: UIView = {
        let view = UIView()
        view.backgroundColor = Color.lightGray.color
        return view
    }()
    
    private lazy var detailBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("See All", for: .normal)
        btn.setTitleColor(.systemBlue, for: .normal)
        return btn
    }()
    
    private lazy var headerStack: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.alignment = .center
        sv.distribution = .equalSpacing
        sv.spacing = 100
        return sv
    }()
    
    lazy var collectionView : UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.contentInsetAdjustmentBehavior = .never
        cv.showsHorizontalScrollIndicator = false
        cv.isPagingEnabled = true
        cv.delegate = self
        cv.dataSource = self
        cv.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: "CustomCell")
        
        return cv
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        //super.init(style: <#T##UITableViewCell.CellStyle#>, reuseIdentifier: <#T##String?#>)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
    
    func setupView(){
        
        backgroundColor = Color.lightGray.color
        contentView.addSubviews(headerStack,collectionView)
        headerStack.addArrangedSubview(title)
        headerStack.addArrangedSubview(detailBtn)
        
        setupLayout()
    }
    
    func setupLayout(){
        
        headerStack.snp.makeConstraints({make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(30)
        })
        
        collectionView.snp.makeConstraints({make in
            make.top.equalTo(headerStack.snp.bottom).offset(2)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            
        })
        
        
    }
    
    
}


//0.71
extension HomeTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: collectionView.frame.width * 0.71, height: collectionView.frame.height - 52)
            return size
     }
}

extension HomeTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCell", for: indexPath) as! HomeCollectionViewCell
        return cell
    }
}

