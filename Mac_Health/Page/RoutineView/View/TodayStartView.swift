//
//  TodayStartView.swift
//  Mac_Health
//
//  Created by 정회승 on 2023/11/01.
//

import SwiftUI

struct TodayStartView: View {
    let routine: InfluencerRoutine
    @StateObject var vm = TodayStartViewModel()
    
    var body: some View {
        ZStack {
            VStack {
                ZStack(alignment: .top) {
                    AsyncImage(url: URL(string: routine.influencerProfileImageUrl)) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: UIScreen.getWidth(390))
                            .offset(x:20, y: 30)
                    } placeholder: {
                        Image(systemName: "arrow.triangle.2.circlepath")
                            .resizable()
                            .scaledToFit()
                            .padding(50)
                    }
                    //인플루언서의 오늘의 루틴
                    NavigationTitle
                    //오늘의 상태 텍스트

                    VStack {
                        Spacer()
                        HStack(alignment: .top) {
                            VStack(alignment: .leading) {
                                Text(routine.comment)
                                    .font(.body)
                                    .foregroundColor(.label_800)
                            }
                            .padding(20)
                        }
                        .frame(width: UIScreen.getWidth(350))
                        .background {
                            RoundedRectangle(cornerRadius: 8)
                                .foregroundColor(.gray_700)
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(lineWidth: 1.0)
                                .foregroundColor(.label_500)
                        }
                    }
                }
                Spacer()
                TodayCard()
            }
            .padding(.bottom)
            Spacer()
                .frame(height: UITabBarController().height)
        }
    }
    
    var NavigationTitle: some View {
        HStack {
            Text("\(routine.name)의\n오늘의 루틴")
                .font(.title1())
                .foregroundColor(.label_900)
            Spacer()
        }
        .padding(.horizontal)
        .padding(.top, 30)
    }
    
    var RoutineDescriptionCard: some View {
        HStack {
            VStack(alignment: .leading, spacing: UIScreen.getWidth(14)) {
                Description(image: "figure.arms.open", text: routine.part)
                Description(image: "square.stack.fill", text: "\(routine.numberOfExercise)개")
                Description(image: "clock.fill", text: "\(routine.requiredMinutes)분")
                Description(image: "flame.circle.fill", text: "\(routine.burnedKCalories)kcal")
            }
            .padding(.bottom)
            Spacer()
        }
    }
    
    
    func Description(image: String, text: String) -> some View {
        HStack {
            Image(systemName: image)
                .foregroundColor(.label_700)
                .font(.body2())
                .frame(width: UIScreen.getWidth(30))
            Text(text)
                .foregroundColor(.label_900)
                .font(.body())
        }
    }
    
    func TodayCard() -> some View {
        ZStack {
            VStack(alignment: .center) {
                HStack {
                    Text("\(vm.dateFormat(from: routine.date))")
                        .font(.title2())
                        .foregroundColor(.label_900)
                    Spacer()
                    NavigationLink {
                        ChangeRoutineView(influencerId: routine.influencerId)
                            .navigationBarTitle("전체 루틴", displayMode: .inline)
                    } label: {
                        Image(systemName: "calendar")
                            .font(.title2())
                            .foregroundColor(.green_main)
                    }
                }
                .padding(.horizontal)
                .padding(.bottom)
                
                if routine.part == "휴식" {
                    VStack {
                        Image(systemName: "moon.stars.fill")
                            .font(.system(size: 60))
                            .foregroundColor(.label_500)
                            .padding(.bottom)
                        Text("휴식")
                            .foregroundColor(.label_900)
                            .font(.headline1())
                    }
                    
                    // TODO: EmptyFloatingButton으로 변경
                    FloatingButton(backgroundColor: .clear) { }
                        .padding(.bottom)
                        .padding(.bottom)
                }
                else {
                    RoutineDescriptionCard
                        .padding(.bottom, 10)
                        .padding(.leading,10)
                    //운동 시작 버튼
                    // TODO: 운동 완료시 disabledl
                    NavigationLink {
                        WorkoutListView(routineId: routine.routineId)
                    } label: {
                        RoundedRectangle(cornerRadius: 100)
                            .frame(width: UIScreen.getWidth(300), height: UIScreen.getHeight(60))
                            .foregroundColor(.green_main)
                            .overlay {
                                Text("운동 시작")
                                    .foregroundColor(.gray_900)
                                    .font(.button1())
                            }
                    }
                }
            }
        }
        .frame(width: UIScreen.getWidth(350), height: UIScreen.getHeight(320))
        .background {
            RoundedRectangle(cornerRadius: 8)
                .foregroundColor(.gray_700)
        }
    }
}

struct TodayStartView_Previews: PreviewProvider {
    static var previews: some View {
        TodayStartView(routine: InfluencerRoutine(routineId: 1, part: "등", date: "2023-10-24", numberOfExercise: 6, burnedKCalories: 580, requiredMinutes: 50, comment: "오늘은 컨디션이 안 좋아서 살살 했어요.", name: "정회승", routineName: "", influencerProfileImageUrl: "", influencerId: 1))
    }
}
