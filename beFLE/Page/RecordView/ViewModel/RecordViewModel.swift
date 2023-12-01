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
    @Published var isViewDidLoad = false
    
    init() {
        fetchRecords()
    }
    
    func fetchRecords() {
        GeneralAPIManger.request(for: .GetUsersRecords, type: [Records].self) { result in
            switch result {
            case .success(let records):
                self.selectedDate = Date().format(.yearMonthToday)
                self.records.records = records
                self.fetchRecodedDate()
                self.isViewDidLoad = true
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func calculateTotalVolume() {
        let selectedRecords = records.records.filter { $0.finishDate == selectedDate }
        
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
        recordedDate = records.records.map { record in
            record.finishDate
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
