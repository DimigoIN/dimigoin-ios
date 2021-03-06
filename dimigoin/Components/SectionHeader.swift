//
//  SectionHeader.swift
//  dimigoin
//
//  Created by 변경민 on 2020/11/08.
//  Copyright © 2020 seohun. All rights reserved.
//

import SwiftUI

struct SectionHeader: View {
    var sectionHeader: String
    var subSectionHeader: String
    
    init(_ sectionHeader: String, sub subSectionHeader: String) {
        self.sectionHeader = sectionHeader
        self.subSectionHeader = subSectionHeader
    }
    
    var body: some View {
        VStack {
            HStack {
                Text(NSLocalizedString(self.subSectionHeader, comment: "")).notoSans(.bold, size: 10, .accent)
                Spacer()
            }
            HStack {
                Text(NSLocalizedString(self.sectionHeader, comment: "")).notoSans(.bold, size: 21)
                Spacer()
            }
        }
    }
}
