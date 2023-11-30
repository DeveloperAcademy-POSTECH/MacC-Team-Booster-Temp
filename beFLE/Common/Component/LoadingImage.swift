//
//  LoadingImage.swift
//  beFLE
//
//  Created by 송재훈 on 11/30/23.
//

import SwiftUI

struct LoadingImage: View {
    let url: String?
    
    var body: some View {
        AsyncImage(url: URL(string: url ?? "")) { image in
            image
                .resizable()
                .scaledToFit()
        } placeholder: {
            LottieView()
                .frame(width: 50, height: 50)
        }
    }
}

#Preview {
    LoadingImage(url: "")
}
