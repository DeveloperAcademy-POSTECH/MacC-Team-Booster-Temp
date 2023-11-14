//
//  WorkoutOngoingViewModel.swift
//  Mac_Health
//
//  Created by 송재훈 on 2023/10/20.
//

import SwiftUI

class WorkoutOngoingViewModel: ObservableObject {
    let weight = 5
    let reps = 10
    
    @Published var routine = ResponseGetRoutinesExercises(name: "", part: "", exerciseId: 1, exerciseImageUrl: "", tip: "", videoUrls: [], sets: [], alternativeExercises: [], faceImageUrl: "")
    @Published var tabSelection = 0
    @Published var currentSetIndex = 0
    @Published var isPauseShow = false
    @Published var isAlternativeShow = false
    @Published var isAlternativeSheetShow = false
    
    // TODO: 세트 수정 시 세트 업데이트 로직 추가
    
    /// 운동 루틴 불러오는 함수
    func fetchExercise(routineId: Int, exerciseId: Int) {
        // TODO: 여러 번(= 8번) init 되는 거 수정
        GeneralAPIManger.request(for: .GetRoutinesExercises(routineId: routineId, exerciseId: exerciseId), type: ResponseGetRoutinesExercises.self) {
            switch $0 {
            case .success(let routine):
                self.routine = routine
                print(self.routine)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    /// 운동 세트 증가 함수
    func postIncreaseSet(routineId: Int, exerciseId: Int) {
        GeneralAPIManger.request(for: .PostRoutinesExercisesSets(routineId: routineId, exerciseId: exerciseId), type: [ExerciseSet].self) {
            switch $0 {
            case .success(let set):
                self.routine.sets = set
                print(self.routine)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    /// 운동 세트 감소 함수
    func deleteDecreaseSet(routineId: Int, exerciseId: Int) {
        GeneralAPIManger.request(for: .DeleteRoutinesExercisesSets(routineId: routineId, exerciseId: exerciseId), type: [ExerciseSet].self) {
            switch $0 {
            case .success(let set):
                self.routine.sets = set
                print(self.routine)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    /// 운동 세트 완료 함수
    func workoutSetController(routineId: Int, excerciseId: Int) {
        if currentSetIndex < routine.sets.count {
            patchSetFinish(routineId: routineId, exerciseId: excerciseId)
        }
        else {
            // TODO: 운동 완료
        }
    }
    
    /// 운동 세트 완료 함수 - isDone
    func patchSetFinish(routineId: Int, exerciseId: Int) {
        GeneralAPIManger.request(for: .PatchUsersRoutinesExercisesSetsFinish(routineId: routineId, exerciseId: exerciseId, setId: routine.sets[currentSetIndex].setId), type: ResponsePatchUsersRoutinesExercisesSetsFinish.self) {
            switch $0 {
            case .success(let set):
                self.routine.sets[self.currentSetIndex].weight = set.weight
                self.routine.sets[self.currentSetIndex].reps = set.reps
                self.routine.sets[self.currentSetIndex].isDone = set.isDone
                
                // TODO: 로직 추후 변경 - 인덱스가 총 카운트 넘어가는 거 검사
                if self.currentSetIndex < self.routine.sets.count - 1 {
                    self.currentSetIndex += 1
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    /// 운동 세트 수정 함수
    func patchSetModification(routineId: Int, exerciseId: Int, weight: Int, reps: Int) {
        GeneralAPIManger.request(for: .PatchUsersRoutinesExercisesSets(routineId: routineId, exerciseId: exerciseId, setId: 0, weight: weight, reps: reps), type: ResponsePatchUsersRoutinesExercisesSets.self) {
            switch $0 {
            case .success(let set):
                self.routine.sets[0].weight = set.weight
                self.routine.sets[0].reps = set.reps
                self.routine.sets[0].isDone = set.isDone
                print(self.routine)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
