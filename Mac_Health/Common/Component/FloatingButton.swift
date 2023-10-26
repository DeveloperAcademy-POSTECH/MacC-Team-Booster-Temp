//
//  FloatingButton.swift
//  Mac_Health
//
//  Created by 송재훈 on 10/24/23.
//

import SwiftUI

struct FloatingButton<Content: View>: View {
    let backgroundColor: Color
    @ViewBuilder let content: Content
    
    var body: some View {
        RoundedRectangle(cornerRadius: 100)
            .frame(width: UIScreen.getWidth(350), height: UIScreen.getHeight(60))
            .foregroundColor(backgroundColor)
            .overlay {
                content
            }
    }
}

struct FloatingButton_Previews: PreviewProvider {
    static var previews: some View {
        FloatingButton(backgroundColor: .blue_main) {
            HStack {
                Button {
                    print("버튼 1")
                } label: {
                    Image(systemName: "square.and.arrow.down")
                }
                Spacer()
                Button {
                    print("버튼 2")
                } label: {
                    Image(systemName: "square.and.arrow.up")
                }
            }
            .padding(.horizontal)
        }
    }
}
