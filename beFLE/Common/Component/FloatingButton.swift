//
//  FloatingButton.swift
//  beFLE
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

enum ButtonType {
    case semiSmall
    case small
    case semiMedium
    case medium
    case large
}

struct Floating<Content: View>: View {
    let type: ButtonType
    var color: Color? = .clear
    @ViewBuilder let content: Content
    
    var body: some View {
        switch type {
        case .semiSmall:
            RoundedRectangle(cornerRadius: 100)
                .frame(width: UIScreen.getWidth(132), height: UIScreen.getHeight(60))
                .foregroundColor(color)
                .overlay {
                    content
                }
        case .small:
            RoundedRectangle(cornerRadius: 100)
                .frame(width: UIScreen.getWidth(180), height: UIScreen.getHeight(60))
                .foregroundColor(color)
                .overlay {
                    content
                }
        case .semiMedium:
            RoundedRectangle(cornerRadius: 100)
                .frame(width: UIScreen.getWidth(318), height: UIScreen.getHeight(60))
                .foregroundColor(color)
                .overlay {
                    content
                }
        case .medium:
            RoundedRectangle(cornerRadius: 100)
                .frame(width: UIScreen.getWidth(350), height: UIScreen.getHeight(60))
                .foregroundColor(color)
                .overlay {
                    content
                }
        case .large:
            RoundedRectangle(cornerRadius: 100)
                .frame(width: UIScreen.getWidth(350), height: UIScreen.getHeight(76))
                .foregroundColor(color)
                .overlay {
                    content
                }
        }
    }
}

struct FloatingButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            /// 색 생략시 empty
            Floating(type: .large) {}
                .border(.pink)
            
            /// large 플로팅 버튼 안의 버튼
            Floating(type: .semiSmall, color: .green_main) {
                HStack {
                    Text("다음 세트")
                        .font(.button1())
                    Image(systemName: "chevron.right")
                        .font(.button2())
                }
                .foregroundColor(.gray_900)
            }
            
            Floating(type: .small, color: .green_main) {
                Text("둘러보기")
                    .font(.button1())
                    .foregroundColor(.gray_900)
            }
            
            Floating(type: .semiMedium, color: .green_main) {
                Text("운동 시작")
                    .foregroundColor(.gray_900)
                    .font(.button1())
            }
            
            Floating(type: .medium, color: .gray_600) {
                Text("운동 시작")
                    .foregroundColor(.red_main)
                    .font(.button1())
            }
            
            Floating(type: .large, color: .fill_1) {
                HStack {
                    Image(systemName: "list.bullet")
                        .foregroundColor(.green_main)
                        .font(.title1())
                        .padding(.leading, 30)
                    
                    Spacer()
                    
                    Floating(type: .semiSmall, color: .green_main) {
                        HStack {
                            Text("다음 세트")
                                .font(.button1())
                            Image(systemName: "chevron.right")
                                .font(.button2())
                        }
                        .foregroundColor(.gray_900)
                    }
                }
            }
        }
    }
}
