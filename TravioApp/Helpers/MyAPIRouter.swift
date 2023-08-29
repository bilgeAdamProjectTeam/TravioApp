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
                print("Converted String: \(convertedString)")
            } else {
                print("Failed to convert data to string.")
            }
        }
        return temp
    }
    
    //Router case'leri oluşturuluyor
    case postLogIn(parameters: Parameters)
    case postRegister(parameters: Parameters)

    //case createPlace(paramet)
    //case postUpload
    //Place
    case postPlace(parameters: Parameters)
    case getAllPlaces(parameters: Parameters)
    case getPlaceByID(placeId: String)
    case getAllPlacesForUser(parameters: Parameters)
    //Gallery
    case postImage(parameters: Parameters)
    case getAllImagesbyPlaceID(placeId: String)
    //Visit
    case postVisit(parameters: Parameters)
    case getVisits(parameters: Parameters)
    case getVisitByID(visitId : String)
    
    
    
    //Path değişkeni case'lere göre değerleri belirleniyor
    var path: String {
        switch self {
        case .postLogIn(_):
            return "/v1/auth/login"
        case .postRegister(_):
            return "/v1/auth/register"
//        case .postUpload:
//            return "/upload"
        case .postPlace, .getAllPlaces:
            return "/v1/places"
        case .getPlaceByID(let placeId):
            return "/v1/places/\(placeId)"
        case .getAllPlacesForUser:
            return "/v1/places/user"
        case .postImage:
            return "/v1/galleries"
        case .getAllImagesbyPlaceID(let placeId):
            return "/v1/galleries\(placeId)"
        case .postVisit, .getVisits:
            return "/v1/visits"
        case .getVisitByID(let visitId):
            return "/v1/visits\(visitId)"
        }
    }
    
    //Method değişkeni case'lere göre değerleri belirleniyor
    var method: HTTPMethod {
        switch self {
        case .postLogIn, .postRegister, .postPlace, .postImage, .postVisit:
            return .post
        case .getAllPlaces, .getPlaceByID, .getAllPlacesForUser, .getAllImagesbyPlaceID, .getVisits, .getVisitByID:
            return .get
        }
    }
    
    //
    var parameters: Parameters? {
        switch self {
        case .postLogIn(let parameters), .postRegister(let parameters), .postPlace(let parameters), .postImage(let parameters), .postVisit(let parameters), .getAllPlaces(let parameters) :
            return parameters
        default:
            return [:]
        }
    }
    
    
    //Headers değişkeni case'lere göre değerleri belirleniyor
    var headers: HTTPHeaders {
        switch self {
        case .postLogIn, .postRegister, .getAllPlaces, .getPlaceByID, .getAllImagesbyPlaceID:
            return [:]
        case .postPlace, .getAllPlacesForUser, .postImage, .postVisit, .getVisits, .getVisitByID:
            return ["Authorization" : "Bearer \(token)"]
        }
    }
    
    
    //API isteği oluşturan fonksiyon hazırlanıyor
    public func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(path)
        var request = URLRequest(url: url)
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
