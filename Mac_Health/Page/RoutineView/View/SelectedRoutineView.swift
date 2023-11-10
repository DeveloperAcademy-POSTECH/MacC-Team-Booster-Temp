//
//  SelectedRoutineView.swift
//  Mac_Health
//
//  Created by 정회승 on 11/3/23.
//

import SwiftUI

struct SelectedRoutineView: View {
    @StateObject var vm = SelectedRoutineViewModel()
    
    @State var showDetail = false
    @Environment(\.dismiss) var dismiss: DismissAction
    
    var body: some View {
        ZStack{
            ScrollView{
                VStack{
                    SpecificInformation
                }
                .padding(.vertical, 20)
                Divider()
                    .foregroundColor(.fill_1)
                    .padding(.horizontal, 20)
                WorkoutRoutine
                
            }
            VStack{
                Spacer()
                Button {
                    print("start workout")
                } label: {
                    FloatingButton(backgroundColor: .green_main) { Text("운동 시작")
                            .foregroundColor(.gray_900)
                            .font(.button1())
                }

                
                }
                .padding()
        }
       
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                BackButton
            }
        }

    }
    
    var SpecificInformation: some View {
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
    }

    
    var WorkoutRoutine: some View {
        //        ScrollView {
        ZStack {
            //운동 부위 갯수별 load
            VStack(spacing: 16) {
                HStack {
                    Text("등")
                        .font(.headline1())
                        .foregroundColor(.label_900)
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
            }
            ///로그인의 유무에 따라서 있고 없고
            //                LinearGradient(colors: [.gray_900, .clear], startPoint: .bottom, endPoint: .top)
        }
        ///로그인의 유무에 따라서 있고 없고
        //        }
        //        .disabled(true)
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
    SelectedRoutineView()
}
