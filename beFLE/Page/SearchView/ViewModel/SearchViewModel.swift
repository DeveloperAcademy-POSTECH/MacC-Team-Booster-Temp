//
//  SearchViewModel.swift
//  beFLE
//
//  Created by 송재훈 on 11/18/23.
//

import SwiftUI

class SearchViewModel: ObservableObject {
    @Published var influencer = ResponseGetInfluencers(previews: [])
    
    func fetchInfluencer() {
        GeneralAPIManger.request(for: .GetInfluencers, type: [InfluencerPreview].self) { result in
            switch result {
            case .success(let influencers):
                self.influencer.previews = influencers
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
