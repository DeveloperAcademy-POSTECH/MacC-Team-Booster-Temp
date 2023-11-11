//
//  ChangeRoutineView.swift
//  Mac_Health
//
//  Created by 정회승 on 11/2/23.
//

import SwiftUI

enum WorkoutType: String, CaseIterable {
    case 전체, 등, 가슴, 이두, 삼두, 하체, 후면사슬, 복근
}

struct ChangeRoutineView: View {
    @Environment(\.dismiss) var dismiss: DismissAction
    @StateObject var vm = ChangeRoutineViewModel()
    
    ///운동 정렬용 선택
    @State var selection: String = "전체"
    let workoutTypes = WorkoutType.allCases
    
    var body: some View {
        ZStack {
            Color.gray_900.ignoresSafeArea()
            VStack {
                SortingSlider
                ///여기에는 달력에 맞는 운동 넣어주기
                ZStack {
                    //선택된 selection 들이 포함된 운동
                    Workouts
                    ///if logInt ? 0 : 3
                        .blur(radius: 0)
                    //                    Blind
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                BackButton
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
            ForEach(0..<vm.routines.routines.count, id: \.self) { idx in
                NavigationLink {
                    SelectedRoutineView()
                    // TODO: 데이트 포매터 사용
                        .navigationBarTitle("\(idx)월\(idx)일", displayMode: .inline)
                } label: {
                    TodayWorkoutCell(index: idx)
                        .padding(.vertical, 8)
                }
            }
        }
        .padding(.horizontal)
    }
    
    func TodayWorkoutCell(index: Int) -> some View {
        HStack(spacing: UIScreen.getWidth(16)) {
            RoundedRectangle(cornerRadius: 8)
            // TODO: 오늘이면 today == date ? fill_2 : label_900
                .foregroundColor(.label_900)
                .frame(width: UIScreen.getWidth(40), height: UIScreen.getHeight(40))
                .overlay {
                    // TODO: 데이트 포매터 사용
                    Text("\(vm.routines.routines[index].date)")
                        .font(.headline1())
                    ///오늘이면 today == date ? label_900 : gray_900
                        .foregroundColor(.gray_900)
                }
            Text("\(vm.routines.routines[index].part)")
                .font(.headline1())
                .foregroundColor(.label_900)
            
            Spacer()
            
            if vm.routines.routines[index].isDone {
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
                }
                .frame(height: UIScreen.getHeight(34))
            }
            .padding(.horizontal)
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
    NavigationStack{
        ChangeRoutineView()
    }
}
