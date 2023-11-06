//
//  DetailedWorkout.swift
//  Mac_Health
//
//  Created by 송재훈 on 11/4/23.
//

import SwiftUI

struct DetailedWorkoutSheet: View {
    var body: some View {
        ZStack {
            Color.gray_800.ignoresSafeArea()
            
            VStack {
                NavigationTitle
                ScrollView {
                    VStack {
                        WorkoutCard
                        WorkoutTip
                        RelatedContent
                    }
                }
            }
        }
        .presentationDetents([.height(UIScreen.getHeight(684))])
    }
    
    var NavigationTitle: some View {
        HStack {
            // TODO: .
            Text("클로즈 그립 랫 풀 다운")
                .font(.title1())
                .foregroundColor(.label_900)
            
            Spacer()
            
            Button {
                // TODO: .
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
        .padding(.horizontal)
        .padding(.top)
    }
    
    var WorkoutCard: some View {
        VStack {
            HStack {
                // TODO: .
                Text("등")
                    .foregroundColor(.label_700)
                    .font(.body())
                
                Spacer()
            }
            // TODO: .
            Image("Workout")
                .resizable()
                .scaledToFit()
                .frame(width: UIScreen.getWidth(350), height: UIScreen.getHeight(220))
        }
        .padding(.horizontal)
    }
    
    var WorkoutTip: some View {
        VStack {
            HStack {
                // TODO: .
                Image("descriptionFace1")
                    .resizable()
                    .frame(width: UIScreen.getWidth(48), height: UIScreen.getHeight(48))
                    .foregroundColor(.gray_600)
                
                Spacer()
            }
            .padding(.bottom)
            // TODO: .
            Text("고정축이 흔들리면 정확한 타겟이 불가능하기 때문에 꼭! 랫 풀 다운 할 때는 발꿈치를 들어서 무릎 패드와 다리 사이에 공간이 없도록 단단한 지지대를 만들어 주는 것이 굉장히 중요합니다.\n")
                .multilineTextAlignment(.leading)
                .lineSpacing(3)
                .foregroundColor(.label_900)
                .font(.headline1())
        }
        .padding(.horizontal)
    }
    
    var RelatedContent: some View {
        VStack {
            HStack {
                Text("관련 영상")
                    .font(.title2())
                    .foregroundColor(.label_900)
                
                Spacer()
            }
            
            ScrollView(.horizontal) {
                HStack{
                    // TODO: .
                    RelatedContentCard(videoNum: 0, contentURL: "")
                }
            }
        }
        .padding(.horizontal)
    }
}

struct DetailedWorkout_Previews: PreviewProvider {
    static var previews: some View {
        DetailedWorkoutSheet()
    }
}
