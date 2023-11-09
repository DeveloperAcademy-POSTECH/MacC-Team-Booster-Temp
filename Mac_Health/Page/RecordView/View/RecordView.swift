//
//  RecordView.swift
//  Mac_Health
//
//  Created by 송재훈 on 10/26/23.
//

import SwiftUI

struct RecordView: View {
    @State var testState = "test"
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.gray_900.ignoresSafeArea()
                
                VStack {
                    NavigationTitle
                    Calender
                    RecordCard
                    Spacer()
                }
            }
        }
    }
    
    var NavigationTitle: some View {
        HStack {
            Text("기록")
                .font(.title2())
                .foregroundColor(.label_900)
            Spacer()
        }
        .padding()
    }
    
    var Calender: some View {
        CalendarView(testState: $testState).frame(height: UIScreen.getHeight(362))
            .padding(.horizontal)
    }
    
    var RecordCard: some View {
        NavigationLink {
            RecordSpecificView()
        } label: {
            RecordCell
        }
    }
    
    var RecordCell: some View {
        RoundedRectangle(cornerRadius: 8)
            .foregroundColor(.fill_1)
            .frame(width: UIScreen.getWidth(350), height: UIScreen.getHeight(72))
            .overlay {
                VStack {
                    HStack {
                        Ellipse()
                            .frame(width: UIScreen.getWidth(8), height: UIScreen.getHeight(8))
                            .foregroundColor(.yellow_main)
                        Text("정회승")
                            .font(.headline2())
                            .foregroundColor(.label_900)
                        Spacer()
                        
                        Text("1시간 32분 12초")
                            .font(.headline2())
                            .foregroundColor(.label_900)
                    }
                    Spacer()
                    HStack {
                        Text("등/가슴")
                            .font(.body2())
                            .foregroundColor(.label_900)
                        Spacer()
                        
                        Text("14500g")
                            .font(.body2())
                            .foregroundColor(.label_900)
                    }
                }
                .padding()
            }
    }
}


struct RecordView_Previews: PreviewProvider {
    static var previews: some View {
        RecordView()
    }
}
