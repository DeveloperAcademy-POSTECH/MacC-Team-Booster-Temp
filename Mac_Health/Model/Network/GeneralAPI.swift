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
    
    /// 운동 대체 - AlternativeWorkoutSheet
    case PatchRoutinesExercisesAlternate(routineId: Int, exerciseId: Int, alternativeExerciseId: Int)
    
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
    case PatchUsersRoutinesExercisesSets(routineId: Int, exerciseId: Int, setId: Int)
    
    /// 세트 완료 - WorkoutOngoingView
    case PatchUsersRoutinesExercisesSetsFinish(routineId: Int, exerciseId: Int, setId: Int)
    
    /// 세트 취소(안 씀) - WorkoutOngoingView
    case PatchUsersRoutinesExercisesSetsCancle(routineId: Int, exerciseId: Int, setId: Int)
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
        case .PatchRoutinesExercisesSets(let routineId, let exerciseId):
            return "/routines/\(routineId)/exercises/\(exerciseId)/sets"
        case .DeleteRoutinesExercisesSets(let routineId, let exerciseId):
            return "/routines/\(routineId)/exercises/\(exerciseId)/sets"
        case .PatchRoutinesExercisesAlternate(let routineId, let exerciseId, let alternativeExerciseId):
            return "/users/routines/\(routineId)/exercises/\(exerciseId)/alternate/\(alternativeExerciseId)"
        case .GetRoutinesExercises(let routineId, let exerciseId):
            return "/routines/\(routineId)/exercises/\(exerciseId)"
        case .PatchUsersRoutinesFinish(let routineId):
            return "/users/routines/\(routineId)/finish"
        case .GetUsersRoutines(let date):
            return "/users/routines/?date=\(date)"
        case .GetUsersRoutinesId(let id):
            return "/users/routines/\(id)"
        case .GetUsersInfluencersRoutines(let id):
            return "/users/influencers/\(id)/routines"
        case .PatchUsersRoutinesExercisesSets(let routineId, let exerciseId, let setId):
            return "/users/routines/\(routineId)/exercises/\(exerciseId)/sets/\(setId)"
        case .PatchUsersRoutinesExercisesSetsFinish(let routineId, let exerciseId, let setId):
            return "/users/routines/\(routineId)/exercises/\(exerciseId)/sets/\(setId)/finish"
        case .PatchUsersRoutinesExercisesSetsCancle(let routineId, let exerciseId, let setId):
            return "/users/routines/\(routineId)/exercises/\(exerciseId)/sets/\(setId)/cancle"
        case .GetRoutines:
            return "/routines"
        case .GetInfluencersRoutines(let id):
            return "/influencers/\(id)/routines"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .PatchRoutinesExercisesSets: return .patch
        case .DeleteRoutinesExercisesSets: return .delete
        case .PatchRoutinesExercisesAlternate: return .patch
        case .GetRoutinesExercises: return .get
        case .PatchUsersRoutinesFinish: return .patch
        case .GetUsersRoutines: return .get
        case .GetUsersRoutinesId: return .get
        case .GetUsersInfluencersRoutines: return .get
        case .PatchUsersRoutinesExercisesSets: return .patch
        case .PatchUsersRoutinesExercisesSetsFinish: return .patch
        case .PatchUsersRoutinesExercisesSetsCancle: return .patch
        case .GetRoutines: return .get
        case .GetInfluencersRoutines: return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .PatchRoutinesExercisesSets: return .requestPlain
        case .DeleteRoutinesExercisesSets: return .requestPlain
        case .PatchRoutinesExercisesAlternate: return .requestPlain
        case .GetRoutinesExercises: return .requestPlain
        case .PatchUsersRoutinesFinish: return .requestPlain
        case .GetUsersRoutines: return .requestPlain
        case .GetUsersRoutinesId: return .requestPlain
        case .GetUsersInfluencersRoutines: return .requestPlain
        case .PatchUsersRoutinesExercisesSets: return .requestPlain
        case .PatchUsersRoutinesExercisesSetsFinish: return .requestPlain
        case .PatchUsersRoutinesExercisesSetsCancle: return .requestPlain
        case .GetRoutines: return .requestPlain
        case .GetInfluencersRoutines: return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
}
