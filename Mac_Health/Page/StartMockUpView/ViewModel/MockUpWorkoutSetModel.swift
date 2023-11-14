import SwiftUI

struct MockUpWorkoutSetModel: Identifiable {
    var id = UUID()
    
    var index: Int
    var kg: Int?
    var repetition: Int
    var isFinish: Bool
}
