//
//  CalenderView.swift
//  Mac_Health
//
//  Created by 최진용 on 11/1/23.
//

import SwiftUI
import FSCalendar


struct CalendarView: UIViewControllerRepresentable {
    @Binding var selectedDate: String
    @Binding var recordedDate: [String]
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let view = FSCalendarView()
        view.calendar.delegate = context.coordinator
        view.calendar.dataSource = context.coordinator
        return view
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) { }

    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self, selectedDate: $selectedDate, recordedDate: $recordedDate)
    }
    
    class Coordinator: NSObject, FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
        var parent: CalendarView
        @Binding var selectedDate: String
        @Binding var recordedDate: [String]
        
        init(parent: CalendarView, selectedDate: Binding<String>, recordedDate: Binding<[String]>) {
            self.parent = parent
            self._selectedDate = selectedDate
            self._recordedDate = recordedDate
        }
        
        func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            
            selectedDate = dateFormatter.string(from: date)
        }
        
        func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            
            if recordedDate.contains(dateFormatter.string(from: date)) {
                return 1
            }
            
            return 0
        }
        
        func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, eventDefaultColorsFor date: Date) -> [UIColor]? {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
              
            // TODO: 선택된 날짜 색 수정
            if recordedDate.contains(dateFormatter.string(from: date)) {
                return [UIColor(Color.green_main)]
            }
            
            return nil
        }
    }
}
//
//struct cordView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationStack{
//            RecordView()
//        }
//    }
//}
