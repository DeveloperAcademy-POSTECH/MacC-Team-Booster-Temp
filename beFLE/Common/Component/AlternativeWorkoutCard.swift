//
//  AlternativeWorkoutCard.swift
//  Mac_Health
//
//  Created by 송재훈 on 2023/10/22.
//

import SwiftUI

struct AlternativeWorkoutCard: View {
    let alternativeWorkout: AlternativeExercise
    let isSelectedWorkout: Bool
    
    var body: some View {
        RoundedRectangle(cornerRadius: 8)
            .frame(width: UIScreen.getWidth(350), height: UIScreen.getHeight(76))
            .foregroundColor(.fill_3)
            .overlay {
                HStack {
                    RoundedRectangle(cornerRadius: 4)
                        .frame(width: UIScreen.getWidth(64), height: UIScreen.getHeight(64))
                        .foregroundColor(.fill_1)
                        .overlay {
                            AsyncImage(url: URL(string: alternativeWorkout.exerciseImageUrl)) { image in
                                image
                                    .resizable()
                                    .scaledToFit()
                            } placeholder: {
                                Image(systemName: "arrow.triangle.2.circlepath")
                                    .scaledToFit()
                                    .scaleEffect(CGSize(width: 1.0, height: 1.0))
                                    .foregroundColor(.gray_600)
                            }
                        }
                        .padding(.leading, 6)
                        .padding(.trailing, 15)
                    
                    Text(alternativeWorkout.name)
                        .font(.headline1())
                        .foregroundColor(isSelectedWorkout ? .green_main : .label_900)
                    Spacer()
                }
                
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
                AlternativeWorkoutCard(alternativeWorkout: AlternativeExercise(alternativeExerciseId: 1, name: "", exerciseImageUrl: ""), isSelectedWorkout: false)
            }
        }
    }
}
