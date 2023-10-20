//
//  WorkoutOngoing.swift
//  Mac_Health
//
//  Created by 송재훈 on 2023/10/20.
//

import SwiftUI

struct WorkoutOngoingView: View {
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack {
                Navigation
                workoutInfomation
                workoutImage
                workoutSet
                workoutReps
                workoutButton
            }
        }
    }
    
    @ViewBuilder
    var Navigation: some View {
        HStack {
            Button {
                //
            } label: {
                Image(systemName: "chevron.down")
                    .foregroundColor(.lable_700)
            }
            Spacer()
            
            Group {
                Image(systemName: "flame.fill")
                    .foregroundColor(.green_main)
                Text("00:00:00")
                    .foregroundColor(.lable_900)
            }
            .font(.headline1())
            Spacer()
        }
    }
    
    @ViewBuilder
    var workoutInfomation: some View {
        VStack {
            HStack {
                Text("10월 5일(일)")
                    .foregroundColor(.lable_700)
                Text("|")
                    .foregroundColor(.lable_400)
                Text("박재훈")
                    .foregroundColor(.lable_700)
                Text("|")
                    .foregroundColor(.lable_400)
                Text("1/10")
                    .foregroundColor(.lable_700)
                Spacer()
            }
            .font(.body2())
            
            HStack {
                Text("클로즈 그립 랫 풀 다운")
                    .font(.title1())
                    .foregroundColor(.lable_900)
                
                RoundedRectangle(cornerRadius: 4)
                    .frame(width: UIScreen.getWidth(52), height: UIScreen.getHeight(28))
                    .foregroundColor(.gray_700)
                    .overlay {
                        HStack {
                            Image(systemName: "arrow.2.squarepath")
                            Text("대체")
                        }
                        .font(.caption())
                        .foregroundColor(.lable_700)
                    }
                Spacer()
            }
        }
    }
    
    @ViewBuilder
    var workoutImage: some View {
        Image(systemName: "arrow.2.squarepath")
    }
    
    @ViewBuilder
    var workoutSet: some View {
        HStack {
            RoundedRectangle(cornerRadius: 4)
                .frame(width: UIScreen.getWidth(106), height: UIScreen.getHeight(36))
                .foregroundColor(.gray_700)
                .overlay {
                    HStack {
                        Image(systemName: "minus")
                            .foregroundColor(.lable_900)
                        Text("4세트")
                            .foregroundColor(.lable_700)
                        Image(systemName: "plus")
                            .foregroundColor(.lable_900)
                    }
                    .font(.body())
                }
            Spacer()
        }
    }
    
    @ViewBuilder
    var workoutReps: some View {
        HStack {
            Text("1")
                .foregroundColor(.lable_900)
            RoundedRectangle(cornerRadius: 4)
                .frame(width: UIScreen.getWidth(72), height: UIScreen.getHeight(36))
                .foregroundColor(.gray_700)
                .overlay {
                    HStack {
                        Spacer()
                        Text("자율")
                            .foregroundColor(.lable_500)
                    }
                }
            Text("kg")
                .foregroundColor(.lable_700)
            Text("lbs")
                .foregroundColor(.lable_400)
            RoundedRectangle(cornerRadius: 4)
                .frame(width: UIScreen.getWidth(72), height: UIScreen.getHeight(36))
                .foregroundColor(.gray_700)
                .overlay {
                    HStack {
                        Spacer()
                        Text("10")
                            .foregroundColor(.lable_900)
                    }
                }
            Text("회")
                .foregroundColor(.lable_700)
            Ellipse()
                .frame(width: UIScreen.getWidth(36), height: UIScreen.getHeight(36))
                .foregroundColor(.green_10)
                .overlay {
                    Image(systemName: "checkmark")
                        .bold()
                        .foregroundColor(.green_main)
                }
        }
        .font(.body())
    }
    
    @ViewBuilder
    var workoutButton: some View {
        RoundedRectangle(cornerRadius: 100)
            .frame(width: UIScreen.getWidth(350), height: UIScreen.getHeight(60))
            .foregroundColor(.gray_600)
            .overlay {
                HStack {
                    Image(systemName: "list.bullet")
                        .foregroundColor(.lable_900)
                    
                    RoundedRectangle(cornerRadius: 100)
                        .frame(width: UIScreen.getWidth(120), height: UIScreen.getHeight(48))
                        .foregroundColor(.green_main)
                        .overlay {
                            Text("세트 완료")
                                .font(.button1())
                                .foregroundColor(.gray_900)
                        }
                }
                .bold()
            }
    }
}

struct WorkoutOngoingView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutOngoingView()
    }
}
