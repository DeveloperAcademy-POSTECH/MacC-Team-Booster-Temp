//
//  GeneralAPI.swift
//  Mac_Health
//
//  Created by 최진용 on 11/7/23.
//

import SwiftUI
import Moya

enum GeneralAPI {
    //TODO: 대체운동 추가하는 api 만들어야 합니다.
    //운동추가
    case PostExercise(routineId: Int, exerciseId: Int)
    //운동삭제
    case DeleteExercise(routineId: Int, exerciseId: Int)
    //운동세트수 조정
    case PatchSet(routineId: Int, exerciseId: Int, setId: Int, weight: Int, reps: Int)
    //운동세트 완료
    case PatchSetFinish(routineId: Int, exerciseId: Int, setId: Int)
    //특정 운동의 설명가져오기(디테일뷰)
    case GetSpecificExercise(routineId: Int, exerciseId: Int)
    //운동 완료
    case PatchRoutineFinish(routineId: Int)
    //해당 날짜 운동 가져오기
    case GetInfluencerRoutine(id: Int)
    //인플루언서 운동 전체 가져오기
    case GetInfluencerAllRoutine(id: Int)
}

extension GeneralAPI: TargetType {
    var baseURL: URL {
        let url = "https://befle.store/api-docs"
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
