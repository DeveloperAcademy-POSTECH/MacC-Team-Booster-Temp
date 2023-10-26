//
//  RoutineView.swift
//  Mac_Health
//
//  Created by 최진용 on 2023/10/21.
//

import SwiftUI

struct RoutineView: View {
    @StateObject var routineVM = RoutineVM()
    @State var showDetail = false
    
    var body: some View {
        ZStack {
            Color.gray_900.ignoresSafeArea()
            VStack {
                NavigationTitle
                TopBanner
//                RestDay
                WorkoutRoutine
                Spacer()
                ///로그인 되어있으면 없앰
//                ExplainText
                BottomButton
            }
        }
        .sheet(isPresented: $routineVM.isDailyRoutineOpen) {
            WorkoutSheet(routineVM: routineVM)
                .presentationDetents([.height(UIScreen.getHeight(584))])
        }
        .sheet(isPresented: $showDetail) {
            DetailWorkoutSheet()
        }
        .fullScreenCover(isPresented: $routineVM.showWorkOutOnGoing) {
            WorkoutOngoingView(currentWorkoutNumber: 1, routineVM: routineVM)
        }
        //darkmode test용
        .presentationCompactAdaptation(.automatic)
    }
    
//    var Influencers: some View {
//        //이거는 시저가 짜둔거에서 가져오면 됨
//    }
    
    
    var RestDay: some View {
        VStack(spacing: 20) {
            Spacer()
            Image("rest")
                .resizable()
                .scaledToFit()
                .frame(width: UIScreen.getWidth(47))
            Text("휴식")
                .font(.title2())
                .foregroundColor(.label_900)
            Spacer()
        }
    }
    
    var ExplainText: some View {
        Text("구독 후 전문가의\n실제루틴을 따라해보세요")
            .multilineTextAlignment(.center)
            .lineSpacing(5)
            .font(.title2())
            .foregroundColor(.label_900)
            .padding(.bottom, UIScreen.getHeight(40))
    }
    
    var BottomButton: some View {
        /// 여기는 상태에 따라서 다 다르게 행동해야함
        Button {
//            if true {
//                print("둘러보기")
//            }
//            else {
            routineVM.showWorkOutOnGoing.toggle()
//            }
            
        } label: {
            RoundedRectangle(cornerRadius: 100)
                .frame(width: UIScreen.getWidth(350), height: UIScreen.getHeight(60))
                .foregroundColor(.green_main)
                .overlay {
                    ///로그인 안되어있으면
                    ///Text(true ? "루틴 둘러보기" : "운동 시작하기")
                    Text("운동 시작하기")
                        .foregroundColor(.gray_900)
                        .font(.button1())
                }
                .padding()
        }
    }
    
    
    var WorkoutRoutine: some View {
        ScrollView {
            ZStack {
                VStack(spacing: 16) {
                    HStack {
                        Text("등")
                            .font(.headline1())
                            .foregroundColor(.label_400)
                        Spacer()
                    }
                    .frame(width: UIScreen.getWidth(350))
                    .padding(.top ,UIScreen.getHeight(20))
                    WorkoutCell()
                    ///누르면 detail셀이 나와야한다.
                    .onTapGesture {
                        showDetail.toggle()
                    }
                    WorkoutCell()
                    WorkoutCell()
                    WorkoutCell()
                    
                }
                ///로그인의 유무에 따라서 있고 없고
//                LinearGradient(colors: [.gray_900, .clear], startPoint: .bottom, endPoint: .top)
            }
            ///로그인의 유무에 따라서 있고 없고
        }
//        .disabled(true)
    }
    
    var TopBanner: some View {
        RoundedRectangle(cornerRadius: 8)
            .frame(width: UIScreen.getWidth(350), height: UIScreen.getHeight(72))
            .foregroundColor(.gray_700)
            .overlay {
                //MARK: - 여기에 Zstack에 이미지까지 얹어줘야함
                ZStack {
                    HStack {
                        VStack(alignment: .leading, spacing: 3) {
                            //MARK: -여기부분에 선수님의 이름들어가야함
                            Text("전문가의 일상 운동")
                                .font(.headline1())
                                .foregroundColor(.label_900)
                            //MARK: - 여기부분에 해당 일의 루틴이 들어가야함
                            Text("등/가슴 Day")
                                .font(.body2())
                                .foregroundColor(.label_700)
                        }
                        .padding()
                        Spacer()
                        Capsule()
                            .foregroundColor(.yellow_main)
                            .frame(height: UIScreen.getHeight(130))
                            .offset(x: UIScreen.getWidth(130))
                    }
                    HStack {
                        Spacer()
                        Image("healthman")
                            .font(.body2())
                    }
                }
                .mask {
                    RoundedRectangle(cornerRadius: 8)
                        .frame(width: UIScreen.getWidth(350), height: UIScreen.getHeight(72))
                }
            }
    }

    
    var NavigationTitle: some View {
        HStack {
            Button {
                routineVM.isDailyRoutineOpen.toggle()
            } label: {
                HStack {
                    Text(routineVM.date)
                    Image(systemName: "chevron.forward")
                        .font(.body())
                }
                .foregroundColor(.label_900)
                .font(.title2())
            }
            Spacer()
        }
        .padding()
    }
}


struct RoutineView_Preview: PreviewProvider {
    static var previews: some View {
        RoutineView()
    }
}
