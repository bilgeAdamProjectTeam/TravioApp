//
//  SeeAllVC.swift
//  TravioApp
//
//  Created by Şevval Çakıroğlu on 30.08.2023.
//

import UIKit
import SnapKit

class SeeAllVC: UIViewController {
    
    var placeType: PlaceType?
    var placesData: [HomePlace] = []
    let viewModel = HomeViewModel()
    var ascendingSort = true
    var placeId = ""
    
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
        label.font = Font.semiBold(size: 32).font
        label.textColor = .white
        return label
    }()

    private lazy var sortButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "sortUpIcon"), for: .normal)
        button.addTarget(self, action: #selector(sortButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 5, left: 0, bottom: 15, right: 0)

        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = .clear
        cv.contentInsetAdjustmentBehavior = .never
        cv.showsHorizontalScrollIndicator = false
        cv.isPagingEnabled = true
        cv.register(SeeAllCollectionViewCell.self, forCellWithReuseIdentifier: "CustomCell")
        
        return cv
    }()
    
    
    @objc func backVectorTapped(){
        
        navigationController?.popViewController(animated: true)
    }

    @objc func sortButtonTapped() {
        
        ascendingSort.toggle()
        
        placesData.sort { (place1, place2) -> Bool in
            if ascendingSort == true {
                sortButton.setImage(UIImage(named: "sortUpIcon"), for: .normal)
                return place1.title < place2.title
            } else {
                sortButton.setImage(UIImage(named: "sortDownIcon"), for: .normal)
                return place1.title > place2.title
            }
            
        }
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let placeType = placeType else { return }
        getServiceData(placeType: placeType)
        
        setupView()
    }
    
    func setupView(){
        
        navigationController?.navigationBar.isHidden = true
        
        self.view.backgroundColor = Color.turquoise.color
        
        self.view.addSubviews(backButton,
                         header,
                         retangle)

        retangle.addSubviews(sortButton,
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
        
        sortButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
        }
        
        collectionView.snp.makeConstraints({make in
            make.top.equalTo(sortButton.snp.bottom).offset(24)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        })
    }
    
    func getServiceData(placeType: PlaceType) {
        
        switch placeType {
        case .popularPlaces:
            viewModel.getPopulerPlaces(limit: 20) { result in
                self.placesData = result.data.places
                self.sortServiceData()
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            } errorCallback: {error in
                if let error = error {
                    CustomAlert.showAlert(
                        in: self,
                        title: "Error!",
                        message: error.localizedDescription,
                        okActionTitle: "Ok"
                    )
                }
            }
        case .lastPlaces:
            viewModel.getLastPlaces(limit: 20) { result in
                self.placesData = result.data.places
                self.sortServiceData()
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            } errorCallback: {error in
                if let error = error {
                    CustomAlert.showAlert(
                        in: self,
                        title: "Error!",
                        message: error.localizedDescription,
                        okActionTitle: "Ok"
                    )
                }
            }
        default:
            break
        }
    }
    
    func sortServiceData() {
        placesData.sort { (place1, place2) -> Bool in
            return place1.title < place2.title
        }
    }
}

extension SeeAllVC: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: collectionView.frame.width * 0.876, height: collectionView.frame.height * 0.1428)
        return size
    }
}

extension SeeAllVC: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return placesData.count
    }
  
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCell", for: indexPath) as? SeeAllCollectionViewCell else { return UICollectionViewCell() }

        switch placeType {
        case .popularPlaces:
            self.header.text = "Popular Places"
            let data = placesData[indexPath.row]
            cell.configure(data: data)
        case .lastPlaces:
            self.header.text = "New Places"
            let data = placesData[indexPath.row]
            cell.configure(data: data)
        default:
            break
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let placeData = placesData[indexPath.row]
        let placeId = placeData.id
        
        let vc = VisitsDetailVC()
        vc.placeId = placeId
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}
