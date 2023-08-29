//
//  VisitsDetailVC.swift
//  TravioApp
//
//  Created by Şevval Çakıroğlu on 29.08.2023.
//


import UIKit
import MapKit
import SnapKit

class VisitsDetailVC: UIViewController {
    
    
    var viewModel = VisitsViewModel()
    var id = ""
    var travelImage : [Image]?
    var detailTravel: Travel?
    
    private lazy var gradient:UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "Rectangle")
        //darkmode olduğunda diğeri gelecek
       return img
    }()

    
    private lazy var collectionView:UICollectionView = {

        //MARK: -- CollectionView arayüzü için sağlanan layout protocolü.
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 10
        layout.scrollDirection = .horizontal
        
        
       
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = Color.darkGray.color
        cv.contentInsetAdjustmentBehavior = .never
        cv.showsHorizontalScrollIndicator = false
        cv.isPagingEnabled = true
        cv.register(VisitsDetailCell.self, forCellWithReuseIdentifier: "CustomCell")
      
        return cv
        
    }()
    
    private lazy var pageControl:UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.currentPage = 0
        pageControl.backgroundColor = Color.lightGray.color
        pageControl.allowsContinuousInteraction = false
        pageControl.layer.cornerRadius = 12
        pageControl.pageIndicatorTintColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.addTarget(self, action: #selector(pageControlValueChanged), for: .valueChanged)
        return pageControl
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = Color.lightGray.color
        scrollView.addSubview(scrollContentView)
        scrollView.isScrollEnabled = true
        return scrollView
    }()
    
    private lazy var scrollContentView: UIView = {
        let view = UIView()
        view.addSubviews(titleLabel,dateLabel,mapView,descriptionLbl)
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "İstanbul"
        lbl.font = Font.semiBold(size: 30).font
        return lbl
    }()
    
    private lazy var dateLabel:UILabel = {
        let lbl = UILabel()
        lbl.text = "5 Şubat 1998"
        lbl.font = Font.regular(size: 14).font
        return lbl
    }()
    
    private lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        mapView.delegate = self
        
        
        return mapView
        
    }()
    
    private lazy var descriptionLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = """
 Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum
 """
        lbl.font = Font.regular(size: 14).font
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let ac = UIActivityIndicatorView()
        ac.style =  UIActivityIndicatorView.Style.large//.whiteLarge
        return ac
    }()
    
    override func viewDidAppear(_ animated: Bool) {
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: scrollContentView.frame.height)
        mapView.roundCorners(corners: [.bottomLeft,.topLeft,.topRight], radius: 16)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()


        
        setupView()
        

        viewModel.isLoadingDidChange = { [weak self] isLoading in
                    DispatchQueue.main.async {
                        if isLoading {
                            self?.activityIndicator.startAnimating()
                            print("indicator çalıştı")
                        } else {
                            self?.activityIndicator.stopAnimating()
                            print("indicator durdu")
                        }
                    }
                }
        
        
        viewModel.getImages(id: id) {
            guard let imagesArr = self.viewModel.imagesArr else {return}
            self.travelImage = imagesArr.data.images
            
            //viewModel.imagesArr?.data.images[0].caption
            self.collectionView.reloadData()

        }
        getTravelDetail()
        
        //
        if traitCollection.userInterfaceStyle == .dark {
            // Dark mode ise
            gradient.image = UIImage(named: "gradient")
        } else {
            // Light mode ise
            gradient.image = UIImage(named: "Rectangle")
        }

    }
    
    @objc func pageControlValueChanged(){
        let currentPage = pageControl.currentPage
        let indexPath = IndexPath(item: currentPage, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    //MARK: --
    func setupView(){
        
//        let yourView = UIView()
//        yourView.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(yourView)
//        yourView.snp.makeConstraints({make in
//            make.edges.equalToSuperview()
//        })
        
        view.backgroundColor = Color.lightGray.color
        navigationController?.isNavigationBarHidden = true
        view.addSubviews(collectionView,
                         gradient,
                         pageControl,
                         scrollView,
                         activityIndicator)
        
        setupLayout()
        
    }
    
    /// Description
    /// - Parameters:
    ///   - visitDate: visitDate description
    ///   - label: label description
    ///
    func dateFormatter(visitDate: String, label: UILabel) {
       
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            if let date = dateFormatter.date(from: visitDate) {
                dateFormatter.dateFormat = "dd - MMMM - yyyy" // Ayın tam adını yazdırmak için
                label.text = dateFormatter.string(from: date)
            
        }
    }
    
    func setMapView(latitude:Double, longitude:Double){
        guard let detailTravel = detailTravel else {return}
        let locationCoordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let annotation = MKPointAnnotation()
        annotation.coordinate = locationCoordinate
        annotation.title = detailTravel.location
        mapView.addAnnotation(annotation)
        let region = MKCoordinateRegion(center: locationCoordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)
        mapView.setRegion(region, animated: true)
    }

    
    func getTravelDetail(){
        guard let title = self.detailTravel?.location, let date = self.detailTravel?.visit_date, let  information = self.detailTravel?.information else {return}
            self.titleLabel.text = title
        dateFormatter(visitDate: date, label: self.dateLabel)
       // locationCoordinate = CLLocationCoordinate2D(latitude: detailTravel?.latitude, longitude: detailTravel?.longitude)
            self.descriptionLbl.text = information
        
        // Mapview
        
        setMapView(latitude: Double(detailTravel!.latitude), longitude: Double(detailTravel!.longitude))
        

        
    }
    
    func setupLayout(){
        
        gradient.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().offset(0)
            make.bottom.equalTo(collectionView.snp.bottom)
            make.height.equalTo(110)

        }
        
        collectionView.snp.makeConstraints({ make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(250)
        })
        
        pageControl.snp.makeConstraints({ make in
            make.bottom.equalTo(collectionView.snp.bottom).offset(-10)
            make.centerX.equalToSuperview()
            make.width.equalTo(74)
            make.height.equalTo(24)
        })
        
        scrollView.snp.makeConstraints({ make in
            make.top.equalTo(collectionView.snp.bottom)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        })
        
        scrollContentView.snp.makeConstraints({ make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.width.equalToSuperview()
        })
        
        titleLabel.snp.makeConstraints({ make in
            make.top.equalToSuperview().offset(24)
            make.leading.equalToSuperview().offset(24)
        })
        
        dateLabel.snp.makeConstraints({ make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.leading.equalToSuperview().offset(26)
        })
        
        mapView.snp.makeConstraints({ make in
            make.top.equalTo(dateLabel.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(227)
        })
        
        descriptionLbl.snp.makeConstraints({ make in
            make.top.equalTo(mapView.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        })
        
        scrollContentView.snp.makeConstraints({make in
            make.bottom.equalTo(descriptionLbl.snp.bottom).offset(20)
        })
        
        activityIndicator.snp.makeConstraints { make in
                make.center.equalTo(collectionView)
            }
        
        
        
    }
 

}

 
extension VisitsDetailVC:UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: view.frame.width, height: 250)
        return size
    }
}


extension VisitsDetailVC:UICollectionViewDataSource{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      
        guard let travelImage = travelImage else {return 0}
        
        return travelImage.count
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCell", for: indexPath) as? VisitsDetailCell else { return UICollectionViewCell() }

        if let travelImage {
            
            cell.configure(with: (travelImage[indexPath.row]))
            
            pageControl.numberOfPages = travelImage.count
        }
        
        
        
        
//        guard let travelImage = travelImage else {return UICollectionViewCell() }
//        pageControl.numberOfPages = travelImage.count
        
        return cell
    }
    
}

extension VisitsDetailVC: MKMapViewDelegate {
    
    
}



