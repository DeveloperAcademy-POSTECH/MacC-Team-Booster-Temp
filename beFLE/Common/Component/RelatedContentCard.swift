//
//  RelatedContentCard.swift
//  beFLE
//
//  Created by 송재훈 on 2023/10/22.
//

import SwiftUI
import WebKit

class YoutubeModel {
    var videoID = ""
    var videoTitle = "team Booster"
}

struct EmbedView: UIViewRepresentable {
    let videoID: String
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        guard let youtubeURL = URL(string: (videoID)) else { return }
        uiView.scrollView.isScrollEnabled = false
        uiView.load(URLRequest(url: youtubeURL))
    }
}

struct RelatedContentCard: View {
    var videoID: String
    var body: some View {
        ZStack(alignment: .center) {
            HStack {
                EmbedView(videoID: videoID)
                    .frame(width: 268, height: 160, alignment: .center)
                    .cornerRadius(8.0)
            }
            .background(Color.label_900)
            .cornerRadius(8)
        }
        .background(
            LinearGradient(gradient: .init(colors: [Color(hex: "F6E0BB"), Color(hex: "E5E5E5"), Color(hex: "E5E5E5")]), startPoint: .top, endPoint: .bottom)
                .cornerRadius(8.0)
        )
    }
}

struct RelatedContentCard_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black.ignoresSafeArea()
        }
    }
}
