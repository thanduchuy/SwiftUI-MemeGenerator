//
//  APIService.swift
//  MemeGenerator
//
//  Created by than.duc.huy on 14/04/2021.
//

import Foundation
import Alamofire
import AlamofireImage
import Combine
import SwiftUI

struct APIService {
    static let share = APIService()
    private var headers : HTTPHeaders
    private var alamofireManager = Alamofire.Session.default
    
    init() {
        headers = [
            "x-rapidapi-key": Instances.rapidapiKey,
            "x-rapidapi-host": Instances.rapidapiHost
        ]
        
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30
        configuration.timeoutIntervalForResource = 30
        alamofireManager = Alamofire.Session(configuration: configuration)
    }
    
    func request<T: Decodable, E: Error>(input: BaseRequest) -> Future<[T], E> {
        return Future({ promise in
            AF.request(
                input.url,
                method: input.requestType,
                parameters: input.body,
                headers: headers
            ).responseJSON { response in
                switch response.result {
                case .success(let value):
                    guard let result = value as? [T] else { return }
                    promise(.success(result))
                case .failure(let error):
                    promise(.failure(ErrorRequest.httpError(httpCode: error.responseCode ?? 0) as! E))
                }
            }
        })
    }
    
    func dowloadImageFromURL(imageURL: URL) -> Future<UIImage, Never> {
        return Future({ promise in
            AF.download(imageURL).responseData { response in
                if let data = response.value {
                    guard let image = UIImage(data: data) else { return }
                    promise(.success(image))
                }
            }
        })
    }
    
    func generatorURLMeme(top: String, bottom: String, meme: String) -> Future<URL, Never> {
        return Future({ promise in
            guard let top = top.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
                  let bottom = bottom.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
                  let url = URL(string: String(format: UrlMeme.generatorMeme, meme, top, bottom))
            else { return }
            
            promise(.success(url))
        })
    }
}
