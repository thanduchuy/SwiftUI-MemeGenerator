//
//  RequestAllMeme.swift
//  MemeGenerator
//
//  Created by than.duc.huy on 14/04/2021.
//

import Foundation

final class RequestAllMeme: BaseRequest {
    required init() {
        let url = UrlMeme.getAllMeme
        super.init(url: url, requestType: .get)
    }
}
