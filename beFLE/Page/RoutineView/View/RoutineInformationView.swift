//
//  RoutineInformationView.swift
//  beFLE
//
//  Created by 송재훈 on 11/15/23.
//

import SwiftUI

/// 루틴 정보를 확인하는 뷰
/// - Parameters:
///  - routineId: 정보를 확인할 루틴 id
struct RoutineInformationView: View {
    let routineId: Int
    @StateObject var vm = RoutineInformationViewModel()
    @Environment(\.dismiss) var dismiss: DismissAction
    
    var body: some View {
        ZStack {
            Color.gray_900.ignoresSafeArea()
            ScrollView {
                VStack {
                    SpecificInformation
                }
                .padding(.vertical, 10)
                Divider()
                    .foregroundColor(.fill_1)
                    .padding(.horizontal, 20)
                WorkoutRoutine
                
                FloatingButton(size: .medium) {}
                    .padding()
            }
            
            gradient
            
            startButton
        }
        .onAppear {
            vm.fetch(routineId: routineId)
        }
        .navigationBarBackButtonHidden()
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                BackButton
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
    
    var SpecificInformation: some View {
        VStack {
            Information(systemName: "figure.arms.open", description: vm.routine.part)
            Information(systemName: "square.stack.fill", description: "\(vm.routine.numberOfExercise)개")
            Information(systemName: "clock.fill", description: "\(vm.routine.requiredMinutes)분")
            Information(systemName: "flame.circle.fill", description: "\(vm.routine.burnedKCalories)kcal")
        }
    }
    
    var BackButton: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "chevron.left")
                .foregroundColor(.label_700)
                .font(.headline2())
        }
    }
    
    func Information(systemName: String, description: String) -> some View {
        HStack {
            Image(systemName: systemName)
                .font(.body())
                .foregroundColor(.label_700)
                .padding(.leading, 15)
            Text(description)
                .font(.body())
                .foregroundColor(.label_900)
            Spacer()
        }
        .padding(5)
    }
    
    var WorkoutRoutine: some View {
        ZStack {
            //운동 부위 갯수별 load
            VStack(spacing: 12) {
                HStack {
                    Text(vm.routine.part)
                        .font(.headline1())
                        .foregroundColor(.label_900)
                    Spacer()
                }
                .frame(width: UIScreen.getWidth(350))
                .padding(.top ,UIScreen.getHeight(20))
                
                ForEach(vm.routine.exercises, id: \.self) { exercise in
                    WorkoutCell(exercise: exercise)
                }
            }
        }
    }
    
    var startButton: some View{
        VStack {
            Spacer()
            NavigationLink {
                WorkoutView(routineId: routineId)
            } label: {
                FloatingButton(size: .medium, color: .green_main) {
                    Text("운동 시작")
                        .foregroundColor(.gray_900)
                        .font(.button1())
                }
            }
            .padding()
        }
    }
    
    var gradient: some View{
        VStack{
            Spacer()
            LinearGradient(colors: [.clear, .gray_900.opacity(0.7), .gray_900, .gray_900, .gray_900], startPoint: .top, endPoint: .bottom)
                .frame(height: UIScreen.getHeight(150), alignment: .bottom)
                .allowsHitTesting(false)
        }
        .ignoresSafeArea()
    }
    
}
//
//#Preview {
//    RoutineInformationView(routineId: 1)
//}
