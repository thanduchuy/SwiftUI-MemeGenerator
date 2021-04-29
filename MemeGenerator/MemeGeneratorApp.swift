//
//  MemeGeneratorApp.swift
//  MemeGenerator
//
//  Created by than.duc.huy on 14/04/2021.
//

import SwiftUI

@main
struct MemeGeneratorApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView(viewModel: HomeViewModel(usecase: HomeUseCase()))
        }
    }
}
