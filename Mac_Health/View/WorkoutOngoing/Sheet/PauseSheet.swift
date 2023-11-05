//
//  PauseSheet.swift
//  Mac_Health
//
//  Created by 송재훈 on 11/5/23.
//

import SwiftUI

struct PauseSheet: View {
    var body: some View {
        ZStack {
            Color.gray_800.ignoresSafeArea()
            
            VStack {
                Text("운동 정지")
                    .font(.headline1())
                    .foregroundColor(.label_700)
                Text("00:00:15")
                    .font(.largeTitle())
                    .foregroundColor(.label_900)
                Button {
                    
                } label: {
                    RoundedRectangle(cornerRadius: 100)
                        .foregroundColor(.green_main)
                        .frame(width: UIScreen.getWidth(132), height: UIScreen.getHeight(60))
                        .overlay {
                            HStack {
                                Text("다시 시작")
                                Image(systemName: "play.fill")
                            }
                            .font(.button1())
                            .foregroundColor(.gray_900)
                        }
                }
            }
        }
        .presentationDetents([.height(UIScreen.getHeight(378))])
    }
}

struct PauseSheet_Preview: PreviewProvider {
    static var previews: some View {
        PauseSheet()
    }
}
