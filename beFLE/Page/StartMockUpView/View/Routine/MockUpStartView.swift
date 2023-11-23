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
    @Binding var showTest: Bool
    
    var body: some View {
        ZStack{
            Color.gray_900.ignoresSafeArea()
            InfluenceerImage
            VStack{
                ZStack(alignment: .top) {
                    NavigationTitle
                    TodayText
                }
                Spacer()
                TodayCard()
                Spacer()
                    .frame(height: UITabBarController().height)
            }
            .padding(.bottom, 25)
            
        }
        .navigationBarBackButtonHidden()
        .navigationBarTitleDisplayMode(.inline)
    }
    
    var InfluenceerImage: some View {
        Image("Influencer_main")
            .resizable()
            .scaledToFill()
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
            .padding(.top, 100)
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
    
    func TodayCard () -> some View {
        ZStack{
            VStack(alignment: .center){
                HStack{
                    Text(getNowDateTime())
                        .font(.title2())
                        .foregroundColor(.label_900)
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.bottom, 24)
                RoutineDescriptionCard
                    .padding(.bottom, 15)
                    .padding(.leading,10)
                //운동 시작 버튼
                NavigationLink {
                    MockUpWorkoutOngoingView(showTest: $showTest)
                } label: {
                    RoundedRectangle(cornerRadius: 100)
                        .frame(width: UIScreen.getWidth(318), height: UIScreen.getHeight(60))
                        .foregroundColor(.green_main)
                        .overlay { Text("체험 운동 시작")
                                .foregroundColor(.gray_900)
                                .font(.button1())
                        }
                }
            }
        }
        .padding(.horizontal, 10)
        .frame(width: UIScreen.getWidth(350), height: UIScreen.getHeight(325))
        .background{
            RoundedRectangle(cornerRadius: 8)
                .foregroundColor(.gray_700)
        }
        .padding(.bottom, 14)
        
    }
    
    func getNowDateTime() -> String {
        let nowDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier:  "ko")
        
        dateFormatter.dateFormat = "MM월 dd일 E요일"
        let date_String = dateFormatter.string(from: nowDate)
        return date_String
    }
}

//#Preview {
//    NavigationStack{
//        TabView{
//            MockUpStartView(tabSelection: .constant(3))
//                .tabItem {
//                    Image(systemName: "dumbbell")
//                    Text("루틴")
//                }
//            MockUpStartView(tabSelection: .constant(3))
//                .tabItem {
//                    Image(systemName: "dumbbell")
//                    Text("루틴")
//                }
//        }
//    }
//}
