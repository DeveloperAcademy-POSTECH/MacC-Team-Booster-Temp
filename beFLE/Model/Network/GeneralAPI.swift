//
//  GeneralAPI.swift
//  beFLE
//
//  Created by 최진용 on 11/7/23.
//

import SwiftUI
import Moya

enum GeneralAPI {
    // MARK: user-exercise-controller
    /// 세트 수 하나 증가
    case PostRoutinesExercisesSets(routineId: Int, exerciseId: Int)
    
    /// 세트 수 하나 감소
    case DeleteRoutinesExercisesSets(routineId: Int, exerciseId: Int)
    
    /// 운동 대체
    case PatchRoutinesExercisesAlternate(routineId: Int, exerciseId: Int, alternativeExerciseId: Int)
    
    /// 루틴 정보
    case GetRoutinesExercises(routineId: Int, exerciseId: Int)
    
    /// 운동 삭제
    case DeleteRoutinesExercises(routineId: Int, exerciseId: Int)
    //:
    
    // MARK: auth-controller
    /// 로그인
    case PostLogin(identifier: String, identityToken: String, authorizationCode: String)
    
    /// 토큰 재발급
    case GetReissue(refreshToken: String)
    //:
    
    // MARK: influencer-controller
    /// 인플루언서 구독 해제
    case PostInfluencersUnsubscribe(id: Int)
    /// 인플루언서 구독
    case PostInfluencersSubscribe(id: Int)
    /// 둘러보기 인플루언서들
    case GetInfluencers
    /// 둘러보기 상세
    case GetInfluencersId(id: Int)
    /// 테스트 용
    case GetInfluencersRoutines(id: Int)
    //:
    
    // MARK: user-controller
    // TODO: api 용도 갱신 필요
    case PostUsersMe(accessToken: String, refreshToken: String)
    
    /// 닉네임 변경
    case PatchUsers(name: String)
    //:
    
    // MARK: user-routine-controller
    /// 운동 시간 업데이트
    case PatchUsersRoutines(routineId: Int, time: String)
    
    /// 루틴 완료
    case PatchUsersRoutinesFinish(routineId: Int)
    
    /// 전체 인플루언서 루틴 정보
    case GetUsersRoutines(date: String)
    
    /// 개인 인플루언서 루틴 정보
    case GetUsersRoutinesId(id: Int)
    
    /// 개인 인플루언서 전체 루틴 정보
    case GetUsersInfluencersRoutines(id: Int)
    //:
    
    // MARK: user-set-controller
    /// 세트 조정
    case PatchUsersRoutinesExercisesSets(routineId: Int, exerciseId: Int, setId: Int, weight: Int, reps: Int)
    
    /// 세트 완료
    case PatchUsersRoutinesExercisesSetsFinish(routineId: Int, exerciseId: Int, setId: Int)
    
    /// 세트 취소(안 씀)
    case PatchUsersRoutinesExercisesSetsCancle(routineId: Int, exerciseId: Int, setId: Int)
    //:
    
    // MARK: user-record-controller
    /// 운동 기록
    case GetUsersRecords
    //:
    
    // MARK: routine-controller
    /// 테스트 용
    case GetRoutines
    //:
}

extension GeneralAPI: TargetType {
    var baseURL: URL {
        let url = "https://dev.befle.store"
        guard let baseURL = URL(string: url) else { fatalError() }
        return baseURL
    }
    
    var authorization: (String, String) {
        if let accessToken = UserDefaults.standard.string(forKey: "accessToken") {
            print(accessToken)
            return ("Authorization", "Bearer \(accessToken)")
        }
        return ("Authorization", "")
    }
    
    var path: String {
        switch self {
            // MARK: user-exercise-controller
        case .PostRoutinesExercisesSets(let routineId, let exerciseId):
            return "/users/routines/\(routineId)/exercises/\(exerciseId)/sets"
        case .DeleteRoutinesExercisesSets(let routineId, let exerciseId):
            return "/users/routines/\(routineId)/exercises/\(exerciseId)/sets"
        case .PatchRoutinesExercisesAlternate(let routineId, let exerciseId, let alternativeExerciseId):
            return "/users/routines/\(routineId)/exercises/\(exerciseId)/alternate/\(alternativeExerciseId)"
        case .GetRoutinesExercises(let routineId, let exerciseId):
            return "/users/routines/\(routineId)/exercises/\(exerciseId)"
        case .DeleteRoutinesExercises(let routineId, let exerciseId):
            return "/users/routines/\(routineId)/exercises/\(exerciseId)"
            //:
            // MARK: auth-controller
        case .PostLogin:
            return "/login"
        case .GetReissue(refreshToken: let refreshToken):
            return "/\(refreshToken)/reissue"
            //:
            // MARK: influencer-controller
        case .PostInfluencersUnsubscribe(id: let id):
            return "/influencers/\(id)/unsubscribe"
        case .PostInfluencersSubscribe(id: let id):
            return "/influencers/\(id)/subscribe"
        case .GetInfluencers:
            return "/influencers"
        case .GetInfluencersId(let id):
            return "/influencers/\(id)"
        case .GetInfluencersRoutines(let id):
            return "/influencers/\(id)/routines"
            //:
            // MARK: user-controller
        case .PostUsersMe:
            return "/users/me"
        case .PatchUsers:
            return "/users"
            //:
            // MARK: user-routine-controller
        case .PatchUsersRoutines(let routineId, _):
            return "/users/routines/\(routineId)"
        case .PatchUsersRoutinesFinish(let routineId):
            return "/users/routines/\(routineId)/finish"
        case .GetUsersRoutines:
            return "/users/routines"
        case .GetUsersRoutinesId(let id):
            return "/users/routines/\(id)"
        case .GetUsersInfluencersRoutines(let id):
            return "/users/influencers/\(id)/routines"
            //:
            // MARK: user-set-controller
        case .PatchUsersRoutinesExercisesSets(let routineId, let exerciseId, let setId, _, _):
            return "/users/routines/\(routineId)/exercises/\(exerciseId)/sets/\(setId)"
        case .PatchUsersRoutinesExercisesSetsFinish(let routineId, let exerciseId, let setId):
            return "/users/routines/\(routineId)/exercises/\(exerciseId)/sets/\(setId)/finish"
        case .PatchUsersRoutinesExercisesSetsCancle(let routineId, let exerciseId, let setId):
            return "/users/routines/\(routineId)/exercises/\(exerciseId)/sets/\(setId)/cancle"
            //:
            // MARK: user-record-controller
        case .GetUsersRecords:
            return "/users/records"
            //:
            // MARK: routine-controller
        case .GetRoutines:
            return "/routines"
            //:
        }
    }
    
    var method: Moya.Method {
        switch self {
            // MARK: user-exercise-controller
        case .PostRoutinesExercisesSets: return .post
        case .DeleteRoutinesExercisesSets: return .delete
        case .PatchRoutinesExercisesAlternate: return .patch
        case .GetRoutinesExercises: return .get
        case .DeleteRoutinesExercises: return .delete
            //:
            // MARK: auth-controller
        case .PostLogin: return .post
        case .GetReissue: return .get
            //:
            // MARK: influencer-controller
        case .PostInfluencersUnsubscribe: return .post
        case .PostInfluencersSubscribe: return .post
        case .GetInfluencers: return .get
        case .GetInfluencersId: return .get
        case .GetInfluencersRoutines: return .get
            //:
            // MARK: user-controller
        case .PostUsersMe: return .post
        case .PatchUsers: return .patch
            //:
            // MARK: user-routine-controller
        case .PatchUsersRoutines: return .patch
        case .PatchUsersRoutinesFinish: return .patch
        case .GetUsersRoutines: return .get
        case .GetUsersRoutinesId: return .get
        case .GetUsersInfluencersRoutines: return .get
            //:
            // MARK: user-set-controller
        case .PatchUsersRoutinesExercisesSets: return .patch
        case .PatchUsersRoutinesExercisesSetsFinish: return .patch
        case .PatchUsersRoutinesExercisesSetsCancle: return .patch
            //:
            // MARK: user-record-controller
        case .GetUsersRecords: return .get
            //:
            // MARK: routine-controller
        case .GetRoutines: return .get
            //:
        }
    }
    
    var task: Moya.Task {
        switch self {
            // MARK: user-exercise-controller
        case .PostRoutinesExercisesSets: return .requestPlain
        case .DeleteRoutinesExercisesSets: return .requestPlain
        case .PatchRoutinesExercisesAlternate: return .requestPlain
        case .GetRoutinesExercises: return .requestPlain
        case .DeleteRoutinesExercises: return .requestPlain
            //:
            // MARK: auth-controller
        case .PostLogin(identifier: let identifier, identityToken: let identityToken, authorizationCode: let authorizationCode): return .requestJSONEncodable(Credential(identifier: identifier, identityToken: identityToken, authorizationCode: authorizationCode))
        case .GetReissue: return .requestPlain
            //:
            // MARK: influencer-controller
        case .PostInfluencersUnsubscribe: return .requestPlain
        case .PostInfluencersSubscribe: return .requestPlain
        case .GetInfluencers: return .requestPlain
        case .GetInfluencersId: return .requestPlain
        case .GetInfluencersRoutines: return .requestPlain
            //:
            // MARK: user-controller
        case .PostUsersMe(accessToken: let accessToken, refreshToken: let refreshToken): return .requestParameters(parameters: ["accessToken": accessToken, "refreshToken": refreshToken], encoding: URLEncoding.queryString)
        case .PatchUsers(name: let name): return .requestParameters(parameters: ["name": name], encoding: URLEncoding.queryString)
            //:
            // MARK: user-routine-controller
        case .PatchUsersRoutines(_, time: let time): return .requestParameters(parameters: ["time": time], encoding: URLEncoding.queryString)
        case .PatchUsersRoutinesFinish: return .requestPlain
        case .GetUsersRoutines(date: let date): return .requestParameters(parameters: ["date": date], encoding: URLEncoding.queryString)
        case .GetUsersRoutinesId: return .requestPlain
        case .GetUsersInfluencersRoutines: return .requestPlain
            //:
            // MARK: user-set-controller
        case .PatchUsersRoutinesExercisesSets(_, _, _, weight: let weight, reps: let reps): return .requestJSONEncodable(RequestPatchUsersRoutinesExercisesSets(weight: weight, reps: reps))
        case .PatchUsersRoutinesExercisesSetsFinish: return .requestPlain
        case .PatchUsersRoutinesExercisesSetsCancle: return .requestPlain
            //:
            // MARK: user-record-controller
        case .GetUsersRecords: return .requestPlain
            //:
            // MARK: routine-controller
        case .GetRoutines: return .requestPlain
            //:
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .PostLogin, .GetReissue:
            return ["Content-Type": "application/json"]
        default:
            return ["Content-Type": "application/json", "\(authorization.0)": "\(authorization.1)"]
        }
    }
}
