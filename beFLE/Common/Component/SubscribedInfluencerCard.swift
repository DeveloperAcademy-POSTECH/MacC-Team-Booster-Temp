//
//  SubscribedInfluencerCard.swift
//  Mac_Health
//
//  Created by 정회승 on 2023/11/01.
//

import SwiftUI

struct SubscribedInfluencerCard: View {
    let routine: InfluencerRoutine
    
    var body: some View {
        RoundedRectangle(cornerRadius: 8)
            .foregroundColor(.gray_700)
            .frame(width: UIScreen.getWidth(350), height: UIScreen.getHeight(156))
            .overlay {
                HStack {
                    VStack(alignment: .leading) {
                        Text("\(routine.name)의 \(routine.routineName)")
                            .font(.headline1())
                            .foregroundColor(.label_900)
                            .padding(.leading, 20)
                            .padding(.top, 24)
                        Spacer()
                        HStack {
                            if routine.numberOfExercise == 0 {
                                Text("휴식")
                                    .padding(.leading, 20)
                            }
                            else {
                                Text(routine.part)
                                    .padding(.leading, 20)
                                Text("|")
                                    .foregroundColor(.label_400)
                                Text("\(routine.numberOfExercise)개")
                            }
                        }
                        .foregroundColor(.label_700)
                        .font(.headline2())
                        .padding(.bottom, 24)
                    }
                    .frame(height: UIScreen.getHeight(156))
                    Spacer()
                    AsyncImage(url: URL(string: routine.influencerProfileImageUrl)) { image in
                        image
                            .scaledToFit()
                            .scaleEffect(CGSize(width: 1.0, height: 1.0))
                            .frame(width: UIScreen.getWidth(156))
                    } placeholder: {
                        Image(systemName: "arrow.triangle.2.circlepath")
                            .resizable()
                            .scaledToFit()
                            .padding(50)
                    }
                }
            }
            .mask {
                RoundedRectangle(cornerRadius: 8)
                    .frame(width: UIScreen.getWidth(350), height: UIScreen.getHeight(156))
            }
    }
}

struct SubscribedInfluencerCard_Previews: PreviewProvider {
    static var previews: some View {
        SubscribedInfluencerCard(routine: InfluencerRoutine(routineId: 1, part: "등, 이두", date: "2023-10-30", numberOfExercise: 6, burnedKCalories: 300, requiredMinutes: 300, comment: "오늘도 화이팅!", name: "정회승", routineName: "올라잇", influencerProfileImageUrl: "", influencerId: 5, isDone: false))
    }
}
