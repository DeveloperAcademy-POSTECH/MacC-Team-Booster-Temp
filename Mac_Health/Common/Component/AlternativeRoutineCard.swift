//
//  AlternativeWorkoutCard.swift
//  Mac_Health
//
//  Created by 송재훈 on 2023/10/22.
//

import SwiftUI

struct AlternativeWorkoutCard: View {
    let isSelectedWorkout: Bool
    
    var body: some View {
        RoundedRectangle(cornerRadius: 8)
            .frame(width: UIScreen.getWidth(350), height: UIScreen.getHeight(76))
            .overlay {
                HStack {
                    RoundedRectangle(cornerRadius: 4)
                        .frame(width: UIScreen.getWidth(64), height: UIScreen.getHeight(64))
                        .foregroundColor(.fill_1)
                        .overlay {
                            Image(systemName: "eraser.line.dashed")
                        }
                    
                    Text("클로즈 그립 랫 풀 다운")
                        .font(.headline1())
                        .foregroundColor(isSelectedWorkout ? .green_main : .label_900)
                    Spacer()
                }
                .padding(.horizontal)
                
                if isSelectedWorkout {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(lineWidth: 1)
                        .foregroundColor(.green_main)
                        .frame(width: UIScreen.getWidth(349), height: UIScreen.getHeight(75))
                }
            }
    }
}

struct AlternativeWorkoutCard_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack {
                AlternativeWorkoutCard(isSelectedWorkout: false)
                AlternativeWorkoutCard(isSelectedWorkout: true)
            }
        }
    }
}
