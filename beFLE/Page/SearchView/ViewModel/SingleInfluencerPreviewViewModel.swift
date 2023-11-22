//
//  SingleInfluencerPreviewViewModel.swift
//  beFLE
//
//  Created by 송재훈 on 11/18/23.
//

import SwiftUI

class SingleInfluencerPreviewViewModel: ObservableObject {
    @Published var mailData = ComposeMailData(subject: "비플 문의하기", 
                                              recipients: ["pmchung423@gmail.com"],
                                              message: "비플 문의하기", 
                                              attachments: [ 
//                                                AttachmentData(data: "Some text".data(using: .utf8)!,
//                                                                                                                                                          mimeType: "text/plain",
//                                                                                                                                                          fileName: "text.txt"                             )
                                              ])
    
    @Published var showMailView = false
}
