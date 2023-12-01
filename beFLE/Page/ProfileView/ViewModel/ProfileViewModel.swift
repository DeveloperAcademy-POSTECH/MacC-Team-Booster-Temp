//
//  ProfileViewModel.swift
//  beFLE
//
//  Created by 정회승 on 11/16/23.
//

import SwiftUI

class ProfileViewModel: ObservableObject {
    var version = "1.0.0"
    @Published var mailData = ComposeMailData(subject: "비플 문의하기", recipients: ["pmchung423@gmail.com"], message: "비플 문의하기", attachments: [])
    @Published var nickname = ""
    @Published var isMailSheetShow = false
    @Published var isWithdrawAlertShow = false
    @Published var isLogoutAlertShow = false
    @Published var offset: CGFloat = .zero
}

/// 토글 관련
extension ProfileViewModel {
    func showMailSheet() {
        isMailSheetShow = true
    }
    
    func showWithdrawAlert() {
        isWithdrawAlertShow = true
    }
    
    func showLogoutAlert() {
        isLogoutAlertShow = true
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
            let nickname = makeRandomNickname()
            saveNickname(nickname)
            self.nickname = nickname
        }
    }
    
    /// 랜덤 닉네임 생성 함수
    func makeRandomNickname() -> String {
        let tasteName: [String] = ["할라피뇨맛", "아몬드맛", "쿠앤크맛", "솜사탕맛", "고추가루맛", "초콜릿맛", "바닐라맛", "딸기맛", "민트맛", "카라멜맛", "바나나맛", "오렌지맛", "레몬맛", "라즈베리맛", "블루베리맛", "애플맛", "파인애플맛", "키위맛", "체리맛", "자몽맛", "산딸기맛", "피치맛", "망고맛", "코코넛맛", "라임맛", "크림맛", "캐러멜맛", "헤이즐넛맛", "버터맛", "크랜베리맛", "피넛버터맛", "아몬드맛", "카라멜맛", "모카맛", "아이스크림맛", "민트초코맛", "치즈케이크맛", "요거트맛", "오레오맛", "메론맛", "아이스티맛", "청포도맛","애플파이맛", "체리콜라맛", "마끼아또맛", "허니버터맛"]
        let workoutName: [String] = ["프로틴", "덤벨", "케틀벨", "아령", "사레레", "단백질", "풀업", "벤치프레스", "레그프레스", "스쿼트", "바벨", "풀업", "푸시업", "크런치", "플랭크", "런지", "스트랩", "폼롤러", "천국의계단", "유산소", "헬스장", "인터벌", "타바타", "숄더프레스", "바벨컬", "덤벨로우", "레그컬", "스트레칭", "드랍세트", "닭가슴살", "랫풀다운", "하체", "이두", "삼두", "전완근", "견갑", "복근", "승모근", "전거근", "삼각근", "내전근", "외복사근", "대흉근", "광배근", "대퇴이두근", "둔근", "오운완", "프리웨이트", "트레드밀", "수분조절"]
        
        return "\(tasteName.randomElement()!) \(workoutName.randomElement()!)"
    }
    
    /// 닉네임 저장 함수
    func saveNickname(_ nickname: String) {
        UserDefaults.standard.setValue(nickname, forKey: "nickname")
    }
    
    /// 닉네임 제거 함수
    func removeNickname() {
        UserDefaults.standard.removeObject(forKey: "nickname")
    }
}

/// 계정 관련
extension ProfileViewModel {
    /// 회원 탈퇴 함수
    func withdrawAccount() {
        guard let accessToken = UserDefaults.standard.string(forKey: "accessToken") else { return }
        guard let refreshToken = UserDefaults.standard.string(forKey: "refreshToken") else { return }
        
        GeneralAPIManger.request(for: .PostUsersMe(accessToken: accessToken, refreshToken: refreshToken)) {
            switch $0 {
            case .success:
                self.removeNickname()
                LaunchViewModel.shared.appState = .launch
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    /// 로그아웃 함수
    func logout() {
        guard UserDefaults.standard.string(forKey: "accessToken") != nil else { return }
        guard UserDefaults.standard.string(forKey: "refreshToken") != nil else { return }
        
        UserDefaults.standard.removeObject(forKey: "accessToken")
        UserDefaults.standard.removeObject(forKey: "refreshToken")
        
        LaunchViewModel.shared.appState = .launch
    }
}

