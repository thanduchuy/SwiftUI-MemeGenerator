//
//  MemeRepository.swift
//  MemeGenerator
//
//  Created by than.duc.huy on 14/04/2021.
//
import Foundation
import Combine
import SwiftUI

protocol MemeRepositoryType {
    func getAllMeme(request: RequestAllMeme) -> Future<[String], Never>
    func downloadImage(url: URL) -> Future<UIImage, Never>
    func generateURL(top: String, bottom: String, meme: String) -> Future<URL, Never>
}

struct MemeRepository: MemeRepositoryType {
    func getAllMeme(request: RequestAllMeme) -> Future<[String], Never> {
        return APIService.share.request(input: request)
    }
    
    func downloadImage(url: URL) -> Future<UIImage, Never> {
        return APIService.share.dowloadImageFromURL(imageURL: url)
    }
    
    func generateURL(top: String, bottom: String, meme: String) -> Future<URL, Never> {
        return APIService.share.generatorURLMeme(top: top, bottom: bottom, meme: meme)
    }
}
