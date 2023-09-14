//
//  HelpAndSupportVC.swift
//  TravioApp
//
//  Created by Şevval Çakıroğlu on 14.09.2023.
//

import UIKit
import SnapKit

class HelpAndSupportVC: UIViewController {
    
    var viewModel = HelpsAndSupportViewModel()
    private var selectedCellIndex: Int? = nil

    
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
        label.text = "Help & Supports"
        label.font = Font.semiBold(size: 32).font
        label.textColor = .white
        return label
    }()
    
    private lazy var faqLbl : UILabel = {
        let lbl = UILabel()
        lbl.font = Font.semiBold(size: 24).font
        lbl.textColor = Color.turquoise.color
        lbl.text = "FAQ"
        return lbl
    }()
    
    private lazy var collectionView:UICollectionView = {
        
        //MARK: -- CollectionView arayüzü için sağlanan layout protocolü.
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 12
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0)
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = .clear
        cv.contentInsetAdjustmentBehavior = .never
        cv.showsHorizontalScrollIndicator = false
        cv.register(HelpAndSupportCollectionViewCell.self, forCellWithReuseIdentifier: "CustomCell")
        
        return cv
    }()

    @objc func backTapped(){
        
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()

    }
    

    func setupView(){
        
        navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = Color.turquoise.color
        
        self.view.addSubviews(backButton,header,retangle)
        retangle.addSubviews(faqLbl,collectionView)
        
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
        
        faqLbl.snp.makeConstraints({make in
            make.top.equalToSuperview().offset(44)
            make.leading.equalToSuperview().offset(24)
        })
        
        collectionView.snp.makeConstraints({make in
            make.top.equalTo(faqLbl.snp.bottom).offset(24)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        })
        
    }


}


extension HelpAndSupportVC: UICollectionViewDelegateFlowLayout {
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        //let size = CGSize(width: 342 , height: 140)
//        let size = CGSize(width: retangle.frame.width * 0.87 , height: retangle.frame.height * 0.2)
//        // let size = CGSize(width: retangle.frame.width * 0.87 , height: retangle.frame.height * 0.1)
//        return size
//     }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let isCellSelected = selectedCellIndex == indexPath.row
        
        let titleSize = CGSize(width: retangle.frame.width * 0.87, height: 36)
        let descriptionSize = isCellSelected ? CGSize(width: retangle.frame.width * 0.87, height: 60) : .zero
        
        return CGSize(width: titleSize.width, height: titleSize.height + descriptionSize.height)
    }
    
    
}

extension HelpAndSupportVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.labelviewArray.count
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCell", for: indexPath) as? HelpAndSupportCollectionViewCell else { return UICollectionViewCell() }
        
        let object = viewModel.labelviewArray[indexPath.row]
        cell.configure(data: object)
     
         return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if selectedCellIndex == indexPath.row {
            selectedCellIndex = nil // Aynı hücreye tekrar tıklanırsa kapat
        } else {
            selectedCellIndex = indexPath.row // Başka bir hücreye tıklandığında açık
        }
        
        collectionView.reloadData() // collectionView'i yeniden yükle
    }
    
    
}
