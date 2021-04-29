//
//  HomeUseCase.swift
//  MemeGenerator
//
//  Created by than.duc.huy on 14/04/2021.
//

import Foundation
import Combine

protocol HomeUseCaseType {
    func fetchAllMeme() -> Future<[String], Never>
}

struct HomeUseCase: HomeUseCaseType {
    func fetchAllMeme() -> Future<[String], Never> {
        let repository = MemeRepository()
        let request = RequestAllMeme()
        
        return repository.getAllMeme(request: request)
    }
}
