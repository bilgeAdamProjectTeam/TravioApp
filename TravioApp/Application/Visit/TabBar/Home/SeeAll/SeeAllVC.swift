//
//  SeeAllVC.swift
//  TravioApp
//
//  Created by Şevval Çakıroğlu on 30.08.2023.
//

import UIKit
import SnapKit

class SeeAllVC: UIViewController {
    
    private lazy var retangle: UIView = {
        let view = CustomView()
        return view
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "back"), for: .normal)
        button.addTarget(self, action: #selector(backVectorTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var header: UILabel = {
        let label = UILabel()
        label.text = "Popular Places" // dinamik olarak değişecek
        label.font = Font.semiBold(size: 32).font
        label.textColor = .white
        return label
    }()
    
    private lazy var stackViewSortIcon: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.alignment = .center
        sv.distribution = .fillEqually
        sv.spacing = 20
        return sv
    }()
    
    private lazy var sortDownButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "sortDownIcon"), for: .normal)
        return button
    }()
    
    private lazy var sortUpButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "sortUpIcon"), for: .normal)
        return button
    }()
    
    private lazy var collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)

        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = .clear
        cv.contentInsetAdjustmentBehavior = .never
        cv.showsHorizontalScrollIndicator = false
        cv.isPagingEnabled = true
        cv.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        cv.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: "CustomCell")
        
        return cv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    @objc func backVectorTapped(){
        
        navigationController?.popViewController(animated: true)
    }
    
    func setupView(){
        
        navigationController?.navigationBar.isHidden = true
        
        view.backgroundColor = Color.turquoise.color
        
        view.addSubviews(backButton,
                         header,
                         retangle)
        
        stackViewSortIcon.addArrangedSubviews(sortDownButton,
                                              sortUpButton)
        
        retangle.addSubviews(stackViewSortIcon,
                             collectionView)
        
        setupLayout()
    }
    
    
    func setupLayout(){
        
        retangle.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(125)
            make.leading.trailing.bottom.equalToSuperview()
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
        
        stackViewSortIcon.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.leading.equalToSuperview().offset(296)
        }
        
        collectionView.snp.makeConstraints({make in
            make.top.equalTo(stackViewSortIcon.snp.bottom).offset(24)
            make.leading.trailing.bottom.equalToSuperview()
        })
    }
}


extension SeeAllVC: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: 342, height: 89)
        return size
    }
}

extension SeeAllVC: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
  
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCell", for: indexPath) as? HomeCollectionViewCell else { return UICollectionViewCell() }
        
        return cell
    }
}
