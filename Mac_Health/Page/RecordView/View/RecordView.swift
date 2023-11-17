//
//  RecordView.swift
//  Mac_Health
//
//  Created by 송재훈 on 10/26/23.
//

import SwiftUI

struct RecordView: View {
    @StateObject var vm = RecordViewModel()
    @Binding var loggedIn: Bool
    
    var body: some View {
        ZStack {
            Color.gray_900.ignoresSafeArea()
            
            VStack {
                NavigationTitle
                Calender
                RecordCell
                loggedIn ? nil : beforeLoginText
                Spacer()
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
        CalendarView(selectedDate: $vm.selectedDate, recordedDate: $vm.recordedDate)
            .frame(height: UIScreen.getHeight(362))
            .padding(.horizontal)
    }
    
    var RecordCell: some View {
        ForEach(vm.records.records.filter { $0.date == vm.selectedDate }, id: \.self) { record in
            NavigationLink {
                RecordSpecificView(record: record)
            } label: {
                RoundedRectangle(cornerRadius: 8)
                    .foregroundColor(.fill_1)
                    .frame(width: UIScreen.getWidth(350), height: UIScreen.getHeight(72))
                    .overlay {
                        VStack {
                            HStack {
                                //                            Ellipse()
                                //                                .frame(width: UIScreen.getWidth(8), height: UIScreen.getHeight(8))
                                //                                .foregroundColor(.yellow_main)
                                // TODO: 인플루언서 명
                                Text(record.influencerName)
                                    .font(.headline2())
                                    .foregroundColor(.label_900)
                                Spacer()
                                // TODO: 시간 파싱
                                Text(record.time)
                                    .font(.headline2())
                                    .foregroundColor(.label_900)
                            }
                            Spacer()
                            HStack {
                                Text(record.part)
                                    .font(.body2())
                                    .foregroundColor(.label_900)
                                Spacer()
                                // TODO: 총 운동 무게 - MORO
                                Text("5200kg")
                                    .font(.body2())
                                    .foregroundColor(.label_900)
                            }
                        }
                        .padding()
                    }
            }
        }
    }
    //TODO: 로그인x or 구독 x
    var beforeLoginText: some View {
        VStack{
            NavigationLink {
                MockUpRecordExampleView()
            } label: {
                RoundedRectangle(cornerRadius: 8)
                    .foregroundColor(.fill_1)
                    .frame(width: UIScreen.getWidth(350), height: UIScreen.getHeight(72))
                    .overlay {
                        VStack {
                            HStack {
                                Text("정회승")
                                    .font(.headline2())
                                    .foregroundColor(.label_900)
                                Spacer()
                                
                                Text("52분 12초")
                                    .font(.headline2())
                                    .foregroundColor(.label_900)
                            }
                            Spacer()
                            HStack {
                                Text("어깨,가슴,삼두")
                                    .font(.body2())
                                    .foregroundColor(.label_500)
                                Spacer()
                                
                                Text("10040kgkg")
                                    .font(.body2())
                                    .foregroundColor(.label_900)
                            }
                        }
                        .padding()
                    }
            }

            HStack{
                Image(systemName: "info.circle")
                Text("운동기록 예시입니다")
                Spacer()
            }
            .padding(.horizontal, 25)
            .padding(.vertical, 5)
            .font(.caption)
            .foregroundColor(.label_700)
        }
    }
}


//struct RecordView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationStack {
//            RecordView()
//        }
//    }
//}
