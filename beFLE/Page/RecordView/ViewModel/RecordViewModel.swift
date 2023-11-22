//
//  RecordViewModel.swift
//  beFLE
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
                self.caculateVolume()
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
    
    func caculateVolume() {
        for record in records.records {
            self.volume += record.exercises.reduce(0) {
                $0 + $1.sets.reduce(0) {
                    $0 + ($1.weight ?? 0) * $1.reps
                }
            }
        }
    }
    
    func timeFormat(from time: String) -> String {
        let split = time.split(separator: ":")
        let hour = Int(split[0])!
        let miniute = Int(split[1])!
        let second = Int(split[2])!
        
        return "\(hour)시간 \(miniute)분 \(second)초"
    }
}
