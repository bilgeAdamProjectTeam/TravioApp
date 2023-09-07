//
//  CustomAlert.swift
//  TravioApp
//
//  Created by Şevval Çakıroğlu on 7.09.2023.
//

import UIKit

class CustomAlert {
    
    static func showAlert(
        in viewController: UIViewController,
        title: String,
        message: String,
        okActionTitle: String = "OK",
        cancelActionTitle: String? = nil,
        okCompletion: (() -> Void)? = nil,
        cancelCompletion: (() -> Void)? = nil
    ) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: okActionTitle, style: .default) { _ in
            okCompletion?()
        }
        
        alertController.addAction(okAction)
        
        if let cancelTitle = cancelActionTitle {
            let cancelAction = UIAlertAction(title: cancelTitle, style: .cancel) { _ in
                cancelCompletion?()
            }
            alertController.addAction(cancelAction)
        }
        
        viewController.present(alertController, animated: true, completion: nil)
    }
}


//CustomAlert.showAlert(
//    in: self,
//    title: "Başlık",
//    message: "Mesaj",
//    okActionTitle: "Tamam",
//    cancelActionTitle: "İptal",
//    okCompletion: {
//        print("Tamam düğmesine tıklandı.")
//    },
//    cancelCompletion: {
//        print("İptal düğmesine tıklandı.")
//    }
//)
