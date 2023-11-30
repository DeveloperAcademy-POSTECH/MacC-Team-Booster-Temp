//
//  DetailedWorkoutSheet.swift
//  beFLE
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
        .presentationDetents([.height(UIScreen.getHeight(644))])
        .onAppear {
            vm.fetchexercise(routineId: routineId, exerciseId: exerciseId)
        }
    }
}

/// 네비게이션 타이틀
extension DetailedWorkoutSheet {
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
}

/// 운동 상세 정보
extension DetailedWorkoutSheet {
    var WorkoutCard: some View {
        VStack(spacing: 0) {
            HStack {
                Text("\(vm.exercise.part)")
                    .foregroundColor(.label_700)
                    .font(.body())
                
                Spacer()
            }
            LoadingImage(url: vm.exercise.exerciseImageUrl)
                .frame(width: UIScreen.getWidth(320), height: UIScreen.getHeight(220))
        }
        .padding(.horizontal)
    }
    
    var WorkoutTip: some View {
        VStack {
            HStack {
                LoadingImage(url: vm.exercise.faceImageUrl)
                    .frame(width: UIScreen.getWidth(48), height: UIScreen.getHeight(48))
                
                Spacer()
            }
            .padding(.bottom, 10)
            HStack {
                Text("\(vm.exercise.tip)\n")
                    .multilineTextAlignment(.leading)
                    .allowsTightening(true)
                    .lineSpacing(7)
                    .foregroundColor(.label_900)
                    .font(.body())
                Spacer()
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 30)
        .padding(.bottom)
    }
    
    var RelatedContent: some View {
        VStack {
            if !vm.exercise.videoUrls.isEmpty {
                HStack {
                    Text("관련 영상")
                        .font(.title2())
                        .foregroundColor(.label_900)
                    
                    Spacer()
                }
                .padding(.bottom, 13)
                
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(vm.exercise.videoUrls, id: \.self) { videoUrl in
                            RelatedContentCard(videoID: videoUrl)
                        }
                    }
                }
            }
        }
        .padding(.horizontal)
    }
}

struct DetailedWorkoutSheet_Previews: PreviewProvider {
    static var previews: some View {
        DetailedWorkoutSheet(routineId: 1, exerciseId: 2)
    }
}
