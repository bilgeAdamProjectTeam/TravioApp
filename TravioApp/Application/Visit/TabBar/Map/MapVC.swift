//
//  MapVC.swift
//  TravioApp
//
//  Created by Şevval Çakıroğlu on 29.08.2023.
//


import UIKit
import MapKit
import SnapKit

class MapVC: UIViewController, MKMapViewDelegate {
    
    var viewModel = MapViewModel()
    var allPlaces: [Place]?
    var address:String?
    
    private lazy var mapView: MKMapView = {
        let map = MKMapView(frame: self.view.frame)
        self.view.addSubview(map)

        let rotation = CLLocationCoordinate2D(latitude: 41.0082, longitude: 28.9784)
        
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(getLocationLongPress))
        map.addGestureRecognizer(longPressGesture)
        
        let region = MKCoordinateRegion(center: rotation, latitudinalMeters: 100000, longitudinalMeters: 100000)
        map.setRegion(region, animated: true)
        map.delegate = self
        map.isUserInteractionEnabled = true
        
        return map
        
    }()
    
    
    private lazy var collectionView:UICollectionView = {
        
        //MARK: -- CollectionView arayüzü için sağlanan layout protocolü.
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 18, bottom: 0, right: 0)

        
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = .clear
        cv.contentInsetAdjustmentBehavior = .never
        cv.showsHorizontalScrollIndicator = false
        cv.isPagingEnabled = true
        
        cv.register(MapCollectionViewCell.self, forCellWithReuseIdentifier: "CustomCell")
        
        return cv
    }()
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
    
        setupView()
        
        viewModel.getAllPlace(callback: { result in
            //self.allPlaces?.append(contentsOf: result.data.places)
            self.allPlaces = result.data?.places
            self.collectionView.reloadData()
        })

    }
    

    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        
        let identifier = "locationMarker"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
        } else {
            annotationView?.annotation = annotation
        }
        
        if let pinImage = UIImage(named: "annotation") {
            let size = CGSize(width: 32, height: 42)
            
            UIGraphicsBeginImageContext(size)
            pinImage.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
            let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            annotationView?.image = resizedImage
        }
        return annotationView
    }
    
    
    @objc func getLocationLongPress(sender: UILongPressGestureRecognizer) {

        if sender.state == .began {
            let touchPoint = sender.location(in: mapView)
            let coordinate = mapView.convert(touchPoint, toCoordinateFrom: mapView)
            
            // Create a map annotation
            let annotation = MKPointAnnotation()
            
            annotation.coordinate = coordinate
            annotation.title = "New Place"
            annotation.subtitle = "Description"
            
            // Add the annotation to the map view
           // mapView.addAnnotation(annotation)
            
            let location = CLLocation(latitude:coordinate.latitude, longitude: coordinate.longitude)
            let geocoder = CLGeocoder()
            
            geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
                if let error = error {
                    print("Hata: \(error)")
                    return
                }
                
                guard let placemark = placemarks?.first else {
                    print("Yer bulunamadı.")
                    return
                }
                
                if let city = placemark.administrativeArea,
                   let country = placemark.country {
                    self.address = "\(city),\(country)"
                } else {
                    print("Yer adı alınamadı.")
                }
                
                let vc = AddNewPlaceVC()
                vc.preferredContentSize = CGSize(width: 390, height: 790)
                vc.placeCoordinate = self.address
                vc.longitude = coordinate.longitude
                vc.latitude = coordinate.latitude
                
                vc.completionHandler = {
                                self.mapView.addAnnotation(annotation) // Pin ekleme
                            }
    
                self.present(vc, animated: true, completion: nil)
                //print("latitude: \(coordinate.latitude)", "longitude: \(coordinate.longitude)")
                
            }
            
           
            
           
        }
        
        // return coordinate
    }
    
    func setupView(){
        view.addSubviews(mapView,collectionView)
        
        setupLayout()
    }
    
    
    func setupLayout(){
        
        mapView.snp.makeConstraints({make in
            make.edges.equalToSuperview()
        })
        
        collectionView.snp.makeConstraints({make in
            make.top.equalToSuperview().offset(565)
            make.bottom.equalToSuperview().offset(-101)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            
        })
        
    }
}


extension MapVC: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: 309, height: 178)
        return size
    }
    
}

extension MapVC: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let allPlaces = allPlaces else {return 0}
        return allPlaces.count
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCell", for: indexPath) as? MapCollectionViewCell else { return UICollectionViewCell() }
        
        guard let allPlaces = allPlaces else {return  UICollectionViewCell() }

        let places = allPlaces[indexPath.item]
        
        cell.configure(with: places)
        cell.roundCorners(corners: [.topLeft, .topRight, .bottomLeft], radius: 16)
        
        return cell
    }
    
    
    
}

