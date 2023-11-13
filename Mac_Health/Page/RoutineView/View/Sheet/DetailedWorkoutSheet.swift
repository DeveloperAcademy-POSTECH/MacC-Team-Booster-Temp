//
//  DetailedWorkoutSheet.swift
//  Mac_Health
//
//  Created by 송재훈 on 11/4/23.
//

import SwiftUI

struct DetailedWorkoutSheet: View {
    let routineId: Int
    let exerciseId: Int
    @StateObject var vm = DetailedWorkoutSheetViewModel()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Color.gray_800.ignoresSafeArea()
            
            VStack {
                Spacer()
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
        .onAppear {
            vm.fetchExercise(routineId: routineId, exerciseId: exerciseId)
        }
        .presentationDetents([.height(UIScreen.getHeight(684))])
    }
    
    var NavigationTitle: some View {
        HStack {
            Text("\(vm.exercise.name)")
                .font(.title1())
                .foregroundColor(.label_900)
            
            Spacer()
            
            Button {
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
        .padding(.horizontal)
        .padding(.top)
    }
    
    var WorkoutCard: some View {
        VStack {
            HStack {
                Text("\(vm.exercise.part)")
                    .foregroundColor(.label_700)
                    .font(.body())
                
                Spacer()
            }
            AsyncImage(url: URL(string: vm.exercise.exerciseImageUrl)) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: UIScreen.getWidth(350), height: UIScreen.getHeight(220))
            } placeholder: {
                Image(systemName: "arrow.triangle.2.circlepath")
                    .resizable()
                    .scaledToFit()
                    .frame(width: UIScreen.getWidth(350), height: UIScreen.getHeight(220))
                    .padding()
            }
        }
        .padding(.horizontal)
    }
    
    var WorkoutTip: some View {
        VStack {
            HStack {
                // TODO: 서버 데이터 구조 바뀌면 갱신 페이스 이미지
                Image("descriptionFace1")
                    .resizable()
                    .frame(width: UIScreen.getWidth(48), height: UIScreen.getHeight(48))
                    .foregroundColor(.gray_600)
                
                Spacer()
            }
            .padding(.bottom)
            Text("\(vm.exercise.tip)\n")
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
                    // TODO: 유튜브 링크 통해서 작업하기
                    RelatedContentCard(videoNum: 0, contentURL: "")
                }
            }
        }
        .padding(.horizontal)
    }
}

struct DetailedWorkoutSheet_Previews: PreviewProvider {
    static var previews: some View {
        DetailedWorkoutSheet(routineId: 1, exerciseId: 1)
    }
}
