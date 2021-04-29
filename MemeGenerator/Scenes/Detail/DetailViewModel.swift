//
//  DetailViewModel.swift
//  MemeGenerator
//
//  Created by than.duc.huy on 14/04/2021.
//
import SwiftUI
import Foundation
import AlamofireImage
import Combine

struct DetailViewModel {
    var path: String
    var usecase: DetailUseCaseType
}

extension DetailViewModel: BaseViewModel {
    struct Input {
        let topTextTrigger: AnyPublisher<String, Never>
        let bottomText: AnyPublisher<String, Never>
        let downloadTrigger: AnyPublisher<Void, Never>
    }
    
    struct Output {
        let generatorURL: AnyPublisher<URL, Never>
        let showAlert: AnyPublisher<Bool, Never>
    }
    
    func bind(_ input: Input) -> Output {
        let inputTop = input.topTextTrigger
            .debounce(for: 0.8, scheduler: RunLoop.main)
            .removeDuplicates()
            .dropFirst()
        
        let inputBottom = input.bottomText
            .debounce(for: 0.8, scheduler: RunLoop.main)
            .removeDuplicates()
            .dropFirst()
        
        let generatorURL = Publishers
            .CombineLatest(inputTop, inputBottom)
            .map { usecase.generatorMeme(meme: path, top: $0.0, bottom: $0.1) }
            .switchToLatest()
            .eraseToAnyPublisher()
        
        let showAlert = Publishers
            .CombineLatest(input.downloadTrigger, generatorURL)
            .map { usecase.downloadImage(url: $0.1) }
            .switchToLatest()
            .map { usecase.saveImage(image: $0) }
            .eraseToAnyPublisher()
        
        return Output(generatorURL: generatorURL,
                      showAlert: showAlert)
    }
}
