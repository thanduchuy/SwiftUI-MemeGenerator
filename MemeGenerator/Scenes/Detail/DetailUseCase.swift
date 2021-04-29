//
//  DetailUseCase.swift
//  MemeGenerator
//
//  Created by than.duc.huy on 14/04/2021.
//

import Foundation
import Combine
import SwiftUI

protocol DetailUseCaseType {
    func generatorMeme(meme: String, top: String, bottom: String) -> Future<URL, Never>
    func downloadImage(url: URL) -> Future<UIImage, Never>
    func saveImage(image: UIImage) -> Bool
}

struct DetailUseCase: DetailUseCaseType {
    private let repository = MemeRepository()
    
    func downloadImage(url: URL) -> Future<UIImage, Never> {
        repository.downloadImage(url: url)
    }
    
    func saveImage(image: UIImage) -> Bool {
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        return true
    }
    
    func generatorMeme(meme: String, top: String, bottom: String) -> Future<URL, Never> {
        repository.generateURL(top: top, bottom: bottom, meme: meme)
    }
}
