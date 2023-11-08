//
//  AlternativeWorkoutSheet.swift
//  Mac_Health
//
//  Created by 송재훈 on 11/4/23.
//

import SwiftUI

struct AlternativeWorkoutSheet: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Color.gray_800.ignoresSafeArea()
            
            VStack {
                Spacer()
                NavitationTitle
                AlternativeWorkoutList
                
                FinishButton
            }
        }
        .presentationDetents([.height(UIScreen.getHeight(519))])
    }
    
    var NavitationTitle: some View {
        VStack {
            HStack {
                // TODO: .
                Text("운동 대체하기")
                    .font(.title1())
                    .foregroundColor(.label_900)
                
                Spacer()
                
                Button {
                    // TODO: .
                    dismiss()
                } label: {
                    Circle()
                        .foregroundColor(.gray_600)
                        .frame(width: UIScreen.getWidth(30), height: UIScreen.getHeight(30))
                        .overlay {
                            Image(systemName: "multiply")
                                .foregroundColor(.label_700)
                                .font(.headline1())
                        }
                }
            }
            
            HStack {
                // TODO: .
                Text("클로즈 그립 랫 풀 다운")
                    .font(.body())
                    .foregroundColor(.label_700)
                
                Spacer()
            }
        }
        .padding()
    }
    
    var AlternativeWorkoutList: some View {
        ScrollView {
            // TODO: .
            AlternativeWorkoutCard(isSelectedWorkout: false)
            AlternativeWorkoutCard(isSelectedWorkout: true)
        }
    }
    
    var FinishButton: some View {
        Button {
            // TODO: .
        } label: {
            FloatingButton(backgroundColor: .green_main) {
                Text("완료")
                    .font(.button1())
                    .foregroundColor(.gray_900)
            }
        }
    }
}

struct AlternativeWorkoutSheet_Previews: PreviewProvider {
    static var previews: some View {
        AlternativeWorkoutSheet()
    }
}