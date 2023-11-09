//
//  RecordViewModel.swift
//  Mac_Health
//
//  Created by 송재훈 on 11/9/23.
//

import SwiftUI

class RecordViewModel: ObservableObject {
    @Published var records = ResponseGetUsersRecords(records: [])
    
    init() {
        fetchRecords()
    }
    
    func fetchRecords() {
        GeneralAPIManger.request(for: .GetUsersRecords, type: [Records].self) {
            switch $0 {
            case .success(let records):
                print(records)
                self.records.records = records
                print(self.records)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
