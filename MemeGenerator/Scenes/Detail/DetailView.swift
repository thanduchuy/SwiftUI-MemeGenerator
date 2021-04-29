//
//  DetailView.swift
//  MemeGenerator
//
//  Created by than.duc.huy on 14/04/2021.
//

import SwiftUI
import Combine
import SDWebImageSwiftUI

private enum ConstantDetailView {
    static let topTextPlaceHolder = "Enter Top Text"
    static let bottomTextPlaceHolder = "Enter Bottom Text"
    static let headerSectionTextField = "Generator"
    static let footerSectionTextField = "APIMeme Meme Generator"
    static let headerSectionImage = "Image Output"
    static let titleView = "Detail"
}

struct DetailView: View {
    private var viewModel: DetailViewModel
    private var output: DetailViewModel.Output
    private var downloadTrigger = PassthroughSubject<Void, Never>()
    
    @SubjectBinding private var topText = ""
    @SubjectBinding private var bottomText = ""
    @State private var urlGenerator = URL(string: "")
    @State private var showAlert = false
    
    init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
        self.output = viewModel.bind(DetailViewModel.Input(topTextTrigger: _topText.anyPublisher(),
                                                           bottomText:  _bottomText.anyPublisher(),
                                                           downloadTrigger: downloadTrigger.eraseToAnyPublisher()))
    }
    
    var body: some View {
        VStack {
            Form {
                Section(header: Text(ConstantDetailView.headerSectionTextField),
                        footer: Text(ConstantDetailView.footerSectionTextField)) {
                    TextField(ConstantDetailView.topTextPlaceHolder, text: $topText)
                    TextField(ConstantDetailView.bottomTextPlaceHolder, text: $bottomText)
                }
                
                Section(header: Text(ConstantDetailView.headerSectionImage)) {
                    AnimatedImage(url: urlGenerator)
                        .indicator(SDWebImageActivityIndicator.medium)
                        .transition(.fade)
                        .resizable()
                        .scaledToFill()
                    
                    HStack {
                        Spacer()
                        
                        Button(action: {
                            downloadTrigger.send()
                        }) {
                            Image(systemName: "arrow.down.doc")
                        }
                        .padding()
                        .background(Color("blue"))
                        .foregroundColor(Color("bg"))
                        .clipShape(Circle())
                        
                        Spacer()
                    }
                }
            }
        }
        .navigationBarTitle(ConstantDetailView.titleView)
        .onReceive(output.generatorURL) {
            urlGenerator = $0
        }
        .onReceive(output.showAlert) {
            showAlert = $0
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Download Finish"),
                  message: Text("Image is saved"),
                  dismissButton: .default(Text("OK"),
                                          action: { showAlert = false }))
        }
    }
}
