//
//  DetailedWorkoutSheet.swift
//  beFLE
//
//  Created by 송재훈 on 11/4/23.
//

import SwiftUI

struct DetailedWorkoutSheet: View {
    let exercise: ResponseGetRoutinesExercises
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
    }
    
    var NavigationTitle: some View {
        HStack {
            Text("\(exercise.name)")
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
                Text("\(exercise.part)")
                    .foregroundColor(.label_700)
                    .font(.body())
                
                Spacer()
            }
            AsyncImage(url: URL(string: exercise.exerciseImageUrl)) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: UIScreen.getWidth(320), height: UIScreen.getHeight(220))
            } placeholder: {
                LottieView()
                    .padding(10)
            }
        }
        .padding(.horizontal)
    }
    
    var WorkoutTip: some View {
        VStack {
            HStack {
                AsyncImage(url: URL(string: exercise.faceImageUrl)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    LottieView()
                        .padding(5)
                }
                .frame(width: UIScreen.getWidth(48), height: UIScreen.getHeight(48))
                
                Spacer()
            }
            .padding(.bottom, 10)
            HStack {
                Text("\(exercise.tip)\n")
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
            if !exercise.videoUrls.isEmpty {
                HStack {
                    Text("관련 영상")
                        .font(.title2())
                        .foregroundColor(.label_900)
                    
                    Spacer()
                }
                .padding(.bottom, 13)
                
                ScrollView(.horizontal) {
                    HStack{
                        ForEach(exercise.videoUrls, id: \.self) { videoUrl in
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
        DetailedWorkoutSheet(exercise: ResponseGetRoutinesExercises(name: "", part: "", exerciseId: 1, exerciseImageUrl: "", tip: "", videoUrls: [], sets: [], alternativeExercises: [], faceImageUrl: ""))
    }
}
