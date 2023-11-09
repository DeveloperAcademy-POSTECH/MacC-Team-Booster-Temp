//
//  WorkoutOngoingVM.swift
//  Mac_Health
//
//  Created by 송재훈 on 2023/10/20.
//

import SwiftUI

class WorkoutOngoingVM: ObservableObject {
    let routineId = 1
    let exerciseId = 1
    let setId = 1
    let weight = 5
    let reps = 10
    
    @Published var routine = ResponseGetRoutinesExercises(name: "", part: "", exerciseId: 1, exerciseImageUrl: "", tip: "", videoUrl: "", sets: [], alternativeExercises: [])
    
    init() {
        self.fetchRoutine()
    }
    
    func fetchRoutine() {
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
    
    func postIncreaseSet() {
        GeneralAPIManger.request(for: .PostRoutinesExercisesSets(routineId: routineId, exerciseId: exerciseId), type: ResponsePostRoutinesExercisesSets.self) {
            switch $0 {
            case .success(let set):
                self.routine.sets = set.sets
                print(self.routine)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func deleteDecreaseSet() {
        GeneralAPIManger.request(for: .DeleteRoutinesExercisesSets(routineId: routineId, exerciseId: exerciseId), type: ResponseDeleteRoutinesExercisesSets.self) {
            switch $0 {
            case .success(let set):
                self.routine.sets = set.sets
                print(self.routine)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func patchSetFinish() {
        GeneralAPIManger.request(for: .PatchUsersRoutinesExercisesSetsFinish(routineId: routineId, exerciseId: exerciseId, setId: setId), type: ResponsePatchUsersRoutinesExercisesSetsFinish.self) {
            switch $0 {
            case .success(let set):
                self.routine.sets[self.setId].weight = set.weight
                self.routine.sets[self.setId].reps = set.reps
                self.routine.sets[self.setId].isDone = set.isDone
                print(self.routine)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func patchSetModification(weight: Int, reps: Int) {
        GeneralAPIManger.request(for: .PatchUsersRoutinesExercisesSets(routineId: routineId, exerciseId: exerciseId, setId: setId, weight: weight, reps: reps), type: ResponsePatchUsersRoutinesExercisesSets.self) {
            switch $0 {
            case .success(let set):
                self.routine.sets[self.setId].weight = set.weight
                self.routine.sets[self.setId].reps = set.reps
                self.routine.sets[self.setId].isDone = set.isDone
                print(self.routine)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    //    let workoutModel: WorkoutModel
    //    @Published var isRoutineSequenceShow = false
    //    @Published var isAlternativeWorkoutShow = false
    //    @Published var isWorkoutFinishAlertShow = false
    //    @Published var isWorkoutTipShow = false
    //    @Published var workoutSet: [WorkoutSetModel] = []
    //    @Published var currentSet = 1
    
    //    init() {
    //        workoutModel = WorkoutModel(workoutDate: "10월 5일(일)", influencerName: "정회승", workoutName: "클로즈 그립 랫 풀 다운", workoutSet: 4, workoutKgs: [0, 0, 0, 0], workoutReps: [10, 10, 15, 15], alternativeWorkout: ["클로즈 그립 랫 풀 다운", "클로즈 그립 랫 풀 다운", "클로즈 그립 랫 풀 다운"], relatedContentURL: [ "http://www.youtube.com"], workoutTip: "고정축이 흔들리면 정확한 타겟이 불가능하기 때문에 꼭! 랫 풀 다운 할 때는 발꿈치를 들어서 무릎 패드와 다리 사이에 공간이 없도록 단단한 지지대를 만들어 주는 것이 굉장히 중요합니다.")
    //
    //        for i in 0..<workoutModel.workoutSet {
    //            workoutSet.append(WorkoutSetModel(index: i + 1, kg: workoutModel.workoutKgs[i], repetition: workoutModel.workoutReps[i], isFinish: false))
    //        }
    //    }
    //
    //    func decreaseWorkoutSet() {
    //        if workoutSet.count > 1 {
    //            if workoutSet.count == currentSet {
    //                currentSet -= 1
    //            }
    //            workoutSet.removeLast()
    //        }
    //    }
    //
    //    func increaseWorkoutSet() {
    //        if workoutSet.count < 10 {
    //            workoutSet.append(WorkoutSetModel(index: workoutSet.count + 1, kg: 0, repetition: 0, isFinish: false))
    //        }
    //    }
    //
    //    func controlRepetition() {
    //        if workoutSet.count == currentSet {
    //            workoutSet[currentSet - 1].isFinish = true
    //            showWorkoutFinishAlert()
    //        }
    //        else {
    //            workoutSet[currentSet - 1].isFinish = true
    //            currentSet += 1
    //        }
    //    }
    //
    //    func showAlternativeWorkout() {
    //        isAlternativeWorkoutShow = true
    //    }
    //
    //    func dismissAlternativeWorkOut() {
    //        isAlternativeWorkoutShow = false
    //    }
    //
    //    func showWorkoutFinishAlert() {
    //        isWorkoutFinishAlertShow = true
    //    }
    //
    //    func showRoutineSequenceShow() {
    //        isRoutineSequenceShow = true
    //    }
    //
    //    func dismissRoutineSequenceShow() {
    //        isRoutineSequenceShow = false
    //    }
    //
    //    func showWorkoutTip() {
    //        isWorkoutTipShow = true
    //    }
    //
    //    func dismissWorkoutTip() {
    //        isWorkoutTipShow = false
    //    }
}
