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
    @Published var recordedDate = [String]()
    @Published var volume = 0
    
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
        var time = ""
        
        let split = time.split(separator: ":")
        let hour = Int(split[0])!
        let miniute = Int(split[1])!
        let second = Int(split[2])!
        
        return "\(hour)시간 \(miniute)분 \(second)초"
    }
}
