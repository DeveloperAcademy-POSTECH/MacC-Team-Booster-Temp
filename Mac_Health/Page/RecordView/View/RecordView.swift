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
                .padding(.leading, 3)
            Spacer()
        }
        .padding([.top, .horizontal])
        .padding(.bottom, 5)
    }
    
    var Calender: some View {
        CalendarView(selectedDate: $vm.selectedDate, recordedDate: $vm.recordedDate)
            .frame(height: UIScreen.getHeight(335))
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
                                Text(record.influencerName)
                                    .font(.headline2())
                                    .foregroundColor(.label_900)
                                Spacer()
                                Text("\(vm.formatTime(record.time))")
                                    .font(.headline2())
                                    .foregroundColor(.label_900)
                            }
                            Spacer()
                            HStack {
                                Text(record.part)
                                    .font(.body2())
                                    .foregroundColor(.label_500)
                                Spacer()
                                // TODO: 총 운동 무게 - MORO - 데이터 들어오면 계산 맞는지 확인할게요 (시저)
                                Text("\(vm.volume)kg")
                                    .font(.body2())
                                    .foregroundColor(.label_900)
                            }
                        }
                        .padding()
                    }
            }
            .onChange(of: vm.selectedDate) { _ in
                    vm.calculateTotalVolume()
                }
        }
        .padding(.bottom, 5)
    }
    
//    func formatTime(_ timeString: String) -> String {
//        let timeComponents = timeString.components(separatedBy: ":")
//        
//        if timeComponents.count == 3,
//           let hours = Int(timeComponents[0]),
//           let minutes = Int(timeComponents[1]),
//           let seconds = Int(timeComponents[2]) {
//            
//            var formattedTime = ""
//            
//            if hours > 0 {
//                formattedTime += "\(hours)시간 "
//            }
//            
//            if minutes > 0 {
//                formattedTime += "\(minutes)분 "
//            }
//            
//            if seconds >= 0 {
//                formattedTime += "\(seconds)초"
//            }
//            
//            return formattedTime
//        }
//        
//        return timeString
//    }
    
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
                                
                                Text("10040kg")
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
            .font(.caption())
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
