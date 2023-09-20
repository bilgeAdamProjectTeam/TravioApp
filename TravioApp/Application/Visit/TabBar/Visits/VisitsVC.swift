//
//  VisitsVC.swift
//  TravioApp
//
//  Created by Şevval Çakıroğlu on 29.08.2023.
//



import SnapKit
import UIKit


class VisitsVC: UIViewController {
    
    let viewModel = VisitsViewModel()

    private lazy var retangle: UIView = {
        let view = CustomView()
        return view
    }()
    
    private lazy var header: UILabel = {
        let label = UILabel()
        label.text = "My Visits"
        label.font =  Font.semiBold(size: 36).font
        label.textColor = .white
        return label
    }()
    
     lazy var MyCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 45, left: 0, bottom: 0, right: 0)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.minimumLineSpacing = 16
        cv.delegate = self
        cv.dataSource = self
        cv.register(VisitsCVC.self, forCellWithReuseIdentifier: "CustomCell")
        cv.backgroundColor = Color.lightGray.color
        return cv
    }()
    
    override func viewWillAppear(_ animated: Bool) {

        configureVM()
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        
        configureVM()
      
    }
    
    func setupViews() {
        view.backgroundColor =  Color.turquoise.color
        navigationController?.navigationBar.isHidden = true
        view.addSubviews(retangle,
                         header)
        retangle.addSubviews(MyCollection)
        setupLayouts()
    }
    
    func setupLayouts() {
        retangle.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(128)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        header.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.leading.equalToSuperview().offset(24)
        }
        
        MyCollection.snp.makeConstraints { make in
            make.bottom.leading.trailing.equalToSuperview()
            make.top.equalToSuperview()
        }
    }
    
    func configureVM() {
        viewModel.getVisits { error in
            if let error = error {
                CustomAlert.showAlert(
                    in: self,
                    title: "Error!",
                    message: error.localizedDescription,
                    okActionTitle: "Ok"
                )
                
            }else {
                DispatchQueue.main.async {
                    self.MyCollection.reloadData()
                }
            }

        }
    }
}

extension VisitsVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        guard let visits = viewModel.visits else { return 0 }
        return visits.count
        
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCell", for: indexPath) as? VisitsCVC else { return UICollectionViewCell() }
       
        guard let visits = viewModel.visits else { return UICollectionViewCell() }
        let visit = visits[indexPath.item]
        
        cell.configure(with: visit)
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width - 56, height: 219)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let visits = viewModel.visits else { return }
        let visitData = visits[indexPath.row]
        let placeId = visitData.place_id
        
        let vc = VisitsDetailVC()
        vc.placeId = placeId
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}
