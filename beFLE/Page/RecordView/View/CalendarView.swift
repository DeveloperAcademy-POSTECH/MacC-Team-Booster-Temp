//
//  CalenderView.swift
//  beFLE
//
//  Created by 최진용 on 11/1/23.
//

import SwiftUI
import FSCalendar

struct CalendarView: UIViewControllerRepresentable {
    @Binding var isViewDidLoad: Bool
    @Binding var selectedDate: String
    @Binding var recordedDate: [String]
    @State var view = FSCalendarView()
    
    func makeUIViewController(context: Context) -> some UIViewController {
        view.calendar.delegate = context.coordinator
        view.calendar.dataSource = context.coordinator
        
        selectedDate = Date().formatNow(.yearMonthToday)
        
        return view
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        if isViewDidLoad {
            view.viewDidLoad()
            isViewDidLoad = false
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    class Coordinator: NSObject, FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
        var parent: CalendarView
        
        init(parent: CalendarView) {
            self.parent = parent
        }
        
        func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
            self.parent.selectedDate = date.formatNow(.yearMonthToday)
        }
        
        func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
            if self.parent.recordedDate.contains(date.formatNow(.yearMonthToday)) {
                return 1
            }
            
            return 0
        }
        
        func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, eventDefaultColorsFor date: Date) -> [UIColor]? {
            if self.parent.recordedDate.contains(date.formatNow(.yearMonthToday)) {
                return [UIColor(Color.green_main)]
            }
            
            return nil
        }
    }
}
