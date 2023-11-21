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
            vm.fetchWorkout(routineId: routineId, exerciseId: exerciseId)
        }
        .presentationDetents([.height(UIScreen.getHeight(644))])
    }
    
    var NavigationTitle: some View {
        HStack {
            Text("\(vm.workout.name)")
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
        VStack(spacing: 0) {
            HStack {
                Text("\(vm.workout.part)")
                    .foregroundColor(.label_700)
                    .font(.body())
                
                Spacer()
            }
            AsyncImage(url: URL(string: vm.workout.exerciseImageUrl)) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: UIScreen.getWidth(320), height: UIScreen.getHeight(220))
            } placeholder: {
                Image(systemName: "arrow.triangle.2.circlepath")
                    .scaledToFit()
                    .scaleEffect(CGSize(width: 1.0, height: 1.0))
                    .frame(width: UIScreen.getWidth(350), height: UIScreen.getHeight(220))
                    .padding()
            }
        }
        .padding(.horizontal)
    }
    
    var WorkoutTip: some View {
        VStack {
            HStack {
                AsyncImage(url: URL(string: vm.workout.faceImageUrl)) { image in
                    image
                        .resizable()
                } placeholder: {
                    Image(systemName: "arrow.triangle.2.circlepath")
                        .resizable()
                        .foregroundColor(.gray_600)
                        .padding()
                }
                .frame(width: UIScreen.getWidth(48), height: UIScreen.getHeight(48))
                
                Spacer()
            }
            .padding(.bottom, 10)
            Text("\(vm.workout.tip)\n")
                .multilineTextAlignment(.leading)
                .lineSpacing(7)
                .foregroundColor(.label_900)
                .font(.body())
        }
        .padding(.horizontal)
        .padding(.bottom)
    }
    
    var RelatedContent: some View {
        VStack {
            HStack {
                Text("관련 영상")
                    .font(.title2())
                    .foregroundColor(.label_900)
                
                Spacer()
            }
            .padding(.bottom, 13)
            
            ScrollView(.horizontal) {
                HStack{
                    // TODO: 유튜브 링크 통해서 작업하기
                    ForEach(vm.workout.videoUrls, id: \.self){ videoUrl in
                        RelatedContentCard(videoID: videoUrl)
                    }
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
