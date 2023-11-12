//
//  WorkoutListView.swift
//  Mac_Health
//
//  Created by 송재훈 on 11/4/23.
//

import SwiftUI

struct WorkoutListView: View {
    let routineId: Int
    // TODO: WorkoutListView 데이터 작업
    @Environment(\.dismiss) var dismiss
    
    @State var isDetailedWorkoutShow = false
    @State var isConfirmationDialogShow = false
    @State var isAlternativeWorkoutShow = false
    @State var isDeleteAlertShow = false
    @StateObject var vm = WorkoutListViewModel()
    
    var body: some View {
        VStack {
            WorkoutList
            
            WorkoutStartButton
        }
        .navigationTitle("운동 루틴 편집")
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                BackButton
            }
        }
        .navigationBarBackButtonHidden()
        .sheet(isPresented: $isDetailedWorkoutShow) {
            DetailedWorkoutSheet()
        }
        .confirmationDialog(vm.routine.part, isPresented: $isConfirmationDialogShow, titleVisibility: .visible) {
            AlternativeActionSheet
        }
        .sheet(isPresented: $isAlternativeWorkoutShow) {
            AlternativeWorkoutSheet()
        }
        .alert("운동을 삭제하시겠습니까?", isPresented: $isDeleteAlertShow) {
            DeleteAlert
        }
    }
    
    var BackButton: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "chevron.left")
                .foregroundColor(.label_700)
                .font(.headline1())
        }
    }
    
    var WorkoutList: some View {
        VStack {
            HStack {
                Text("등")
                    .foregroundColor(.label_900)
                    .font(.headline1())
                
                Spacer()
            }
            
            ScrollView {
                ForEach($vm.routine.exercises, id: \.id) {
                    WorkoutListCell(exercise: $0)
                }
//                WorkoutListCell(index: 0, exercise: $vm.routine.exercises[0])
//                    .onTapGesture {
//                        // TODO: 각 셀 마다 데이터 바인딩해서 시트 지정
//                        isDetailedWorkoutShow = true
//                    }
            }
        }
        .padding(.horizontal)
    }
    
    func WorkoutListCell(exercise: Binding<Exercise>) -> some View {
        HStack {
            RoundedRectangle(cornerRadius: 4)
                .foregroundColor(.fill_1)
                .frame(width: UIScreen.getWidth(64), height: UIScreen.getHeight(64))
                .overlay {
                    // TODO: 이미지 사이즈
                    AsyncImage(url: URL(string: exercise.exerciseImageUrl.wrappedValue)) {
                        $0.image?
                            .resizable()
                    }
                }
            
            VStack(alignment: .leading) {
                Text(vm.routine.part)
                    .foregroundColor(.label_900)
                    .font(.headline1())
                HStack {
                    // TODO: .
                    Text("\(exercise.numberOfSet.wrappedValue)세트")
                        .foregroundColor(.label_700)
                        .font(.body2())
                    Text("|")
                        .foregroundColor(.label_400)
                        .font(.body2())
                    // TODO:
                    Text("10-15회")
                        .foregroundColor(.label_700)
                        .font(.body2())
                }
            }
            
            Spacer()
            
            Button {
                // TODO: .
            } label: {
                Image(systemName: "ellipsis")
                    .foregroundColor(.label_700)
            }
        }
    }
    
    var WorkoutStartButton: some View {
        NavigationLink {
            //            WorkoutOngoingView(currentWorkoutNumber: 0, routineVM: routineVM)
        } label: {
            FloatingButton(backgroundColor: .green_main) {
                Text("시작")
                    .foregroundColor(.gray_900)
                    .font(.button1())
            }
        }
    }
    
    @ViewBuilder
    var AlternativeActionSheet: some View {
        Button {
            // TODO: .
        } label: {
            Text("운동 대체")
        }
        
        Button {
            // TODO: .
        } label: {
            Text("삭제")
        }
        
        Button(role: .cancel) {
            // TODO: .
        } label: {
            Text("취소")
        }
    }
    
    @ViewBuilder
    var DeleteAlert: some View {
        Button("취소") {
            // TODO: .
        }
        Button("삭제") {
            // TODO: .
        }
    }
}

struct WorkoutListView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutListView(routineId: 1)
    }
}
