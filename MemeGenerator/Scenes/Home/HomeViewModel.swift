//
//  HomeViewModel.swift
//  MemeGenerator
//
//  Created by than.duc.huy on 14/04/2021.
//

import Foundation
import Combine

struct HomeViewModel {
    var usecase: HomeUseCaseType
}

extension HomeViewModel: BaseViewModel {
    struct Input {
        let loadTrigger: AnyPublisher<Void, Never>
    }
    
    struct Output {
        let listMeme: AnyPublisher<[String], Never>
    }
    
    func bind(_ input: Input) -> Output {
        let listMeme = input.loadTrigger
            .flatMap { usecase.fetchAllMeme() }
            .eraseToAnyPublisher()

        return Output(listMeme: listMeme)
    }
}
