//
//  TodayRoutineView.swift
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
                    HStack{
                        Text("\(Influencer)의 \n오늘의 루틴")
                            .font(.title1())
                            .foregroundColor(.label_900)
                            .padding(.leading, 20)
                        Spacer()
                    }
                    
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
                
                
                ZStack{
                    VStack{
                        HStack{
                            Text("11월 1일 수요일")
                                .font(.title2())
                                .foregroundColor(.label_900)
                            Spacer()
                            NavigationLink {
                                ChangeRoutineView(routineVM: RoutineVM())
                                    .navigationBarTitle("전체 루틴", displayMode: .inline)
                            } label: {
                                Image(systemName: "calendar")
                                    .font(.title2())
                                    .foregroundColor(.green_main)
                            }
                            
                            
                        }
                        .padding(20)
                        VStack{
                            ForEach(TodaySpecificViewModel.allCases, id: \.self) { option in
                                HStack{
                                    VStack{
                                        Image(systemName: option.image)
                                            .font(.body())
                                            .foregroundColor(.label_700)
                                            .padding(.leading, 15)
                                    }
                                    VStack{
                                        Text(option.contents)
                                            .font(.body())
                                            .foregroundColor(.label_900)
                                    }
                                    Spacer()
                                }
                                .padding(5)
                                
                                
                                
                            }
                            //if 휴식날
                            //                            VStack{
                            //                                Image(systemName: "moon.stars.fill")
                            //                                    .resizable()
                            //                                    .foregroundColor(.label_500)
                            //                                    .frame(width: 50, height: 50)
                            //                                    .padding()
                            //                                    .padding(.top, 10)
                            //                                Text("휴식")
                            //                                    .font(.headline1())
                            //                                    .foregroundColor(.label_900)
                            //                            }
                        }
                        .padding(.bottom, 20)
                        //운동 시작 버튼
                        NavigationLink {
                            WorkoutListView()
                        } label: {
                            RoundedRectangle(cornerRadius: 100)
                                .frame(width: UIScreen.getWidth(318), height: UIScreen.getHeight(60))
                                .foregroundColor(.green_main)
                                .overlay { Text("운동 시작")
                                        .foregroundColor(.gray_900)
                                        .font(.button1())
                                }.padding(.bottom, 10)
                        }
                    }
                }
                .frame(width: UIScreen.getWidth(350), height: UIScreen.getHeight(325))
                .padding(.vertical, 10)
                .background{
                    RoundedRectangle(cornerRadius: 8)
                        .foregroundColor(.gray_700)
                }
            }
            .padding(.bottom, 35)
            Spacer()
                .frame(height: UITabBarController().height)
            
        }
    }
}

struct TodayRoutineView_Previews: PreviewProvider {
    static var previews: some View {
        TodayStartView()
    }
}
