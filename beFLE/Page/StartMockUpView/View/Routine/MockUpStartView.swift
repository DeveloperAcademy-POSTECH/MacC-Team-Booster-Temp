//
//  MockUpStartView.swift
//  beFLE
//
//  Created by 정회승 on 11/13/23.
//
//
//import SwiftUI
//
//struct MockUpStartView: View {
//    @State var todayText = "반가워요 득근해봅시다💪"
//    @Binding var tabSelection: Int
//    var Influencer = "정회승"
//

import SwiftUI

struct MockUpStartView: View {
    var todayText = "반가워요 득근해봅시다💪"
    
    var body: some View {
        ZStack{
            Color.gray_900.ignoresSafeArea()
            InfluencerImage
            VStack{
                NavigationTitle
                TodayText
                Spacer()
                TodayCard
            }
            .padding(.bottom)
            Spacer()
                .frame(height: UITabBarController().height)
        }
        .navigationBarBackButtonHidden()
        .navigationBarTitleDisplayMode(.inline)
    }
    
    var InfluencerImage: some View {
        GeometryReader { geo in
            Image("Influencer_main")
                .resizable()
                .scaledToFill()
                .frame(width: geo.size.width, height: geo.size.height)
                .clipped()
        }
    }
    
    var NavigationTitle: some View {
        VStack {
            HStack {
                Text("정회승\n오늘의 운동")
                    .font(.title1())
                    .foregroundColor(.label_900)
                    .multilineTextAlignment(.leading)
                Spacer()
            }
            .padding(.horizontal)
            .padding(.top)
            HStack {
                Text("둘러보기 중")
                    .font(.body2())
                    .foregroundColor(.label_700)
                    .padding(.horizontal)
                    .padding(.top, 1)
                Spacer()
            }
        }
    }
    
    var RoutineDescriptionCard: some View {
        HStack {
            VStack(alignment: .leading, spacing: UIScreen.getWidth(14)) {
                Description(image: "figure.arms.open", text: "등 이두")
                Description(image: "square.stack.fill", text: "6개")
                Description(image: "clock.fill", text: "50분")
                Description(image: "flame.circle.fill", text: "580kcal")
            }.padding(.bottom)
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
    
    @ViewBuilder
    var TodayText: some View {
        VStack {
            Spacer()
            HStack(alignment: .top){
                VStack(alignment: .leading){
                    Text(todayText)
                        .font(.body2())
                        .foregroundColor(.label_800)
                }
                .padding(20)
            }
            .frame(width: UIScreen.getWidth(350))
            .background{
                RoundedRectangle(cornerRadius: 8)
                    .foregroundColor(.gray_700)
                RoundedRectangle(cornerRadius: 8)
                    .stroke(lineWidth: /*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
                    .foregroundColor(.label_500)
            }
        }
        .padding(.bottom, 6)
    }
    
    var TodayCard: some View {
        ZStack{
            VStack(alignment: .center){
                HStack{
                    Text(Date().formatNow(.monthDayWeek))
                        .font(.title2())
                        .foregroundColor(.label_900)
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.vertical, 24)
                RoutineDescriptionCard
                    .padding(.bottom, 15)
                    .padding(.leading,10)
                //운동 시작 버튼
                NavigationLink {
                    MockUpWorkoutOngoingView()
                } label: {
                    FloatingButton(size: .semiMedium, color: .green_main) {
                        Text("체험 운동 시작")
                            .foregroundColor(.gray_900)
                            .font(.button1())
                    }
                    .padding(.bottom, 14)
                }
            }
        }
        .padding(.horizontal, 10)
        .frame(width: UIScreen.getWidth(350))
        .background{
            RoundedRectangle(cornerRadius: 8)
                .foregroundColor(.gray_700)
        }
    }
}

//#Preview {
//    NavigationStack{
//        TabView{
//            MockUpStartView(showTest: .constant(true)
//                .tabItem {
//                    Image(systemName: "dumbbell")
//                    Text("루틴")
//                }
//            MockUpStartView()
//                .tabItem {
//                    Image(systemName: "dumbbell")
//                    Text("루틴")
//                }
//        }
//    }
//}
