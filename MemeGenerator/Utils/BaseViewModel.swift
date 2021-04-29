//
//  BaseViewModel.swift
//  MemeGenerator
//
//  Created by than.duc.huy on 23/04/2021.
//

import Foundation
import Combine

protocol BaseViewModel {
    associatedtype Output
    associatedtype Input
    
    func bind(_ input: Input) -> Output
}
