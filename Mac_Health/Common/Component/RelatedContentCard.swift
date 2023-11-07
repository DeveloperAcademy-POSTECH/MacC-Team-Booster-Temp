//
//  RelatedContentCard.swift
//  Mac_Health
//
//  Created by 송재훈 on 2023/10/22.
//

import SwiftUI

struct RelatedContentCard: View {
    let videoNum: Int
    let contentURL: String
    
    var body: some View {
        ZStack {
            Image("youtubesample\(videoNum)")
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.getWidth(268), height: UIScreen.getHeight(160))
                .mask{
                    RoundedRectangle(cornerRadius: 8)
                        .frame(width: UIScreen.getWidth(268), height: UIScreen.getHeight(160))
                }
            HStack {
                RoundedRectangle(cornerRadius: 8)
                    .frame(width: UIScreen.getWidth(268), height: UIScreen.getHeight(160))
                    .foregroundColor(.fill_1)
                    .overlay {
                        Text(contentURL)
                            .font(.button1())
                            .foregroundColor(.label_900)
                    }
            }
        }
    }
}

struct RelatedContentCard_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            RelatedContentCard(videoNum: 1, contentURL:  "https://www.youtube.com")
        }
    }
}
