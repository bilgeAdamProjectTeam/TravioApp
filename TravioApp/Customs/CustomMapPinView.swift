//
//  CustomMapPinAnnotation.swift
//  TravioApp
//
//  Created by Şevval Çakıroğlu on 16.09.2023.
//

import MapKit

class CustomMapPinView: MKAnnotationView {
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
         image = UIImage(named: "locationMarker")
        
        canShowCallout = true // Baloncuk görünümünü etkinleştir
    }
}
