//
//  WholeRoutineView.swift
//  beFLE
//
//  Created by 송재훈 on 11/15/23.
//

import SwiftUI

/// 인플루언서 개인의 전체 루틴 뷰
///  - Parameters:
///   - influencerId: 조회할 인플루언서의 id
struct WholeRoutineView: View {
    let influencerId: Int
    @StateObject var vm = WholeRoutineViewModel()
    @Environment(\.dismiss) var dismiss: DismissAction
    
    var body: some View {
        ZStack {
            Color.gray_900.ignoresSafeArea()
            VStack {
                SortingSlider
                switch vm.routinesByMonth.isEmpty {
                case true:
                    EmptyWorkoutView
                    
                case false:
                    Workouts
                }
            }
            .navigationTitle("전체 운동일지")
            .navigationBarBackButtonHidden()
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    BackButton
                }
            }
            .onAppear {
                vm.fetch(influencerId: influencerId)
            }
        }
        .gesture(
            DragGesture().onChanged { value in
                if value.startLocation.x < 50 {
                    vm.offset = value.translation.width
                }
            }
                .onEnded { value in
                    if value.predictedEndTranslation.width > 100 {
                        dismiss()
                    }
                    vm.offset = .zero
                }
        )
        .offset(x: vm.offset)
        .animation(.linear, value: vm.offset)
    }
}

/// 네비게이션 타이틀
extension WholeRoutineView {
    var BackButton: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "chevron.left")
                .foregroundColor(.label_700)
                .font(.headline1())
        }
    }
}

/// 부위 분류
extension WholeRoutineView {
    var SortingSlider: some View {
        ScrollView(.horizontal) {
            HStack(spacing: UIScreen.getWidth(6)) {
                ForEach(Part.allCases, id: \.self) { part in
                    Button {
                        vm.selectedPart = part
                        vm.parse()
                    } label: {
                        if vm.selectedPart == part {
                            SelectedCapsule(text: part.rawValue)
                        }
                        else {
                            NotSelectedCapsule(text: part.rawValue)
                        }
                    }
                }
                .frame(height: UIScreen.getHeight(34))
            }
            .padding()
            .padding(.top, 5)
        }
        .scrollIndicators(.hidden)
    }
    
    @ViewBuilder
    func NotSelectedCapsule(text: String) -> some View {
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
    func SelectedCapsule(text: String) -> some View {
        Capsule()
            .foregroundColor(.green_main)
            .frame(minWidth: UIScreen.getWidth(54), idealHeight: UIScreen.getHeight(34))
            .overlay {
                Text(text)
                    .foregroundColor(.gray_900)
                    .font(.button2())
            }
    }
    
    var Workouts: some View {
        ScrollView {
            ForEach(Array(vm.routinesByMonth.sorted(by: { $0.key > $1.key })), id: \.key) { routine in
                VStack {
                    HStack {
                        Text("\(routine.key)월")
                            .foregroundColor(.label_900)
                            .font(.headline1())
                            .padding(.leading, 5)
                        Spacer()
                    }
                    
                    ForEach(routine.value.sorted(by: { $0.date > $1.date }), id: \.self) { some in
                        if some.part != "휴식" {
                            NavigationLink {
                                RoutineInformationView(routineId: some.routineId)
                                    .navigationBarTitle("\(some.date.format(.monthDay))", displayMode: .inline)
                            } label: {
                                TodayWorkoutCell(routine: some)
                                    .padding(.vertical, 8)
                            }
                        } else {
                            TodayWorkoutCell(routine: some)
                                .padding(.vertical, 8)
                                .foregroundColor(.gray)
                        }
                    }
                }
            }
        }
        .padding(.horizontal)
        .scrollIndicators(.hidden)
    }
}

/// 운동 목록
extension WholeRoutineView {
    var EmptyWorkoutView: some View {
        VStack {
            Spacer()
            Text("해당 부위의 운동이 아직 없어요")
                .font(.headline1())
                .foregroundColor(.label_900)
            Spacer()
        }
    }
    
    func TodayWorkoutCell(routine: Routine) -> some View {
        HStack(spacing: UIScreen.getWidth(16)) {
            RoundedRectangle(cornerRadius: 8)
                .foregroundColor(routine.date.isToday() ? .label_900 : .fill_2)
                .frame(width: UIScreen.getWidth(40), height: UIScreen.getHeight(40))
                .overlay {
                    Text("\(routine.date.format(.day))")
                        .font(.headline1())
                        .foregroundColor(routine.date.isToday() ? .gray_900 : .label_900)
                }
            Text("\(routine.part)")
                .font(.headline1())
                .foregroundColor(.label_900)
            
            Spacer()
            
            if routine.isDone {
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
}

#Preview {
    NavigationStack {
        WholeRoutineView(influencerId: 1)
    }
}
