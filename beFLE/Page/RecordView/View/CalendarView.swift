//
//  CalenderView.swift
//  beFLE
//
//  Created by 최진용 on 11/1/23.
//

import SwiftUI
import FSCalendar

//TODO: 처음에 화면에 들어왔을때 점 안찍힘 - YONG
struct CalendarView: UIViewControllerRepresentable {
    @Binding var selectedDate: String
    @Binding var recordedDate: [String]
    @State var view = FSCalendarView()
    
    let dateFormatter = DateFormatter()
    
    func makeUIViewController(context: Context) -> some UIViewController {
        view.calendar.delegate = context.coordinator
        view.calendar.dataSource = context.coordinator
        dateFormatter.dateFormat = "yyyy-MM-dd"
        selectedDate = dateFormatter.string(from: .now)
        
        return view
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        if !recordedDate.isEmpty {
            view.viewDidLoad()
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
            self.parent.selectedDate = self.parent.dateFormatter.string(from: date)
        }
        
        func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
            if self.parent.recordedDate.contains(self.parent.dateFormatter.string(from: date)) {
                return 1
            }
            
            return 0
        }
        
        func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, eventDefaultColorsFor date: Date) -> [UIColor]? {
            if self.parent.recordedDate.contains(self.parent.dateFormatter.string(from: date)) {
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
