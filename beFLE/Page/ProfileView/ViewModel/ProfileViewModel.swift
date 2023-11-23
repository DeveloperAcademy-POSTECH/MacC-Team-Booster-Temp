//
//  ProfileViewModel.swift
//  beFLE
//
//  Created by 정회승 on 11/16/23.
//

import SwiftUI

class ProfileViewModel: ObservableObject {
    @Published var nickname = ""
    
    @Published var notiToggle: Bool = true
    @Published var versionState: String = "1.0.0"
    
    @Published var email = "king81597@naver.com"
    
    @Published var deletingAccount = false
    @Published var loggingOutSheet = false
    
    func withdrawAccount() {
        guard let accessToken = UserDefaults.standard.string(forKey: "accessToken") else { return }
        guard let refreshToken = UserDefaults.standard.string(forKey: "refreshToken") else { return }
        
        // TODO: nil 리스폰스 처리
        GeneralAPIManger.request(for: .PostUsersMe(accessToken: accessToken, refreshToken: refreshToken), type: ResponsePostLogin.self ) {
            switch $0 {
            case .success:
                LaunchViewModel.shared.appState = .launch
                print("회원 탈퇴")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func logout() {
        guard let accessToken = UserDefaults.standard.string(forKey: "accessToken") else { return }
        guard let refreshToken = UserDefaults.standard.string(forKey: "refreshToken") else { return }
        
        UserDefaults.standard.removeObject(forKey: "accessToken")
        UserDefaults.standard.removeObject(forKey: "refreshToken")
        
        LaunchViewModel.shared.appState = .launch
    }
}

/// 닉네임 관련
extension ProfileViewModel {
    
    /// 닉네임 로드 함수
    func fetchNickname() {
        if let nickname = UserDefaults.standard.string(forKey: "nickname") {
            self.nickname = nickname
        }
        else {
            makeRandomNickname()
        }
    }
    
    /// 랜덤 닉네임 생성 함수
    func makeRandomNickname() {
        let tasteName: [String] = ["할라피뇨맛", "아몬드맛", "쿠앤크맛", "솜사탕맛", "고추가루맛", "초콜릿맛", "바닐라맛", "딸기맛", "민트맛", "카라멜맛", "바나나맛", "오렌지맛", "레몬맛", "라즈베리맛", "블루베리맛", "애플맛", "파인애플맛", "키위맛", "체리맛", "자몽맛", "산딸기맛", "피치맛", "망고맛", "코코넛맛", "라임맛", "크림맛", "캐러멜맛", "헤이즐넛맛", "버터맛", "크랜베리맛", "피넛버터맛", "아몬드맛", "카라멜맛", "모카맛", "아이스크림맛", "민트초코맛", "치즈케이크맛", "요거트맛", "오레오맛", "메론맛", "아이스티맛", "청포도맛","애플파이맛", "체리콜라맛", "마끼아또맛", "허니버터맛"]
        let workoutName: [String] = ["프로틴", "덤벨", "케틀벨", "아령", "사레레", "단백질", "풀업", "벤치프레스", "레그프레스", "스쿼트", "바벨", "풀업", "푸시업", "크런치", "플랭크", "런지", "스트랩", "폼롤러", "천국의계단", "유산소", "헬스장", "인터벌", "타바타", "숄더프레스", "바벨컬", "덤벨로우", "레그컬", "스트레칭", "드랍세트", "닭가슴살", "랫풀다운", "하체", "이두", "삼두", "전완근", "견갑", "복근", "승모근", "전거근", "삼각근", "내전근", "외복사근", "대흉근", "광배근", "대퇴이두근", "둔근", "오운완", "프리웨이트", "트레드밀", "수분조절"]
        
        let nickname = "\(tasteName.randomElement()!) \(workoutName.randomElement()!)"
        
        UserDefaults.standard.setValue(nickname, forKey: "nickname")
    }
}

