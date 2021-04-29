//
//  HomeView.swift
//  MemeGenerator
//
//  Created by than.duc.huy on 14/04/2021.
//

import SwiftUI
import SDWebImageSwiftUI
import Combine

private enum HomeViewConstant {
    static var columns: [GridItem] { Array(repeating: .init(.flexible()), count: 2) }
    static let spacingGridView: CGFloat = 10
    static let paddingHorizontal: CGFloat = 8
    static let titleView = "Home"
}

struct HomeView: View {
    var viewModel: HomeViewModel
    var output: HomeViewModel.Output
    
    @State var listMeme = [String]()
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        let input = HomeViewModel.Input(loadTrigger: Just<Void>(()).eraseToAnyPublisher())
        self.output = viewModel.bind(input)
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: HomeViewConstant.columns,
                          alignment: .center,
                          spacing: HomeViewConstant.spacingGridView) {
                    ForEach(listMeme, id: \.self) {
                        MemeGridCell(item: $0)
                    }
                }
                .padding(.horizontal, HomeViewConstant.paddingHorizontal)
            }
            .navigationBarTitle(HomeViewConstant.titleView)
        }
        .background(Color("bg"))
        .onReceive(output.listMeme) {
            listMeme = $0
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: HomeViewModel(usecase: HomeUseCase()))
    }
}
