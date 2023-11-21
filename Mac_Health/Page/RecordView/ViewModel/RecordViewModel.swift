//
//  RecordViewModel.swift
//  Mac_Health
//
//  Created by 송재훈 on 11/9/23.
//

import SwiftUI

class RecordViewModel: ObservableObject {
    @Published var records = ResponseGetUsersRecords(records: [])
    @Published var selectedDate = ""
    @Published var volume = 0
    @Published var recordedDate = [String]()
    
    init() {
        fetchRecords()
    }
    
    // TODO: 다중 데이터로 확인해보기
    func fetchRecords() {
        GeneralAPIManger.request(for: .GetUsersRecords, type: [Records].self) {
            switch $0 {
            case .success(let records):
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                self.selectedDate = dateFormatter.string(from: .now)
                self.records.records = records
                self.fetchRecodedDate()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func calculateTotalVolume() {
        let selectedRecords = records.records.filter { $0.date == selectedDate }

        var totalVolume = 0

        for record in selectedRecords {
            for exercise in record.exercises {
                for set in exercise.sets {
                    if let weight = set.weight {
                        totalVolume += weight * set.reps
                    }
                }
            }
        }

        volume = totalVolume
    }
    
    func fetchRecodedDate() {
        recordedDate = records.records.map {
            $0.date
        }
    }
    
    func formatTime(_ timeString: String) -> String {
        let timeComponents = timeString.components(separatedBy: ":")
        
        if timeComponents.count == 3,
           let hours = Int(timeComponents[0]),
           let minutes = Int(timeComponents[1]),
           let seconds = Int(timeComponents[2]) {
            
            var formattedTime = ""
            
            if hours > 0 {
                formattedTime += "\(hours)시간 "
            }
            
            if minutes > 0 {
                formattedTime += "\(minutes)분 "
            }
            
            if seconds >= 0 {
                formattedTime += "\(seconds)초"
            }
            
            return formattedTime
        }
        
        return timeString
    }
}
