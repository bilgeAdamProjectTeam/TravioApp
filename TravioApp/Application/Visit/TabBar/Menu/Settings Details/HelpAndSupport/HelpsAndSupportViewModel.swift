//
//  HelpsAndSupportViewModel.swift
//  TravioApp
//
//  Created by Şevval Çakıroğlu on 14.09.2023.
//

import Foundation
import UIKit

class HelpsAndSupportViewModel{
    
    var labelviewArray:[Helps] = [Helps(labelTitle: "Uygulamanız nasıl çalışır?", labelDescription: "Uygulamamızı indirdikten sonra bir hesap oluşturun ve seyahat planlarınızı hemen yapmaya başlayın.", checkHidden: true ),
                                  Helps(labelTitle: "Üyelik ücretli mi?", labelDescription: "Temel özellikler ücretsizdir, fakat premium özellikler için üyelik planımızı satın alabilirsiniz.", checkHidden: true),
                                  Helps(labelTitle: "Biletlerimi nasıl iptal edebilirim?", labelDescription: "Hesabınızdaki 'Biletlerim' bölümünden iptal işlemini gerçekleştirebilirsiniz.", checkHidden: true),
                                  Helps(labelTitle: "Ödeme seçenekleri neler?", labelDescription: "Kredi kartı, banka havalesi ve PayPal gibi çeşitli ödeme seçeneklerimiz mevcuttur.", checkHidden: true),
                                  Helps(labelTitle: "Çocuklar için indirim var mı?", labelDescription: "Evet, 12 yaş altı çocuklar için %50 indirim sağlamaktayız.", checkHidden: true),
                                  Helps(labelTitle: "Check-in nasıl yapılır?", labelDescription:"Mobil uygulamamız üzerinden veya havaalanındaki kiosklardan check-in yapabilirsiniz.", checkHidden: true),
                                  Helps(labelTitle: "Bagaj hakkım nedir?", labelDescription: "Bagaj hakkı seyahatin türüne göre değişkenlik göstermektedir.", checkHidden: true),
                                  Helps(labelTitle: "Uçakta yemek var mı?", labelDescription: "Evet, uzun mesafeli uçuşlarda ücretsiz yemek servisi yapmaktayız.", checkHidden: true),
                                  Helps(labelTitle: "Promosyon kodu nasıl kullanılır?", labelDescription: "Ödeme ekranında 'Promosyon Kodu' bölümüne kodunuzu girebilirsiniz.", checkHidden: true),
                                  Helps(labelTitle: "Promosyon kodu nasıl kullanılır?", labelDescription: "Ödeme ekranında 'Promosyon Kodu' bölümüne kodunuzu girebilirsiniz.", checkHidden: true),Helps(labelTitle: "Evcil hayvan kabul ediliyor mu?", labelDescription: "Evet, ancak belirli kurallar ve ücretler vardır.", checkHidden: true),
                                  Helps(labelTitle: "WiFi var mı?", labelDescription: "Evet, tüm uçuşlarımızda ücretli WiFi hizmetimiz vardır.", checkHidden: true),
                                  Helps(labelTitle: "Grup indirimi var mı?", labelDescription: "Evet, 10 kişi ve üzeri gruplar için özel indirimlerimiz bulunmaktadır.", checkHidden: true),
                                  Helps(labelTitle: "Seyahat sigortası yapılıyor mu?", labelDescription: "Evet, ek bir ücret karşılığı seyahat sigortası yapabilirsiniz.", checkHidden: true)]
    


    func calculateTextSize(text: String, font: UIFont) -> CGSize {
        let attributes = [NSAttributedString.Key.font: font]
        let size = (text as NSString).size(withAttributes: attributes)
        
        return size
    }

}
