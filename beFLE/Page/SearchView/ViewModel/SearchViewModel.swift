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
        GeneralAPIManger.request(for: .GetInfluencers, type: [InfluencerPreview].self) {
            switch $0 {
            case .success(let influencers):
                // TODO: 데이터 붙이고 나서 다시 확인
                self.influencer.previews = influencers
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
