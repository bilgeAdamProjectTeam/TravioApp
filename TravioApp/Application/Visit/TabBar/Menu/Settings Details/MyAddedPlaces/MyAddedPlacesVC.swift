//
//  MyAddedPlacesVC.swift
//  TravioApp
//
//  Created by Şevval Çakıroğlu on 13.09.2023.
//

import UIKit
import SnapKit

class MyAddedPlacesVC: UIViewController {
    
    var viewModel = MyAddedPlacesViewModel()
    var placesData: [HomePlace] = []
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
        label.text = "My Added Places"
        return label
    }()

    private lazy var sortButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "ascSort"), for: .normal)
        button.addTarget(self, action: #selector(ascSortTapped), for: .touchUpInside)
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
        cv.register(MyAddedPlacesViewCell.self, forCellWithReuseIdentifier: "CustomCell")
        
        return cv
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let ac = UIActivityIndicatorView()
        ac.style = .large
        ac.color = .gray
        ac.translatesAutoresizingMaskIntoConstraints = false
        return ac
    }()
    
    
    @objc func backVectorTapped(){
        
        navigationController?.popViewController(animated: true)
    }
    
    @objc func ascSortTapped() {
        
        ascendingSort.toggle()
        
        placesData.sort { (place1, place2) -> Bool in
            if ascendingSort == true {
                sortButton.setImage(UIImage(named: "ascSort"), for: .normal)
                return place1.title < place2.title
            } else {
                sortButton.setImage(UIImage(named: "descSort"), for: .normal)
                return place1.title > place2.title
            }
            
        }
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getMyAddedPlaces()
        setupView()
       
    }
    
    func getMyAddedPlaces(){
        
        viewModel.updateLoadingStatus = { [weak self] () in
            DispatchQueue.main.async {
                let isLoading = self?.viewModel.isLoading ?? false
                if isLoading {
                    self?.activityIndicator.startAnimating()
                    UIView.animate(withDuration: 0.2, animations: {
                        self?.collectionView.alpha = 0.0
                    })
                }else {
                    self?.activityIndicator.stopAnimating()
                    UIView.animate(withDuration: 0.2, animations: {
                        self?.collectionView.alpha = 1.0
                        
                    })
                    
                }
            }
        }
        
        viewModel.getMyAddedPlaces(callback: { [self] result, error in
            if let result = result {
                guard let places = viewModel.myAddedPlaces?.data.places else { return }
                self.placesData = places
                self.sortServiceData()
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
            
            if let error = error{
                CustomAlert.showAlert(in: self,
                                      title: "Error!",
                                      message: error.localizedDescription,
                                      okActionTitle: "Ok")
                
            }
        })
    }
    
    func sortServiceData() {
        placesData.sort { (place1, place2) -> Bool in
            return place1.title < place2.title
        }
    }

    func setupView(){
        
        navigationController?.navigationBar.isHidden = true
        
        self.view.backgroundColor = Color.turquoise.color
        
        self.view.addSubviews(backButton,
                         header,
                         retangle,
                         activityIndicator)

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
        
        activityIndicator.snp.makeConstraints({make in
            make.centerX.centerY.equalToSuperview()
        })
    }
    



}


extension MyAddedPlacesVC: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: collectionView.frame.width * 0.876, height: collectionView.frame.height * 0.1428)
        return size
    }
    
}

extension MyAddedPlacesVC: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return placesData.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCell", for: indexPath) as? MyAddedPlacesViewCell else { return UICollectionViewCell() }
        
        let object = placesData[indexPath.row]
        cell.configure(data: object)
        
       return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let placesData = placesData[indexPath.row]
        let placeId = placesData.id
        
        let vc = VisitsDetailVC()
        vc.placeId = placeId
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
}

