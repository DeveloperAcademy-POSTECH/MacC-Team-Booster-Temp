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
    let action: () -> ()
    
    var body: some View {
        Button {
            action()
        } label: {
            RoundedRectangle(cornerRadius: 100)
                .frame(width: UIScreen.getWidth(350), height: UIScreen.getHeight(60))
                .foregroundColor(backgroundColor)
                .overlay {
                    content
                }
        }
    }
}

struct FloatingButton_Previews: PreviewProvider {
    static var previews: some View {
        FloatingButton(backgroundColor: .gray_600) {
            Text("세트 완료")
                .font(.button1())
                .foregroundColor(.label_900)
        } action: {
            print("세트 완료")
        }
    }
}
