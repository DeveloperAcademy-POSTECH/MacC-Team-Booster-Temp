//
//  APIBody.swift
//  Mac_Health
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

struct AlternativeExercise: Codable {
    var alternativeExerciseId: Int
    var name: String
    var exerciseImageUrl: String
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

// MARK: user-routine-controller
struct Exercise: Codable, Hashable {
    var id: Int
    var name: String
    var exerciseImageUrl: String
    var numberOfSet: Int
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
    var influencerProfileImageUrl: String
    var influencerId: Int
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
}

/// GetUsersRoutines
struct ResponseGetUsersRoutines: Codable {
    var routines: [InfluencerRoutine]
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
    var weight: Int
    var reps: Int
}

struct ResponsePatchUsersRoutinesExercisesSets: Codable {
    var reps: Int
    var weight: Int
    var isDone: Bool
}

/// PatchUsersRoutinesExercisesSetsFinish
struct ResponsePatchUsersRoutinesExercisesSetsFinish: Codable {
    var reps: Int
    var weight: Int
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

struct RecordedSet: Codable {
    var weight: Int?
    var reps: Int
}

struct RecordedExercise: Codable {
    var name: String
    var sets: [RecordedSet]
}

struct Records: Codable {
    var date: String
    var time: String
    var part: String
    var numberOfExercise: Int
    var burnedKCalories: Int
    var requiredMinutes: Int
    var exercises: [RecordedExercise]
}

/// GetUsersRecords
struct ResponseGetUsersRecords: Codable {
    var records: [Records]
}
//:

// MARK: test
/// GetRoutines
struct ResponseGetRoutines: Codable {
    var routines: [TestRoutine]
}

struct TestRoutine: Codable {
    var id: Int
    var numberOfExercise: Int
    var burnedKCalories: Int
    var requiredMinutes: Int
    var comment: String
    var introduce: String
    var profileImageUrl: String
}

/// GetInfluencersRoutines
struct ResponseGetInfluencersRoutines: Codable {
    var routines: [TestRoutine]
}
//:
