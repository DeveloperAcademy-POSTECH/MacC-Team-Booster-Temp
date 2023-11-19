//
//  FSCalendarView.swift
//  Mac_Health
//
//  Created by 최진용 on 11/5/23.
//
import SwiftUI
import UIKit
import FSCalendar


class FSCalendarView: UIViewController, FSCalendarDelegate, FSCalendarDataSource {
    
    var calendar = FSCalendar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        calendar.delegate = self
//        calendar.dataSource = self
        configUI()
    }
    
    
    func configUI() {
//        let calendar = FSCalendar()
        calendar.appearance.headerDateFormat = "M월 YYYY"
        calendar.appearance.headerMinimumDissolvedAlpha = 0.2
        calendar.scrollDirection = .horizontal
        calendar.allowsMultipleSelection = false
        calendar.clipsToBounds = true
//        calendar.today = UIColor(Color.green_main)
        calendar.locale = Locale(identifier: "ko_KR")
        calendar.calendarWeekdayView.weekdayLabels[0].text = "일"
        calendar.calendarWeekdayView.weekdayLabels[1].text = "월"
        calendar.calendarWeekdayView.weekdayLabels[2].text = "화"
        calendar.calendarWeekdayView.weekdayLabels[3].text = "수"
        calendar.calendarWeekdayView.weekdayLabels[4].text = "목"
        calendar.calendarWeekdayView.weekdayLabels[5].text = "금"
        calendar.calendarWeekdayView.weekdayLabels[6].text = "토"
        calendar.placeholderType = .none
        
        //MARK: - fontsetting
        calendar.appearance.titleFont = Font.calendarDate()
        calendar.appearance.headerTitleFont = Font.calendarTitle()
        calendar.appearance.weekdayFont = Font.calendarWeek()
        
        //MARK: - color setting
        calendar.appearance.titleDefaultColor = Color.calendar_white
        calendar.appearance.weekdayTextColor = Color.calendar_week
        calendar.appearance.headerTitleColor = Color.calendar_white
        calendar.appearance.titleDefaultColor = Color.calendar_white
        calendar.appearance.titleTodayColor = UIColor(Color.green_main)
        calendar.appearance.titleSelectionColor = UIColor(Color.gray_900)
        calendar.appearance.selectionColor = Color.calendar_white
        calendar.appearance.todayColor = UIColor(Color.gray_900)
        calendar.appearance.todaySelectionColor = UIColor(Color.green_main)
        calendar.appearance.eventDefaultColor = UIColor(Color.green_main)
        
        calendar.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(calendar)
        
        NSLayoutConstraint.activate([
            calendar.topAnchor.constraint(equalTo: view.topAnchor),
            calendar.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            calendar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            calendar.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    
}
