//
//  GeneralAPI.swift
//  Mac_Health
//
//  Created by 최진용 on 11/7/23.
//

import SwiftUI
import Moya

enum GeneralAPI {
    // MARK: user-exercise-controller
    /// 세트 수 하나 증가 - WorkoutOngoingView
    case PatchRoutinesExercisesSets(routineId: Int, exerciseId: Int)
    
    /// 세트 수 하나 감소 - WorkoutOngoingView
    case DeleteRoutinesExercisesSets(routineId: Int, exerciseId: Int)
    
    /// 루틴 정보 - WorkoutOngoingView
    case GetRoutinesExercises(routineId: Int, exerciseId: Int)
    //:
    
    // MARK: user-routine-controller
    /// 루틴 완료 - WorkoutOngoingView
    case PatchUsersRoutinesFinish(routineId: Int)
    
    /// 전체 인플루언서 루틴 정보 - TodayRoutineMultiView
    case GetUsersRoutines(date: String)
    
    /// 개인 인플루언서 루틴 정보 - TodayRoutineView
    case GetUsersRoutinesId(id: Int)
    
    /// 개인 인플루언서 전체 루틴 정보 - TotalRoutineView
    case GetUsersInfluencersRoutines(id: Int)
    //:
    
    // MARK: user-set-controller
    /// 세트 조정 - WorkoutOngoingView
    case PatchUsersRoutinesExercisesSets(routineId: Int, exerciseId: Int, SetId: Int)
    
    /// 세트 완료 - WorkoutOngoingView
    case PatchUsersRoutinesExercisesSetsFinish(routineId: Int, exerciseId: Int, SetId: Int)
    
    /// 세트 취소(안 씀) - WorkoutOngoingView
    case PatchUsersRoutinesExercisesSetsCancle(routineId: Int, exerciseId: Int, SetId: Int)
    //:
    
    // MARK: routine-controller
    /// 테스트 용 GetUsersRoutines
    case GetRoutines
    //:
    
    // MARK: routine-controller
    /// 테스트 용 GetUsersInfluencersRoutines
    case GetInfluencersRoutines(id: Int)
    //:
}

extension GeneralAPI: TargetType {
    var baseURL: URL {
        let url = "https://dev.befle.store"
        guard let baseURL = URL(string: url) else { fatalError() }
        return baseURL
    }
    
    var path: String {
        switch self {
        case .PostExercise(routineId: let routineId, exerciseId: let exerciseId):
            return "/routines/\(routineId)/exercises/\(exerciseId)/sets"
        case .DeleteExercise(routineId: let routineId, exerciseId: let exerciseId):
            return "/routines/\(routineId)/exercises/\(exerciseId)/sets"
        case .PatchSet(routineId: let routineId, exerciseId: let exerciseId, setId: let setId, weight: _, reps: _):
            return "/routines/\(routineId)/exercises/\(exerciseId)/sets/\(setId)"
        case .PatchSetFinish(routineId: let routineId, exerciseId: let exerciseId, setId: let setId):
            return "/routines/\(routineId)/exercises/\(exerciseId)/sets/\(setId)/finish"
        case .GetSpecificExercise(routineId: let routineId, exerciseId: let exerciseId):
            return "/routines/\(routineId)/exercises/\(exerciseId)"
        case .PatchRoutineFinish(routineId: let routineId):
            return "/users/routines/\(routineId)/finish"
        case .GetInfluencerRoutine(id: let id):
            return "/useres/routines/\(id)"
        case .GetInfluencerAllRoutine(id: let id):
            return "/users/influencers/\(id)/routines"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .PostExercise:
             return .post
        case .DeleteExercise:
            return .delete
        case .PatchSet:
            return .patch
        case .PatchSetFinish:
            return .patch
        case .GetSpecificExercise:
            return .get
        case .PatchRoutineFinish:
            return .patch
        case .GetInfluencerRoutine:
            return .get
        case .GetInfluencerAllRoutine:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .PostExercise(routineId: _, exerciseId: _):
            return .requestPlain
        case .DeleteExercise(routineId: _, exerciseId: _):
            return .requestPlain
        //TODO: 여기 부분 다시 처리해줘야함
        case .PatchSet(routineId: _, exerciseId: _, setId: _, weight: let weight, reps: let reps):
            return .requestJSONEncodable(RequestPatchSet(weight: weight, reps: reps))
        case .PatchSetFinish(routineId: _, exerciseId: _, setId: _):
            return .requestPlain
        case .GetSpecificExercise(routineId: _, exerciseId: _):
            return .requestPlain
        case .PatchRoutineFinish(routineId: _):
            return .requestPlain
        case .GetInfluencerRoutine(id: _):
            return .requestPlain
        case .GetInfluencerAllRoutine(id: _):
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
}
