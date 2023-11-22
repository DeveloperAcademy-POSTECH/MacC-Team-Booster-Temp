//
//  RecordingFinishViewModel.swift
//  Mac_Health
//
//  Created by 송재훈 on 11/21/23.
//

import SwiftUI

class RecordingFinishViewModel: ObservableObject {
    @Published var volume = 0
    
    
    func caculateWorkoutVolume(routineId: Int) {
        GeneralAPIManger.request(for: .GetUsersRoutinesId(id: routineId), type: ResponseGetUsersRoutinesId.self) {
            switch $0 {
            case .success(let routine):
                _ = routine.exercises.map { exercise in
                    self.fetchWorkout(routineId: routineId, exerciseId: exercise.id) {
                        self.volume += $0
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
                
            }
        }
    }
    
    func fetchWorkout(routineId: Int, exerciseId: Int, completion: @escaping ((Int) -> ()) ) {
        GeneralAPIManger.request(for: .GetRoutinesExercises(routineId: routineId, exerciseId: exerciseId), type: ResponseGetRoutinesExercises.self) {
            switch $0 {
            case .success(let workout):
                var volume = 0
                _ = workout.sets.map {
                    if let weight = $0.weight {
                        volume += $0.reps * weight
                    }
                }
                completion(volume)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    func nowDateFormatter() -> String {
        let nowDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier:  "ko")
        
        dateFormatter.dateFormat = "MM월 dd일"
        let date_String = dateFormatter.string(from: nowDate)
        return date_String
    }
}
