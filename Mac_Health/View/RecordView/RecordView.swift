//
//  RecordView.swift
//  Mac_Health
//
//  Created by 송재훈 on 10/26/23.
//

import SwiftUI

struct RecordView: View {
    var body: some View {
        ZStack {
            //            Color.gray_900.ignoresSafeArea()
            
            VStack {
                title
                calender
                recordCard
            }
        }
    }
    
    @ViewBuilder
    var title: some View {
        HStack {
            Text("기록")
                .font(.title2())
                .foregroundColor(.label_900)
            Spacer()
        }
        .padding(.horizontal)
    }
    
    @ViewBuilder
    var calender: some View {
        VStack {
            HStack {
                Button {
                    //
                } label: {
                    Text("6월 2023")
                        .font(.title2())
                        .foregroundColor(.label_900)
                    Image(systemName: "chevron.right")
                        .font(.title2())
                        .foregroundColor(.green_main)
                }
                
                Spacer()
                
                Button {
                    //
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.title2())
                        .foregroundColor(.green_main)
                }
                
                Button {
                    //
                } label: {
                    Image(systemName: "chevron.right")
                        .font(.title2())
                        .foregroundColor(.green_main)
                }
            }
            .padding(.horizontal)
            
//            CalendarView()
        }
    }
    
    @ViewBuilder
    var recordCard: some View {
        RoundedRectangle(cornerRadius: 8)
            .foregroundColor(.fill_1)
            .frame(width: UIScreen.getWidth(350), height: UIScreen.getHeight(72))
            .overlay {
                VStack {
                    HStack {
                        Ellipse()
                            .frame(width: UIScreen.getWidth(8), height: UIScreen.getHeight(8))
                            .foregroundColor(.yellow_main)
                        Text("박재훈")
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

struct CalendarView: UIViewRepresentable {
    var calendarView: UICalendarView = {
        var calendarView = UICalendarView()
        calendarView.calendar = Calendar(identifier: .gregorian)
        calendarView.locale = Locale(identifier: "ko-KR")
        calendarView.timeZone = TimeZone(identifier: "ko-KR")
        calendarView.wantsDateDecorations = true
        calendarView.backgroundColor = .clear
        calendarView.tintColor = UIColor(Color.green_main)
        calendarView.fontDesign = UIFontDescriptor.SystemDesign.default
        
        return calendarView
    }()
    
    func makeUIView(context: Context) -> some UICalendarView {
        calendarView.delegate = context.coordinator
//        let dateSelection = UICalendarSelectionMultiDate(delegate: context.coordinator)
//        let selectedDates: [DateComponents] = [DateComponents(calendar: Calendar(identifier: .gregorian), year:2023, month: 10, day: 8),
//                                                DateComponents(calendar: Calendar(identifier: .gregorian), year:2023, month: 10, day: 9),
//                                                DateComponents(calendar: Calendar(identifier: .gregorian), year:2023, month: 10, day: 10)]
//        dateSelection.setSelectedDates(selectedDates, animated: false)
//        calendarView.selectionBehavior = dateSelection
        
        return calendarView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        //
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }
    
    class Coordinator: NSObject, UICalendarViewDelegate, UICalendarSelectionSingleDateDelegate {
        func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
            //
        }
    }
}

struct RecordView_Previews: PreviewProvider {
    static var previews: some View {
        RecordView()
    }
}
