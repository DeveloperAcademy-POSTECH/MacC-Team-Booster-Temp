//
//  SingleInfluencerRoutineView.swift
//  Mac_Health
//
//  Created by 송재훈 on 11/15/23.
//

import SwiftUI

// TODO: 서버에서 isDone 추가 시 그에 따른 갱신 작업
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
            
            VStack {
                ZStack(alignment: .top) {
                    InfluencerImage
                    NavigationTitle
                    InfluencerComment
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
    
    var InfluencerImage: some View {
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
    }
    
    var InfluencerComment: some View {
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
                    
                    if routine.isDone {
                        RoundedRectangle(cornerRadius: 100)
                            .frame(width: UIScreen.getWidth(300), height: UIScreen.getHeight(60))
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
                    } else {
                        NavigationLink {
                            EditRoutineView(routineId: routine.routineId)
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
        }
        .frame(width: UIScreen.getWidth(350), height: UIScreen.getHeight(320))
        .background {
            RoundedRectangle(cornerRadius: 8)
                .foregroundColor(.gray_700)
        }
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
    SingleInfluencerRoutineView(routine: .constant(InfluencerRoutine(routineId: 0, part: "등", date: "10월 24일", numberOfExercise: 5, burnedKCalories: 5, requiredMinutes: 5, comment: "", name: "", routineName: "", influencerProfileImageUrl: "", influencerId: 1, isDone: false)))
}
