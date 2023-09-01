//
//  AddNewPlaceVC.swift
//  TravioApp
//
//  Created by Şevval Çakıroğlu on 29.08.2023.
//

import UIKit
import SnapKit
import Alamofire

class AddNewPlaceVC: UIViewController {
    
    var placeCoordinate: String?
    var selectedIndexPath: IndexPath?
    var cellImages: [UIImage?] = []
    var dataImage: [Data?] = []
    var viewModel = AddNewPlaceViewModel()
    var longitude:Double?
    var latitude:Double?
    var completionHandler: (() -> Void)?
    
    private lazy var rectangle: UIView = {
        let line = UIView()
        line.backgroundColor = .systemGray
        line.layer.cornerRadius = 6
        return line
    }()
    
    private lazy var placeName: CustomTextField = {
        let view = CustomTextField()
        view.labelText = "Place Name"
        view.placeholderName = "Please write a place name"
        view.txtField.text = ""
        view.txtField.attributedPlaceholder = NSAttributedString(string: "Place Name", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray])
        
        return view
    }()
    
    private lazy var visitDescription: CustomTextView = {
        let view = CustomTextView()
        view.labelText = "Visit Description"
        view.txtView.frame = CGRect(x: 0, y: 0, width: 310, height: 162)
        view.txtView.text = ""
        return view
    }()
    
    private lazy var country: CustomTextField = {
        let view = CustomTextField()
        view.labelText = "City, Country"
        view.placeholderName = "Paris, France"
        view.txtField.text = ""
        view.txtField.attributedPlaceholder = NSAttributedString(string: "France, Paris", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray])
        
        
        return view
    }()
    
    private lazy var collectionView:UICollectionView = {
        
        //MARK: -- CollectionView arayüzü için sağlanan layout protocolü.
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = .clear
        cv.contentInsetAdjustmentBehavior = .never
        cv.showsHorizontalScrollIndicator = false
        cv.isPagingEnabled = true
        
        cv.register(AddNewPlaceCVC.self, forCellWithReuseIdentifier: "CustomCell")
        
        return cv
        
    }()
    
    private lazy var addPlaceBtn: CustomButton = {
        let btn = CustomButton()
        btn.labelText = "Add Place"
        btn.backgroundColor = Color.turquoise.color
        btn.addTarget(self, action: #selector(addPlaceButtonTapped), for: .touchUpInside)
        
        return btn
    }()
    
    
    override func viewDidLayoutSubviews() {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.backgroundColor = Color.lightGray.color
        
        setupView()
        
        getLocation()
        
        cellImages = [UIImage?](repeating: nil, count: 3)
    }
    

    @objc func addPlaceButtonTapped() {
        
        guard let place = country.txtField.text,
              let title = placeName.txtField.text,
              let desc = visitDescription.txtView.text,
              let latitude = self.latitude,
              let longitude = self.longitude else { return }

              //let selectedIndexPath = collectionView.indexPathsForSelectedItems?.first,
              //let selectedImage = s
              

        self.viewModel.uploadPhotoAPI(image: dataImage, callback: { [self] urls in
                
                    guard let url = urls.first else { return }
                    let params = ["place": place, "title": title, "description":desc, "cover_image_url": url, "latitude": latitude, "longitude": longitude]

                    viewModel.postPlace( params: params) {
                        dismiss(animated: true, completion: {
                                    self.completionHandler?() // completionHandler'ı çağır
                                })
                    }
                })
            
            }
            
            

    
    
    @objc func openGallery() {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    func getLocation(){
        guard let placeCoordinate = placeCoordinate else {return}
        country.txtField.text = placeCoordinate
    }
    
    func setupView(){
        
        
        view.addSubviews(rectangle,
                         placeName,
                         visitDescription,
                         country,
                         addPlaceBtn,collectionView)
        
        
        
        
        setupLayout()
        
        
        
    }
    
    func setupLayout(){
        
        rectangle.snp.makeConstraints({make in
            make.top.equalToSuperview().offset(10)
            make.centerX.equalToSuperview()
            make.width.equalTo(70)
            make.height.equalTo(8)
        })
        
        placeName.snp.makeConstraints({make in
            make.top.equalTo(rectangle.snp.bottom).offset(22)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.bottom.equalToSuperview().offset(-646)
        })
        
        visitDescription.snp.makeConstraints({make in
            make.top.equalTo(placeName.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.bottom.equalToSuperview().offset(-415)
        })
        
        country.snp.makeConstraints({make in
            make.top.equalTo(visitDescription.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.bottom.equalToSuperview().offset(-325)
        })
        
        collectionView.snp.makeConstraints({make in
            make.top.equalTo(country.snp.bottom).offset(16)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-94)
        })
        
        addPlaceBtn.snp.makeConstraints({make in
            make.top.equalTo(collectionView.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.bottom.equalToSuperview().offset(-24)
        })
        
        
    }
    
}
extension AddNewPlaceVC:UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: collectionView.frame.width * 0.8, height: collectionView.frame.height - 16)
        return size
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndexPath = indexPath // Seçilen hücrenin indeksini kaydedin
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
    }
    
}


extension AddNewPlaceVC:UICollectionViewDataSource{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCell", for: indexPath) as? AddNewPlaceCVC else { return UICollectionViewCell() }
        
        if let image = cellImages[indexPath.item] {
            cell.images.image = image
            cell.stackView.isHidden = true
        } else {
            cell.images.image = nil
        }
        
        cell.roundCorners(corners: [.topLeft,.topRight,.bottomLeft], radius: 16)
        return cell
    }
    

}



extension AddNewPlaceVC: UIImagePickerControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true, completion: nil)
        
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage,
           let selectedIndexPath = selectedIndexPath {
            // Seçilen fotoğrafı ilgili hücreye ekle
            let imageToData = selectedImage.jpegData(compressionQuality: 0.5)
            dataImage.append(imageToData)
            cellImages[selectedIndexPath.item] = selectedImage
            collectionView.reloadItems(at: [selectedIndexPath])
            
        }
        
        selectedIndexPath = nil
    }
    
}



extension AddNewPlaceVC: UINavigationControllerDelegate{
    
    
}


extension UIViewController {
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}



