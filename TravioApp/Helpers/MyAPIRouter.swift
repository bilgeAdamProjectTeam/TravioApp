//
//  MyAPIRouter.swift
//  TravioApp
//
//  Created by Şevval Çakıroğlu on 28.08.2023.
//

import Foundation

import Foundation
import Alamofire
import SwiftyJSON

enum MyAPIRouter: URLRequestConvertible {
    
    //Base URL alınıyor
    var baseURL: URL {
        return URL(string: "https://api.iosclass.live")!
    }
    
    //Keychain'den access-token okunarak değişkene atanıyor
    var token: String {
        guard let token = readFromKeychain() else { return ""}
        return token
    }
    
    func readFromKeychain() -> String? {
        let token = KeychainHelper.standard.read(service: "access-token", account: "ios-class")
        var temp = ""
        if let data = token {
            
            if let convertedString = String(data: data, encoding: .utf8) {
                temp = convertedString
            } 
        }
        return temp
    }
    
    //Router case'leri oluşturuluyor
    case postLogIn(parameters: Parameters)
    case postRegister(parameters: Parameters)
    case postUpload(image: [Data?])

    //case createPlace(paramet)
    //case postUpload
    //Place
    case postPlace(parameters: Parameters)
    case getAllPlaces(parameters: Parameters)
    case getPlaceByID(placeId: String)
    case getAllPlacesForUser //(parameters: Parameters)
    case getPopularPlaces(parameters: Parameters)
    case getLastPlaces(parameters: Parameters)
    case getCheckVisit(placeId: String)
    //Gallery
    case postImage(parameters: Parameters)
    case getAllImagesbyPlaceID(placeId: String)
    //Visit
    case postVisit(parameters: Parameters)
    case getVisits(parameters: Parameters)
    case getVisitByID(visitId : String)
    case deleteVisitByID(placeId: String)
    case getProfile
    case putProfile(parameters: Parameters)
    case putPassword(parameters: Parameters)
    
    
    //Path değişkeni case'lere göre değerleri belirleniyor
    var path: String {
        switch self {
        case .postLogIn(_):
            return "/v1/auth/login"
        case .postRegister(_):
            return "/v1/auth/register"
        case .postUpload:
            return "/upload"
        case .postPlace, .getAllPlaces:
            return "/v1/places"
        case .getPlaceByID(let placeId):
            return "/v1/places/\(placeId)"
        case .getAllPlacesForUser:
            return "/v1/places/user"
        case .postImage:
            return "/v1/galleries"
        case .getAllImagesbyPlaceID(let placeId):
            return "/v1/galleries/\(placeId)"
        case .postVisit, .getVisits:
            return "/v1/visits"
        case .getVisitByID(let visitId):
            return "/v1/visits\(visitId)"
        case .getProfile:
            return "/v1/me"
        case .putProfile:
            return "/v1/edit-profile"
//        case .postUpload(_):
//            return "/upload"
        case .getPopularPlaces:
            return "/v1/places/popular"
        case .getLastPlaces:
            return "/v1/places/last"
        case .deleteVisitByID(let placeId):
            return "/v1/visits/\(placeId)"
        case .putPassword:
            return "/v1/change-password"
        case .getCheckVisit(let placeId):
            return "/v1/visits/user/\(placeId)"
        }
    }
    
    //Method değişkeni case'lere göre değerleri belirleniyor
    var method: HTTPMethod {
        switch self {
        case .postLogIn, .postRegister, .postPlace, .postImage, .postVisit, .postUpload:
            return .post
        case .getAllPlaces, .getPlaceByID, .getAllPlacesForUser, .getAllImagesbyPlaceID, .getVisits, .getVisitByID, .getProfile, .getPopularPlaces, .getLastPlaces, .getCheckVisit:
            return .get
        case .putProfile, .putPassword:
            return .put
        case .deleteVisitByID:
            return .delete
        }
    }
    
    //
    var parameters: Parameters? {
        switch self {
        case .postLogIn(let parameters), .postRegister(let parameters), .postPlace(let parameters), .postImage(let parameters), .postVisit(let parameters), .getAllPlaces(let parameters), .getVisits(let parameters), .putProfile(let parameters), .getPopularPlaces(let parameters), .getLastPlaces(let parameters), .putPassword(let parameters) :
            return parameters
        default:
            return [:]
        }
    }
    
    
    //Headers değişkeni case'lere göre değerleri belirleniyor
    var headers: HTTPHeaders {
        switch self {
        case .postLogIn, .postRegister, .getAllPlaces, .getPlaceByID, .getAllImagesbyPlaceID, .getPopularPlaces, .getLastPlaces:
            return [:]
        case .postPlace, .getAllPlacesForUser, .postImage, .postVisit, .getVisits, .getVisitByID, .getProfile, .putProfile, .deleteVisitByID,
                .putPassword, .getCheckVisit:
            return ["Authorization" : "Bearer \(token)"]
        case .postUpload:
            return ["Content-Type": "multipart/form-data"]
        }
    }
    
    
    var multipartFormData: MultipartFormData {
        let formData = MultipartFormData()
        switch self{
        case .postUpload(let imageData):
            imageData.forEach{image in
                guard let image = image else { return }
                formData.append(image, withName: "file", fileName: "image.jpg",
                                mimeType:"image/jpeg")
            }
            return formData
        default:
            break
        }
        return formData
    }
    
    //API isteği oluşturan fonksiyon hazırlanıyor
    public func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(path)
        var request = URLRequest(url: url)
        request.timeoutInterval = 10000
        request.httpMethod = method.rawValue
        request.headers = headers
        
        
        let encoding: ParameterEncoding = {
            switch method {
            case .get:
                return URLEncoding.default
            default:
                return JSONEncoding.default
            }
        }()

        return try encoding.encode(request, with: parameters)
    }
}
