//
//  WorkoutStatusEditView.swift
//  Mac_Health
//
//  Created by 송재훈 on 11/6/23.
//

import SwiftUI

struct WorkoutStatusEditView: View {
    @Environment(\.dismiss) var dismiss
    
    @State var isDetailedWorkoutShow = false
    @State var isConfirmationDialogShow = false
    @State var isAlternativeWorkoutShow = false
    @State var isDeleteAlertShow = false
    
    let workoutName = "클로즈 그립 랫 풀 다운"
    
    var body: some View {
        VStack {
            WokroutList
        }
        .navigationTitle("운동 목록 편집")
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                BackButton
            }
        }
        .navigationBarBackButtonHidden()
        .sheet(isPresented: $isDetailedWorkoutShow) {
            DetailedWorkoutSheet()
        }
        .confirmationDialog(workoutName, isPresented: $isConfirmationDialogShow, titleVisibility: .visible) {
            ConfirmationDialog
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
            Image(systemName: "xmark")
                .font(.headline1())
                .foregroundColor(.label_700)
        }
    }
    
    var WokroutList: some View {
        VStack {
            HStack {
                // TODO: .
                Text("등")
                    .foregroundColor(.label_900)
                    .font(.headline1())
                
                Spacer()
            }
            
            ScrollView {
                // TODO: .
                WorkoutListCell
                    .onTapGesture {
                        isDetailedWorkoutShow = true
                    }
            }
        }
        .padding(.horizontal)
    }
    
    var WorkoutListCell: some View {
        HStack {
            RoundedRectangle(cornerRadius: 4)
                .foregroundColor(.fill_1)
                .frame(width: UIScreen.getWidth(64), height: UIScreen.getHeight(64))
                .overlay {
                    // TODO: .
                    Image("CloseGripLatPullDown")
                        .resizable()
                }
            
            VStack(alignment: .leading) {
                // TODO: .
                Text(workoutName)
                    .foregroundColor(.label_900)
                    .font(.headline1())
                HStack {
                    // TODO: .
                    Text("3세트")
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
                isConfirmationDialogShow = true
            } label: {
                Image(systemName: "ellipsis")
                .foregroundColor(.label_700)
            }
        }
    }
    
    @ViewBuilder
    var ConfirmationDialog: some View {
        Button {
            // TODO: .
            isAlternativeWorkoutShow = true
        } label: {
            Text("운동 대체")
        }
        
        Button {
            // TODO: .
            isDeleteAlertShow = true
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

struct WorkoutStatusEditView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutStatusEditView()
    }
}
