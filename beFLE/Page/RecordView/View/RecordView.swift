//
//  RecordView.swift
//  beFLE
//
//  Created by 송재훈 on 10/26/23.
//

import SwiftUI

struct RecordView: View {
    @StateObject var vm = RecordViewModel()
    
    var body: some View {
        ZStack {
            Color.gray_900.ignoresSafeArea()
            
            VStack {
                NavigationTitle
                Calender
                RecordCell
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
    
    @ViewBuilder
    var Calender: some View {
        CalendarView(isViewDidLoad: $vm.isViewDidLoad, selectedDate: $vm.selectedDate, recordedDate: $vm.recordedDate)
            .frame(height: UIScreen.getHeight(335))
            .padding(.horizontal)
            .onChange(of: vm.selectedDate) { _ in
                vm.calculateTotalVolume()
            }
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
        }
        .padding(.bottom, 5)
    }
}


//struct RecordView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationStack {
//            RecordView()
//        }
//    }
//}
