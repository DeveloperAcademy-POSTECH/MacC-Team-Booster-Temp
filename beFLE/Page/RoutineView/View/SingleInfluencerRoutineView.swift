//
//  SingleInfluencerRoutineView.swift
//  beFLE
//
//  Created by 송재훈 on 11/15/23.
//

import SwiftUI

/// 인플루언서 단일 구독 뷰
///  - Parameters:
///   - routine: 인플루언서의 오늘 운동 목록
struct SingleInfluencerRoutineView: View {
    @Binding var routine: InfluencerRoutine
    @StateObject var vm = SingleInfluencerRoutineViewModel()
    @Environment(\.dismiss) var dismiss: DismissAction
    
    var body: some View {
        ZStack {
            Color.gray_900.ignoresSafeArea()
            InfluencerImage
            VStack {
                    NavigationTitle
                    InfluencerComment
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
            Text("\(routine.name)\n오늘의 운동")
                .font(.title1())
                .foregroundColor(.label_900)
            Spacer()
        }
        .padding(.horizontal)
        .padding(.top, 30)
    }
    
    var InfluencerImage: some View {
        AsyncImage(url: URL(string: routine.singleRoutineImageUrl)) { image in
            image
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.getWidth(390), height: UIScreen.getHeight(700))
                .clipped()
        } placeholder: {
            VStack() {
                LottieView()
                    .padding(65)
                Spacer()
                    .frame(height: UIScreen.getHeight(390))
            }
        }
    }
    
    var InfluencerComment: some View {
        ZStack{
            if routine.part == "휴식" {
                
            } else {
                VStack {
                    Spacer()
                    HStack(alignment: .top) {
                        VStack(alignment: .leading) {
                            Text(routine.comment)
                                .font(.body2())
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
                .padding(.bottom, 6)
            }
        }
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
                    Text("\(vm.formatForDate(from: routine.date))")
                        .font(.title2())
                        .foregroundColor(.label_900)
                    Spacer()
                    NavigationLink {
                        WholeRoutineView(influencerId: routine.influencerId)
                    } label: {
                        Image(systemName: "calendar")
                            .font(.title2())
                            .foregroundColor(.green_main)
                    }
                }
                .padding(.horizontal)
                .padding(.bottom)
                .padding(.top, 30)
                
                Spacer()
                
                if routine.part == "휴식" {
                    VStack {
                        Spacer()
                        Image(systemName: "moon.stars.fill")
                            .font(.system(size: 38))
                            .foregroundColor(.label_500)
                            .padding(.bottom)
                        Text("휴식")
                            .foregroundColor(.label_900)
                            .font(.headline1())
                    }
                    
                    // TODO: EmptyFloatingButton으로 변경
                    EmptyFloatingButton
                        .padding(.bottom)
                }
                else {
                    RoutineDescriptionCard
                        .padding(.bottom, 15)
                        .padding(.leading,10)
                    //운동 시작 버튼
                    if routine.isDone {
                        RoundedRectangle(cornerRadius: 100)
                            .frame(width: UIScreen.getWidth(318), height: UIScreen.getHeight(60))
                            .foregroundColor(.gray_600)
                            .overlay {
                                HStack{
                                    Image(systemName: "flame.fill")
                                        .foregroundColor(.label_400)
                                        .font(.button1())
                                    Text("오늘 운동 완료")
                                        .foregroundColor(.label_400)
                                        .font(.button1())
                                }
                            }
                            .padding(.bottom, 10)
                    } else {
                        NavigationLink {
                            EditRoutineView(routineId: routine.routineId)
                        } label: {
                            RoundedRectangle(cornerRadius: 100)
                                .frame(width: UIScreen.getWidth(318), height: UIScreen.getHeight(60))
                                .foregroundColor(.green_main)
                                .overlay {
                                    Text("운동 시작")
                                        .foregroundColor(.gray_900)
                                        .font(.button1())
                                }
                        }
                        .padding(.bottom, 10)
                    }
                    Spacer()
                }
            }
        }
        .padding(.horizontal, 10)
        .frame(width: UIScreen.getWidth(350), height: UIScreen.getHeight(325))
        .background {
            RoundedRectangle(cornerRadius: 8)
                .foregroundColor(.gray_700)
        }
        .padding(.bottom, 1)
    }
    
    var EmptyFloatingButton: some View {
        FloatingButton(backgroundColor: .clear) { }
    }
    
    var BackButton: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "chevron.left")
                .foregroundColor(.label_900)
                .font(.body())
        }
    }
}

#Preview {
    TabView{
        SingleInfluencerRoutineView(routine: .constant(InfluencerRoutine(routineId: 0, part: "등", date: "10월 24일", numberOfExercise: 5, burnedKCalories: 5, requiredMinutes: 5, comment: "", name: "", routineName: "", singleRoutineImageUrl: "", multiRoutineImageUrl: "", influencerId: 1, isDone: false)))
            .tabItem {
                Image(systemName: "dumbbell")
                Text("루틴")
            }
    }
}
