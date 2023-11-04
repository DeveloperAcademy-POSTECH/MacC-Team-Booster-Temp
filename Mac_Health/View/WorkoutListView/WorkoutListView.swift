//
//  WorkoutListView.swift
//  Mac_Health
//
//  Created by 송재훈 on 11/4/23.
//

import SwiftUI

struct WorkoutListView: View {
    @State var isDetailedWorkoutShow = false
    @State var isConfirmationDialogShow = false
    @State var isAlternativeWorkoutShow = false
    
    var body: some View {
        VStack {
            NavigationTitle
            WokroutList
            
            WorkoutStartButton
        }
        .sheet(isPresented: $isDetailedWorkoutShow) {
            DetailedWorkoutSheet()
        }
        .confirmationDialog("클로즈 그립 랫 풀 다운", isPresented: $isConfirmationDialogShow, titleVisibility: .visible) {
            ConfirmationDialog
        }
        .alert("운동을 삭제하시겠습니까?", isPresented: $isAlternativeWorkoutShow) {
            Button("취소") {
                // MARK: 취소
            }
            Button("삭제") {
                // MARK: 완료하기
            }
        }
    }
    
    var NavigationTitle: some View {
        HStack(alignment: .bottom) {
            Button {
                
            } label: {
                Image(systemName: "chevron.left")
                    .foregroundColor(.label_700)
            }
            
            Spacer()
            
            Text("운동 목록")
                .foregroundColor(.label_900)
            
            Spacer()
        }
        .font(.headline1())
        .padding(.horizontal)
        .frame(width: UIScreen.getWidth(390), height: UIScreen.getHeight(100))
    }
    
    var WokroutList: some View {
        VStack {
            HStack {
                Text("등")
                    .foregroundColor(.label_900)
                    .font(.headline1())
                
                Spacer()
            }
            
            ScrollView {
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
                    Image("CloseGripLatPullDown")
                        .resizable()
                }
            
            VStack(alignment: .leading) {
                Text("클로즈 그립 랫 풀 다운")
                    .foregroundColor(.label_900)
                    .font(.headline1())
                HStack {
                    Text("3세트")
                        .foregroundColor(.label_700)
                        .font(.body2())
                    Text("|")
                        .foregroundColor(.label_400)
                        .font(.body2())
                    Text("10-15회")
                        .foregroundColor(.label_700)
                        .font(.body2())
                }
            }
            
            Spacer()
            
            Button {
                isConfirmationDialogShow = true
            } label: {
                Image(systemName: "ellipsis")
                .foregroundColor(.label_700)
            }
        }
    }
    
    var WorkoutStartButton: some View {
        Button {
        
        } label: {
            FloatingButton(backgroundColor: .green_main) {
                Text("시작")
                    .foregroundColor(.gray_900)
                    .font(.button1())
            }
        }
    }
    
    @ViewBuilder
    var ConfirmationDialog: some View {
        Button {
            isAlternativeWorkoutShow = true
        } label: {
            Text("운동 대체")
        }
        
        Button {
            
        } label: {
            Text("삭제")
        }
        
        Button(role: .cancel) {
            //
        } label: {
            Text("취소")
        }
    }
}


struct WorkoutListView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutListView()
    }
}
