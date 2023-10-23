//
//  RelatedContentCard.swift
//  Mac_Health
//
//  Created by 송재훈 on 2023/10/22.
//

import SwiftUI

struct RelatedContentCard: View {
    let contentURL: String
    
    var body: some View {
        HStack {
            RoundedRectangle(cornerRadius: 8)
                .frame(width: UIScreen.getWidth(268), height: UIScreen.getHeight(160))
                .foregroundColor(.fill_1)
                .overlay {
                    Text(contentURL)
                        .font(.title1())
                        .foregroundColor(.label_900)
                }
        }
    }
}

struct RelatedContentCard_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            RelatedContentCard(contentURL: "https://www.youtube.com")
        }
    }
}
