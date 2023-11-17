//
//  SubscribeViewModel.swift
//  Mac_Health
//
//  Created by 송재훈 on 11/18/23.
//

import SwiftUI

class SubscribeViewModel: ObservableObject {
    @Published var influencer = ResponseGetInfluencersId(influencerName: "", routineName: "", title: "", awards: "", introduce: "", bodySpec: BodySpec(height: 0, weight: 0), bigThree: BigThree(squat: 0, benchPress: 0, deadLift: 0), routine: PreviewExercise(date: "", part: "", exercises: []), isSubscription: false)
    //    @State var seeMore:Bool = false
    @Published var showTab = false
    @Published var scrollOffset: CGFloat = 0.00
    @Published var subscribingSheet = false
    @Published var loggedIn = true
    
    func fetchInfluencer(influencerId: Int) {
        GeneralAPIManger.request(for: .GetInfluencersId(id: influencerId), type: ResponseGetInfluencersId.self) {
            switch $0 {
            case .success(let influencer):
                self.influencer = influencer
                print(self.influencer)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
