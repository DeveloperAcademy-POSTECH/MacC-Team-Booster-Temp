//
//  MockUpRecordView.swift
//  beFLE
//
//  Created by 정회승 on 11/22/23.
//

import SwiftUI

struct MockUpRecordView: View {
    @StateObject var vm = RecordViewModel()
    
    var body: some View {
        ZStack {
            Color.gray_900.ignoresSafeArea()
            
            VStack {
                NavigationTitle
                Calender
                RecordCell
                beforeLoginText
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
        MockUpCalendarView(selectedDate: $vm.selectedDate, recordedDate: $vm.recordedDate)
            .frame(height: UIScreen.getHeight(335))
            .padding(.horizontal)
    }
    
    var RecordCell: some View {
        ForEach(vm.records.records.filter { $0.finishDate == vm.selectedDate }, id: \.self) { record in
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
                                Text("\(vm.timeFormat(from: record.time))")
                                    .font(.headline2())
                                    .foregroundColor(.label_900)
                            }
                            Spacer()
                            HStack {
                                Text(record.part)
                                    .font(.body2())
                                    .foregroundColor(.label_500)
                                Spacer()
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
