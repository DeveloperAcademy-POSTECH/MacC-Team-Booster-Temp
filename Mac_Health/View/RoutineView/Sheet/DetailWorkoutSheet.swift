//
//  DetailWorkoutSheet.swift
//  Mac_Health
//
//  Created by 최진용 on 2023/10/23.
//

import SwiftUI

struct DetailWorkoutSheet: View {
    var body: some View {
        ZStack {
            Color.gray_800.ignoresSafeArea()
            VStack {
                NavigationBar
                ScrollView {
                    VStack {
                        WorkoutType
                        WorkoutImage
                        Tips
                        Youtube
                        AlternativeWorkouts
                    }
                }
            }
        }
    }
    var AlternativeWorkouts: some View {
        VStack {
            HStack {
                Text("대체 운동")
                    .font(.title2())
                    .foregroundColor(.lable_900)
                    .padding(.bottom, UIScreen.getHeight(24))
                Spacer()
            }
            alternativeCell()
            alternativeCell()
            alternativeCell()
            alternativeCell()
        }.padding()
    }
    
    func alternativeCell() -> some View {
        HStack(spacing: 17) {
            Rectangle()
                .frame(width: UIScreen.getWidth(64), height: UIScreen.getHeight(64))
                .foregroundColor(.gray_600)
            Text("클로즈 그립 대체")
                .font(.body())
                .foregroundColor(.lable_900)
            Spacer()
        }
    }
    
    
    var Youtube: some View {
        VStack(alignment: .leading, spacing: 24) {
            Text("관련 영상")
                .font(.title2())
                .foregroundColor(.lable_900)
            ScrollView(.horizontal) {
                RoundedRectangle(cornerRadius: 8)
                    .frame(width: UIScreen.getWidth(267), height: UIScreen.getHeight(160))
                    .foregroundColor(.gray_600)
            }
        }.padding(.horizontal)
    }
    
    var Tips: some View {
        VStack {
            HStack {
                Circle()
                    .frame(width: UIScreen.getWidth(48))
                    .foregroundColor(.gray_600)
                Spacer()
            }.padding(.bottom)
            Text("고정축이 흔들리면 정확한 타겟이 불가능하기 때문에 꼭! 랫 풀 다운 할 때는 발꿈치를 들어서 무릎 패드와 다리 사이에 공간이 없도록 단단한 지지대를 만들어 주는 것이 굉장히 중요합니다.")
                .multilineTextAlignment(.leading)
                .lineSpacing(3)
                .foregroundColor(.lable_900)
                .font(.headline1())
        }.padding()
    }
    
    var WorkoutImage: some View {
        Image("Workout")
            .resizable()
            .scaledToFit()
            .frame(width: UIScreen.getWidth(350), height: UIScreen.getHeight(220))
    }
    
    var WorkoutType: some View {
        HStack {
            Text("등")
                .foregroundColor(.lable_700)
                .font(.body())
            Spacer()
        }.padding(.horizontal)
    }
    
    var NavigationBar: some View {
        HStack {
            Text("클로즈그립 렛풀다운")
                .foregroundColor(.lable_900)
                .font(.title1())
            Spacer()
            Button {
                
            } label: {
                Circle()
                    .frame(width: UIScreen.getWidth(30))
                    .foregroundColor(.gray_600)
                    .overlay {
                        Image(systemName: "multiply")
                            .foregroundColor(.lable_700)
                            .font(.headline1())
                    }
            }
        }.padding()
    }
}

struct DeatilView_Preview: PreviewProvider {
    static var previews: some View {
        DetailWorkoutSheet()
    }
}
