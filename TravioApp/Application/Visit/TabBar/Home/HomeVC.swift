//
//  HomeVC.swift
//  TravioApp
//
//  Created by Şevval Çakıroğlu on 29.08.2023.
//


import UIKit
import SnapKit

class HomeVC: UIViewController {
    
    let homeViewModel = HomeViewModel()
    var serviceDataArray: [[HomePlace]] = [[]]
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        homeViewModel.fetchHomeData { result in
            self.serviceDataArray = result
        }
        
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
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(28)
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
}

extension HomeVC: HomeTableViewCellDelegate {
    
    func didTapSeeAllButton(in cell: HomeTableViewCell) {
        let vc = SeeAllVC()
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension HomeVC: UITableViewDelegate{

    
}

extension HomeVC: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 262// Hücre yüksekliği
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
        
//        switch indexPath.section {
//        case 0:
//            let data = homeViewModel.popularPlacesArray[indexPath.row]
//            print("Data-------:\(data)")
//            cell.configure(with: data)
//        case 1:
//            let data = homeViewModel.lastPlacesArray[indexPath.row]
//            cell.configure(with: data)
//        case 2:
//            let data = homeViewModel.lastPlacesArray[indexPath.row]
//            cell.configure(with: data)
//        default:
//            break
//        }
        
        switch indexPath.section {
        case 0:
            let data = serviceDataArray[indexPath.row]
            cell.configure(with: data)

        case 1:
            let data = serviceDataArray[indexPath.row]
            cell.configure(with: data)
  
        default:
            break
        }
        
        return cell
    }
    
    
}
