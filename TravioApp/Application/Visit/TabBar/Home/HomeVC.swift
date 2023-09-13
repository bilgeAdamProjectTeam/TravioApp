//
//  HomeVC.swift
//  TravioApp
//
//  Created by Şevval Çakıroğlu on 29.08.2023.
//


import UIKit
import SnapKit

enum PlaceType {
    case popularPlaces
    case lastPlaces
}

class HomeVC: UIViewController {
    
    let homeViewModel = HomeViewModel()
    let dispatchGroup = DispatchGroup()
    
    var popularPlacesArray: [HomePlace] = []
    var lastPlacesArray: [HomePlace] = []
    
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
    
    private lazy var tableView:UITableView = {
       let tv = UITableView()
        tv.delegate = self
        tv.dataSource = self
        tv.backgroundColor = Color.lightGray.color
        tv.separatorStyle = .none
        tv.rowHeight = UITableView.automaticDimension
        tv.estimatedRowHeight = 100
        tv.allowsSelection = false
        tv.register(HomeTableViewCell.self, forCellReuseIdentifier: "HomeTableViewCell")
        return tv
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        
        getServiceData()
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getServiceData()
        
        setupView()
    }
    
    func setupView(){
        
        view.backgroundColor = Color.turquoise.color
        
        navigationController?.navigationBar.isHidden = true
        
        view.addSubviews(retangle,
                         logo)
        
        retangle.addSubview(tableView)
        
        setupLayout()
    }
    
    
    func setupLayout(){
        
        logo.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.leading.equalToSuperview().offset(16)
            make.width.equalTo(170)
            make.height.equalTo(62)
        }
        
        retangle.snp.makeConstraints { make in
            make.top.equalTo(logo.snp.bottom).offset(35)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        tableView.snp.makeConstraints({make in
            make.top.equalToSuperview().offset(44)
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()

        })
    }
    
    func getServiceData() {
        
        dispatchGroup.enter()
        homeViewModel.getPopulerPlaces(limit: 5) { result in
            self.popularPlacesArray = result.data.places
            self.dispatchGroup.leave()
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
        
        
        dispatchGroup.enter()
        homeViewModel.getLastPlaces(limit: 5) { result in
            self.lastPlacesArray = result.data.places
            self.dispatchGroup.leave()
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
        
        dispatchGroup.notify(queue: .main) {
            self.tableView.reloadData()
        }
    }
}

extension HomeVC: HomeTableViewCellDelegate {
    func didTapSeeAllButton(placeType: PlaceType, in cell: HomeTableViewCell) {
        let vc = SeeAllVC()
        vc.placeType = placeType
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension HomeVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 262
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as! HomeTableViewCell
        
        cell.delegate = self
        
        switch indexPath.section {
        case 0:
            let data = popularPlacesArray
            cell.configureTableViewCell(with: data, title: "Popular Places", placeType: .popularPlaces)
         
        case 1:
            let data = lastPlacesArray
            cell.configureTableViewCell(with: data, title: "New Places", placeType: .lastPlaces)

        default:
            break
        }
        
        return cell
    }
}
