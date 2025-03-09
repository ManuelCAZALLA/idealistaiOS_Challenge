//
//  ImagePreview.swift
//  idealistaiOS_Challenge
//
//  Created by Manuel Cazalla Colmenero on 9/3/25.
//

import SwiftUI
import Kingfisher

struct ImagePreviewView: View {
    let imageUrls: [String]

    var body: some View {
        NavigationView {
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                
                TabView {
                    ForEach(imageUrls, id: \.self) { imageUrl in
                        KFImage(URL(string: imageUrl))
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))  // Indicadores de página en el TabView
            }
        }
    }
}

#Preview {
    ImagePreviewView(imageUrls: ["",""])
}
