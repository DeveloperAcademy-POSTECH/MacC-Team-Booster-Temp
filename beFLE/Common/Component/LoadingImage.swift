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
            HStack {
                Spacer()
                image
                    .resizable()
                    .scaledToFit()
            }
        } placeholder: {
            VStack(alignment: .center) {
                LottieView()
                    .frame(width: 50, height: 50)
                    .padding(.horizontal, 400)
                Spacer()
            }
        }
    }
}

#Preview {
    LoadingImage(url: "")
}
