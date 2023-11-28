//
//  CalenderView.swift
//  Mac_Health
//
//  Created by 정회승 on 11/22/23.
//

import SwiftUI
import FSCalendar

struct MockUpCalendarView: UIViewControllerRepresentable {
    @Binding var selectedDate: String
    @Binding var recordedDate: [String]
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let view = MockUpFSCalendarView()
        view.calendar.delegate = context.coordinator
        view.calendar.dataSource = context.coordinator
        self.selectedDate = Date().format(.yearMonthToday)
        return view
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) { }

    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self, selectedDate: $selectedDate, recordedDate: $recordedDate)
    }
    
    class Coordinator: NSObject, FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
        var parent: MockUpCalendarView
        @Binding var selectedDate: String
        @Binding var recordedDate: [String]
        
        init(parent: MockUpCalendarView, selectedDate: Binding<String>, recordedDate: Binding<[String]>) {
            self.parent = parent
            self._selectedDate = selectedDate
            self._recordedDate = recordedDate
        }
        
        func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
            selectedDate = date.format(.yearMonthToday)
        }
        
        func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
            if recordedDate.contains(date.format(.yearMonthToday)) {
                return 1
            }
            
            return 0
        }
        
        func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, eventDefaultColorsFor date: Date) -> [UIColor]? {
            if recordedDate.contains(date.format(.yearMonthToday)) {
                return [UIColor(Color.green_main)]
            }
            
            return nil
        }
    }
}
