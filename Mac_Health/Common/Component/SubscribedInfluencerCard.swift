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
        ZStack{
            Rectangle()
                .foregroundColor(.gray_700)
            HStack{
                VStack(alignment: .leading){
                    Text("\(routine.name)의 \(routine.routineName)")
                        .font(.headline1())
                        .foregroundColor(.label_900)
                        .padding(.leading, 20)
                        .padding(.top, 24)
                    
                    Spacer()
                    HStack{
                        if routine.numberOfExercise == 0 {
                            Text("휴식")
                                .font(.headline2())
                                .foregroundColor(.label_700)
                                .padding(.leading, 20)
                                .padding(.bottom, 24)
                        }
                        else {
                            Text(routine.part)
                                .font(.headline2())
                                .foregroundColor(.label_700)
                                .padding(.leading, 20)
                                .padding(.bottom, 24)
                            Text("|")
                                .font(.headline2())
                                .foregroundColor(.label_700)
                                .padding(.bottom, 24)
                            Text("\(routine.numberOfExercise)개")
                                .font(.headline2())
                                .foregroundColor(.label_700)
                                .padding(.bottom, 24)
                        }
                    }
                }
                .frame(height: UIScreen.getHeight(156))
                Spacer()
                AsyncImage(url: URL(string: routine.influencerProfileImageUrl)) {
                    $0.image?
                        .scaledToFill()
                        .frame(width: UIScreen.getWidth(156))
                }
            }
        }
        .frame(width: UIScreen.getWidth(350), height: UIScreen.getHeight(156))
        .mask(
            RoundedRectangle(cornerRadius: 8)
                .frame(width: UIScreen.getWidth(350), height: UIScreen.getHeight(156))
        )
    }
}

struct SubscribedInfluencerCard_Previews: PreviewProvider {
    static var previews: some View {
        SubscribedInfluencerCard(routine: InfluencerRoutine(routineId: 1, part: "등, 이두", date: "2023-10-30", numberOfExercise: 6, burnedKCalories: 300, requiredMinutes: 300, comment: "오늘도 화이팅!", name: "정회승", routineName: "올라잇", influencerProfileImageUrl: "", influencerId: 5))
    }
}

