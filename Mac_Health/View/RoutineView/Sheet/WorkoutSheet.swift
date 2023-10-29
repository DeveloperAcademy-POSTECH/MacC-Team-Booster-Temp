//
//  DailyWorkoutSheet.swift
//  Mac_Health
//
//  Created by 최진용 on 2023/10/22.
//

import SwiftUI

enum WorkoutType: String, CaseIterable {
    case 전체, 등, 가슴, 이두, 삼두, 하체
}

struct WorkoutSheet: View {
    @ObservedObject var routineVM: RoutineVM
    ///운동 정렬용 선택
    @State var selection: String = "전체"
    let workoutTypes = WorkoutType.allCases
    
    var body: some View {
        ZStack {
            Color.gray_800.ignoresSafeArea()
            VStack {
                NavigationBar
                SortingSlider
                ///여기에는 달력에 맞는 운동 넣어주기
                ZStack {
                    Workouts
                    ///if logInt ? 0 : 3
                        .blur(radius: 3)
                    Blind
                }
            }
        }
    }
    
    var Blind: some View {
            VStack(spacing: UIScreen.getHeight(28)) {
                Text("구독을 통해\n매일의 루틴 정보를 확인할수 있어요")
                    .multilineTextAlignment(.center)
                    .lineSpacing(5)
                    .font(.title2())
                    .foregroundColor(.label_900)
                Button {
                    
                } label: {
                    Capsule()
                        .foregroundColor(.green_main)
                        .frame(width: UIScreen.getWidth(180), height: UIScreen.getHeight(60))
                        .overlay {
                            Text("둘러보기")
                                .foregroundColor(.gray_900)
                                .font(.button1())
                                
                        }
                }

            }
    }
    
    
    var Workouts: some View {
        ScrollView {
            ///데이터에서 받아온 달력과 운동에 관해서 작성,
            ForEach(Range(0...10)) { a in
                TodayWorkoutCell(date: a)
            }
        }.padding(.horizontal)
    }
    
    func TodayWorkoutCell(date: Int) -> some View {
        HStack(spacing: UIScreen.getWidth(16)) {
            RoundedRectangle(cornerRadius: 8)
            ///오늘이면 today == date ? fill_2 : label_900
                .foregroundColor(.label_900)
                .frame(width: UIScreen.getWidth(40), height: UIScreen.getHeight(40))
                .overlay {
                    Text("\(date)")
                        .font(.headline1())
                    ///오늘이면 today == date ? label_900 : gray_900
                        .foregroundColor(.gray_900)
                }
            Text("등, 이두")
                .font(.headline1())
                .foregroundColor(.label_900)
            Spacer()
            ///다한거 아니면 없도록 한다.
            Circle()
                .frame(width: UIScreen.getWidth(36))
                .foregroundColor(.green_10)
                .overlay {
                    Image(systemName: "checkmark")
                        .foregroundColor(.green_main)
                        .font(.body2())
                }
        }
    }
    
    
    var SortingSlider: some View {
        ScrollView(.horizontal) {
            HStack(spacing: UIScreen.getWidth(6)) {
                ForEach(workoutTypes, id: \.self) { type in
                    Button {
                        selection = type.rawValue
                    } label: {
                        if type.rawValue == selection {
                            selectedCapsul(text: type.rawValue)
                        }
                        else {
                            notSelectedCapsul(text: type.rawValue)
                        }
                    }

                }.frame(height: UIScreen.getHeight(34))
            }.padding(.horizontal)
                .padding(.bottom)
        }
    }
    
    @ViewBuilder
    func notSelectedCapsul(text: String) -> some View {
        Capsule()
            .strokeBorder()
            .foregroundColor(.label_400)
            .frame(minWidth: UIScreen.getWidth(54), idealHeight: UIScreen.getHeight(34))
            .overlay {
                Text(text)
                    .foregroundColor(.label_900)
                    .font(.button2())
            }
    }
    
    @ViewBuilder
    func selectedCapsul(text: String) -> some View {
        Capsule()
            .foregroundColor(.green_main)
            .frame(minWidth: UIScreen.getWidth(54), idealHeight: UIScreen.getHeight(34))
            .overlay {
                Text(text)
                    .foregroundColor(.gray_900)
                    .font(.button2())
            }
    }
    
    var NavigationBar: some View {
        HStack {
            Text("날짜별 루틴")
                .foregroundColor(.label_900)
                .font(.title1())
            Spacer()
            Button {
                routineVM.isDailyRoutineOpen.toggle()
            } label: {
                Circle()
                    .frame(width: UIScreen.getWidth(30))
                    .foregroundColor(.gray_600)
                    .overlay {
                        Image(systemName: "multiply")
                            .foregroundColor(.label_700)
                            .font(.headline1())
                    }
            }
        }.padding()
    }
}

struct WorkoutView_Preview: PreviewProvider {
    static var previews: some View {
        WorkoutSheet(routineVM: RoutineVM())
    }
}
