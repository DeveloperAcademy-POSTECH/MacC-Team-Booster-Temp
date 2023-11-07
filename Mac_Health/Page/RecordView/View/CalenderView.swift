//
//  CalenderView.swift
//  Mac_Health
//
//  Created by 최진용 on 11/1/23.
//

import SwiftUI
import FSCalendar


struct CalendarView: UIViewControllerRepresentable {

    @Binding var testState: String
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let view = FSCalendarView()
        view.calendar.delegate = context.coordinator
        view.calendar.dataSource = context.coordinator
        return view
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self, testState: _testState)
    }
    
    class Coordinator: NSObject, FSCalendarDelegate, FSCalendarDataSource {
        var parent: CalendarView
        @Binding var testState: String
        
        init(parent: CalendarView, testState: Binding<String>) {
            self.parent = parent
            self._testState = testState
        }
        
        func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            print(dateFormatter.string(from: date))
        }
        
    }
}

struct cordView_Previews: PreviewProvider {
    static var previews: some View {
        RecordView()
    }
}
