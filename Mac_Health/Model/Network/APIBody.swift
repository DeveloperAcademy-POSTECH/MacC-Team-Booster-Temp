//
//  APIBody.swift
//  Mac_Health
//
//  Created by 송재훈 on 11/8/23.
//

import SwiftUI

// MARK: PatchRoutinesExercisesSets
struct ResponsePatchRoutinesExercisesSets: Codable {
    var sets: [ExerciseSet]
}

struct ExerciseSet: Codable {
    var setId: Int
    var weight: Int?
    var reps: Int
    var isDone: Bool
}
//:

// MARK: DeleteRoutinesExercisesSets
struct ResponseDeleteRoutinesExercisesSets: Codable {
    var sets: [ExerciseSet]
}
//:

// MARK: GetRoutinesExercises
struct ResponseGetRoutinesExercises: Codable {
    var name: String
    var part: String
    var exerciseId: Int
    var exerciseImageUrl: String
    var tip: String
    var videoUrl: String
    var sets: [ExerciseSet]
    var alternativeExercises: [AlternativeExercise]
}

struct AlternativeExercise: Codable {
    var alternativeExerciseId: Int
    var name: String
    var exerciseImageUrl: String
}
//:

// MARK: PatchUsersRoutinesFinish
struct ResponsePatchUsersRoutinesFinish: Codable {
    var isDone: Bool
}
//:


// MARK: GetUsersRoutines
struct ResponseGetUsersRoutines: Codable {
    var routines: [InfluencerRoutine]
}

struct InfluencerRoutine: Codable {
    var routineId: Int
    var part: String
    var numberOfExercise: Int
    var burnedKCalories: Int
    var requiredMinutes: Int
    var comment: String
    var name: String
    var routineName: String
    var influencerProfileImageUrl: String
    var influencerId: Int
}
//:

// MARK: GetUsersRoutinesId
struct ResponseGetUsersRoutinesId: Codable {
    var part: String
    var numberOfExercise: Int
    var requiredMinutes: Int
    var burnedKCalories: Int
    var exercises: [Exercise]
}

struct Exercise: Codable {
    var id: Int
    var name: String
    var exerciseImageUrl: String
    var numberOfSet: Int
}
//:

// MARK: GetUsersInfluencersRoutines
struct ResponseGetUsersInfluencersRoutines: Codable {
    var routines: [Routine]
}

struct Routine: Codable {
    var part: String
    var date: String
    var isDone: Bool
    var routineId: Int
}
//:

// MARK: PatchUsersRoutinesExercisesSets
struct RequestPatchUsersRoutinesExercisesSets: Codable {
    var weight: Int
    var reps: Int
}

struct ResponsePatchUsersRoutinesExercisesSets: Codable {
    var reps: Int
    var weight: Int
    var isDone: Bool
}
//:

// MARK: PatchUsersRoutinesExercisesSetsFinish
struct ResponsePatchUsersRoutinesExercisesSetsFinish: Codable {
    var reps: Int
    var weight: Int
    var isDone: Bool
}
//:

// MARK: PatchUsersRoutinesExercisesSetsCancle
struct ResponsePatchUsersRoutinesExercisesSetsCancle: Codable {
    var reps: Int
    var weight: Int
    var isDone: Bool
}

// MARK: GetRoutines
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
//:

// MARK: GetInfluencersRoutines
struct ResponseGetInfluencersRoutines: Codable {
    var routines: [TestRoutine]
}
//:
