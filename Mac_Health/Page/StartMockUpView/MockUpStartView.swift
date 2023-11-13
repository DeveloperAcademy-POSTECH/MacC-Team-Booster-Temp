//
//  MockUpStartView.swift
//  Mac_Health
//
//  Created by 정회승 on 11/13/23.
//

import SwiftUI

struct MockUpStartView: View {
    @State var todayText = "반가워요 득근해봅시다💪"
    @Binding var tabSelection: Int
    var Influencer = "정회승"

    var body: some View {
        ZStack{
            Color.gray_900.ignoresSafeArea()
            VStack{
                ZStack(alignment: .top) {
                    //사진
                    Image(systemName: "person")
                        .resizable()
                    //                        .scaledToFill()
                        .frame(width: UIScreen.getWidth(390))
                    //인플루언서의 오늘의 루틴
                    NavigationTitle
                    
                    //오늘의 상태 텍스트
                    TodayText
                    
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
        VStack {
            HStack {
                Text("\(Influencer)의 \n오늘의 루틴")
                    .font(.title1())
                    .foregroundColor(.label_900)
                Spacer()
            }
            .padding(.horizontal)
        .padding(.top, 30)
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
                        .font(.body)
                        .foregroundColor(.label_800)
                }
                .padding(20)
            }
            .frame(width: UIScreen.getWidth(350))
            .background{
                RoundedRectangle(cornerRadius: 8)
                    .foregroundColor(.gray_700)
            }
            .background{
                RoundedRectangle(cornerRadius: 8)
                ///label_500 적용 안됨
                    .stroke(.white, lineWidth: /*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
            }
        }
    }
    
    func TodayCard () -> some View {
        ZStack{
            VStack(alignment: .center){
                HStack{
                    Text(getNowDateTime())
                        .font(.title2())
                        .foregroundColor(.label_900)
                    Spacer()
//                    NavigationLink {
//                        ChangeRoutineView(routineVM: RoutineVM())
//                            .navigationBarTitle("전체 루틴", displayMode: .inline)
//                    } label: {
//                        Image(systemName: "calendar")
//                            .font(.title2())
//                            .foregroundColor(.green_main)
//                    }
                    
                    
                }
                .padding(.horizontal)
                .padding(.bottom)
                RoutineDescriptionCard
                .padding(.bottom, 10)
                .padding(.leading,10)
                //운동 시작 버튼
                NavigationLink {
                    MockUpWorkoutOngoingView(tabSelection: $tabSelection, routineVM: RoutineVM())
                } label: {
                    RoundedRectangle(cornerRadius: 100)
                        .frame(width: UIScreen.getWidth(300), height: UIScreen.getHeight(60))
                        .foregroundColor(.green_main)
                        .overlay { Text("운동 시작")
                                .foregroundColor(.gray_900)
                                .font(.button1())
                        }
                }
            }
        }
        .frame(width: UIScreen.getWidth(350), height: UIScreen.getHeight(320))
        .background{
            RoundedRectangle(cornerRadius: 8)
                .foregroundColor(.gray_700)
        }

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

#Preview {
    MockUpStartView(tabSelection: .constant(3))
}
