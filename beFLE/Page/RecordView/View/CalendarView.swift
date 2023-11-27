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
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        selectedDate = dateFormatter.string(from: .now)
        
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
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            
            self.parent.selectedDate = dateFormatter.string(from: date)
        }
        
        func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            
            if self.parent.recordedDate.contains(dateFormatter.string(from: date)) {
                return 1
            }
            
            return 0
        }
        
        func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, eventDefaultColorsFor date: Date) -> [UIColor]? {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            
            if self.parent.recordedDate.contains(dateFormatter.string(from: date)) {
                return [UIColor(Color.green_main)]
            }
            
            return nil
        }
    }
}
