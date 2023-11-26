//
//  APIBody.swift
//  beFLE
//
//  Created by 송재훈 on 11/8/23.
//

import SwiftUI

// MARK: user-exercise-controller
struct ExerciseSet: Codable, Hashable {
    var setId: Int
    var weight: Int?
    var reps: Int
    var isDone: Bool
}

struct AlternativeExercise: Codable, Hashable {
    var alternativeExerciseId: Int
    var name: String
    var exerciseImageUrl: String?
}

/// PostRoutinesExercisesSets
struct ResponsePostRoutinesExercisesSets: Codable {
    var sets: [ExerciseSet]
}

/// DeleteRoutinesExercisesSets
struct ResponseDeleteRoutinesExercisesSets: Codable {
    var sets: [ExerciseSet]
}

/// PatchRoutinesExercisesAlternate
struct ResponsePatchRoutinesExercisesAlternate: Codable {
    var name: String
    var part: String
    var exerciseId: Int
    var exerciseImageUrl: String
    var tip: String
    var videoUrls: [String]
    var sets: [ExerciseSet]
    var alternativeExercises: [AlternativeExercise]
    var faceImageUrl: String
}

/// GetRoutinesExercises
struct ResponseGetRoutinesExercises: Codable {
    var name: String
    var part: String
    var exerciseId: Int
    var exerciseImageUrl: String
    var tip: String
    var videoUrls: [String]
    var sets: [ExerciseSet]
    var alternativeExercises: [AlternativeExercise]
    var faceImageUrl: String
}
//:

// MARK: auth-controller
struct Credential: Codable {
    var identifier: String
    var identityToken: String
    var authorizationCode: String
}

struct Token: Codable {
    var accessToken: String
    var refreshToken: String
}

/// PostLogin
struct RequestPostLogin: Codable {
    var credential: Credential
}

struct ResponsePostLogin: Codable {
    var token: Token
}

/// GetReissue
struct ResponseGetReissue: Codable {
    var token: Token
}
//:

// MARK: user-controller
struct Nickname: Codable {
    var name: String
}

struct RequsetPatchUsers: Codable {
    var name: Nickname
}

struct ResponsePatchUsers: Codable {
    var name: Nickname
}
//:

// MARK: user-routine-controller
struct Exercise: Codable, Hashable {
    var id: Int
    var name: String
    var exerciseImageUrl: String
    var numberOfSet: Int
    var recommendReps: String
    var isDone: Bool
}

struct InfluencerRoutine: Codable, Hashable {
    var routineId: Int
    var part: String
    var date: String
    var numberOfExercise: Int
    var burnedKCalories: Int
    var requiredMinutes: Int
    var comment: String
    var name: String
    var routineName: String
    var singleRoutineImageUrl: String
    var multiRoutineImageUrl: String
    var influencerId: Int
    var isDone: Bool
}

struct Routine: Codable, Hashable {
    var part: String
    var date: String
    var isDone: Bool
    var routineId: Int
}

/// PatcheUsersRoutines
struct RequestPatchUsersRoutines: Codable {
    var time: String
}

/// PatchUsersRoutinesFinish
struct ResponsePatchUsersRoutinesFinish: Codable {
    var isDone: Bool
    var routineCompleteImageUrl: String
}

/// GetUsersRoutines
struct ResponseGetUsersRoutines: Codable {
    var routine: [InfluencerRoutine]
}

/// GetUsersRoutinesId
struct ResponseGetUsersRoutinesId: Codable {
    var part: String
    var numberOfExercise: Int
    var requiredMinutes: Int
    var burnedKCalories: Int
    var exercises: [Exercise]
}

/// GetUsersInfluencersRoutines
struct ResponseGetUsersInfluencersRoutines: Codable {
    var routines: [Routine]
}
//:

// MARK: user-set-conteroller
/// PatchUsersRoutinesExercisesSets
struct RequestPatchUsersRoutinesExercisesSets: Codable {
    var weight: Int? = nil
    var reps: Int
}

struct ResponsePatchUsersRoutinesExercisesSets: Codable {
    var reps: Int
    var weight: Int?
    var isDone: Bool
}

/// PatchUsersRoutinesExercisesSetsFinish
struct ResponsePatchUsersRoutinesExercisesSetsFinish: Codable {
    var reps: Int
    var weight: Int?
    var isDone: Bool
}

/// PatchUsersRoutinesExercisesSetsCancle
struct ResponsePatchUsersRoutinesExercisesSetsCancle: Codable {
    var reps: Int
    var weight: Int
    var isDone: Bool
}
//:

// MARK: user-record-controller
struct RecordedTime: Codable {
    var hour: Int
    var minute: Int
    var second: Int
    var nano: Int
}

struct RecordedSet: Codable, Hashable {
    var weight: Int?
    var reps: Int
}

struct RecordedExercise: Codable, Hashable {
    var name: String
    var sets: [RecordedSet]
}

struct Records: Codable, Hashable {
    var finishDate: String
    var uploadDate: String
    var time: String
    var part: String
    var numberOfExercise: Int
    var burnedKCalories: Int
    var requiredMinutes: Int
    var exercises: [RecordedExercise]
    var influencerName: String
}

/// GetUsersRecords
struct ResponseGetUsersRecords: Codable {
    var records: [Records]
}
//:

// MARK: test
struct BodySpec: Codable, Hashable {
    var height: Int
    var weight: Int
}

struct BigThree: Codable, Hashable {
    var squat: Int
    var benchPress: Int
    var deadLift: Int
}

struct InfluencerExercise: Codable, Hashable {
    var name: String
    var exerciseImageUrl: String
    var numberOfSet: Int
    var recommendReps: String
    var tip: String
}

struct PreviewExercise: Codable, Hashable {
    var date: String
    var part: String
    var exercises: [InfluencerExercise]
}

struct TestRoutine: Codable {
    var id: Int
    var numberOfExercise: Int
    var burnedKCalories: Int
    var requiredMinutes: Int
    var comment: String
    var introduce: String
    var profileImageUrl: String
    var awards: String
    var bodySpec: BodySpec
    var bigThree: BigThree
}

/// GetRoutines
struct ResponseGetRoutines: Codable {
    var routines: [TestRoutine]
}
//:

// MARK: influencer-controller
struct InfluencerPreview: Codable, Hashable {
    var influencerId: Int
    var singleExploreImageUrl: String
    var multiExploreImageUrl: String
    var name: String
    var routineName: String
    var title: String
}

/// PostInfluencersSubscribe
struct PostInfluencersSubscribe: Codable, Hashable {
    var isSubscription: Bool
}

/// GetInfluencers
struct ResponseGetInfluencers: Codable, Hashable {
    var previews: [InfluencerPreview]
}

/// GetInfluencersId
struct ResponseGetInfluencersId: Codable {
    var influencerName: String
    var routineName: String
    var title: String
    var awards: String
    var carouselImageUrls: [String]
    var faceImageUrl: String
    var introduce: String
    var bodySpec: BodySpec
    var bigThree: BigThree
    var routine: PreviewExercise
    var isSubscription: Bool
}

/// GetInfluencersRoutines
struct ResponseGetInfluencersRoutines: Codable {
    var routines: [TestRoutine]
}
//:
