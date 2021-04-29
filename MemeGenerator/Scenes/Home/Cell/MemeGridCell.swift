//
//  MemeCell.swift
//  MemeGenerator
//
//  Created by than.duc.huy on 14/04/2021.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI

private enum ConstantMemeGridCell {
    static let sizeImage: CGFloat = 100
    static let fontSizeText: CGFloat = 14
    static let heightCell: CGFloat = 200
    static let radiusCell: CGFloat = 10
}

struct MemeGridCell: View {
    var item: String
    
    var body: some View {
        NavigationLink(destination: DetailView(viewModel: DetailViewModel(path: item, usecase: DetailUseCase()))) {
            VStack {
                HStack {
                    Spacer()
                    
                    AnimatedImage(url: URL(string: String(format: UrlMeme.urlImageMeme, item)))
                        .scaledToFill()
                        .clipShape(Circle())
                        .overlay(
                            Circle()
                                .stroke(Color("blue"), lineWidth: 2)
                        )
                        .frame(width: ConstantMemeGridCell.sizeImage,
                               height: ConstantMemeGridCell.sizeImage,
                               alignment: .center)
                    
                    Spacer()
                }
                .padding()
                
                Text(item)
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color("blue"))
                    .font(.system(size: ConstantMemeGridCell.fontSizeText,
                                  weight: .heavy,
                                  design: .default))
            }
            .frame(height: ConstantMemeGridCell.heightCell, alignment: .center)
            .background(Color("bgItem"))
            .cornerRadius(ConstantMemeGridCell.radiusCell)
            .clipped()
            .shadow(color: Color("dark"), radius: ConstantMemeGridCell.radiusCell, x: 0, y: 0)
            .padding()
        }
    }
}
