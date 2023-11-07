//
//  WorkoutSequenceCard.swift
//  Mac_Health
//
//  Created by 송재훈 on 2023/10/22.
//

import SwiftUI

struct WorkoutSequenceCard: View {
    let isCurrentWorkout: Bool
    let isFinish: Bool
    
    var body: some View {
        HStack {
            RoundedRectangle(cornerRadius: 4)
                .frame(width: UIScreen.getWidth(64), height: UIScreen.getHeight(64))
                .foregroundColor(.fill_1)
                .overlay {
                    Image("CloseGripLatPullDown")
                        .resizable()
                        .frame(width: UIScreen.getWidth(64), height: UIScreen.getHeight(64))
                }
            Spacer()
            Spacer()
            
            VStack(alignment: .leading) {
                HStack {
                    if isCurrentWorkout {
                        Image(systemName: "flame.fill")
                            .font(.headline1())
                            .foregroundColor(.green_main)
                    }
                    Text("클로즈 그립 랫 풀 다운")
                        .font(.headline1())
                        .foregroundColor(isCurrentWorkout ? .green_main : .label_900)
                    Spacer()
                }
                HStack {
                    Text("3세트")
                    Text("|")
                    Text("10-15 reps")
                }
                .font(.body2())
                .foregroundColor(.label_700)
            }
            
            Spacer()
            Spacer()
            Spacer()
            
            if isFinish {
                CheckButton()
            }
            else {
                EmptyCheckButton()
            }
        }
        .frame(width: UIScreen.getWidth(350), height: UIScreen.getHeight(64))
    }
}

struct WorkoutSequenceCard_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack {
                WorkoutSequenceCard(isCurrentWorkout: false, isFinish: true)
                WorkoutSequenceCard(isCurrentWorkout: true, isFinish: false)
                WorkoutSequenceCard(isCurrentWorkout: false, isFinish: false)
            }
        }
    }
}
