//
//  TodayStartView.swift
//  Mac_Health
//
//  Created by 정회승 on 2023/11/01.
//

import SwiftUI

struct TodayStartView: View {
    @State var todayText = "오늘은 컨디션이 좀 안 좋아서 살살 했어요"
    @State var Influencer = "정회승"
    
    @StateObject var vm = TodayStartViewModel()
    
    var body: some View {
        ZStack{
            Color.gray_900.ignoresSafeArea()
            VStack{
                ZStack(alignment: .top) {
                    Image(systemName: "person")
                        .resizable()
                    //                        .scaledToFill()
                        .frame(width: UIScreen.getWidth(390))
                        .offset(x:20, y: 30)
                    //인플루언서의 오늘의 루틴
                    NavigationTitle
                    
                    //오늘의 상태 텍스트
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
            Text("\(Influencer)의 \n오늘의 루틴")
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
                Description(image: "figure.arms.open", text: "등 이두")
                Description(image: "square.stack.fill", text: "7개")
                Description(image: "clock.fill", text: "50분")
                Description(image: "flame.circle.fill", text: "569kcal")
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
    
    func TodayCard () -> some View {
        ZStack{
            VStack(alignment: .center){
                HStack{
                    Text("11월 1일 수요일")
                        .font(.title2())
                        .foregroundColor(.label_900)
                    Spacer()
                    NavigationLink {
                        ChangeRoutineView(routineVM: RoutineViewModel())
                            .navigationBarTitle("전체 루틴", displayMode: .inline)
                    } label: {
                        Image(systemName: "calendar")
                            .font(.title2())
                            .foregroundColor(.green_main)
                    }
                    
                    
                }
                .padding(.horizontal)
                .padding(.bottom)
                RoutineDescriptionCard
                .padding(.bottom, 10)
                .padding(.leading,10)
                //운동 시작 버튼
                NavigationLink {
                    WorkoutListView()
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
}

struct TodayStartView_Previews: PreviewProvider {
    static var previews: some View {
        TodayStartView()
    }
}
