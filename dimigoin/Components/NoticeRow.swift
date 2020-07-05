//
//  NoticeRow.swift
//  dimigoin
//
//  Created by 엄서훈 on 2020/06/27.
//  Copyright © 2020 seohun. All rights reserved.
//

import SwiftUI

struct NoticeRow: View {
    @State var notices: [Notice]
    
    var body: some View {
        VStack {
            HStack {
                HStack(alignment:.top) {
                    Text("공지사항").sectionHeader()
                    Circle()
                        .foregroundColor(Color("Secondary"))
                        .frame(width: 8, height: 8)
                        .offset(x: -5)
                }
                Spacer()
                NavigationLink(destination: NoticeListView()) {
                    Text("더 보기").caption1()
                }
            }
            
            VSpacer(14)
            
            VStack(spacing: 15.0) {
                ForEach(0 ..< self.notices.count) { noticeIndex in
                    if noticeIndex < 3 {
                        NoticeItem(notice: self.notices[noticeIndex])
                    }
                }
            }
        }
    }
}

struct NoticeRow_Previews: PreviewProvider {
    static var previews: some View {
        NoticeRow(notices: [dummyNotice1, dummyNotice2])
            .previewLayout(.sizeThatFits)
    }
}
