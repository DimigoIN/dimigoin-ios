//
//  FullNoticeListView.swift
//  dimigoin
//
//  Created by 변경민 on 2021/01/07.
//  Copyright © 2021 seohun. All rights reserved.
//

import SwiftUI
import DimigoinKit

struct FullNoticeListView: View {
    @EnvironmentObject var noticeAPI: NoticeAPI
    @EnvironmentObject var userAPI: UserAPI
    init() {
        _ = UINavigationBarAppearance()
        if #available(iOS 14.0, *) {
            UINavigationBar.appearance().tintColor = UIColor(Color("accent"))
        }
    }
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                ForEach(0..<noticeAPI.notices.count, id: \.self) { i in
                    VStack {
                        HStack {
                            Text(noticeAPI.notices[i].title).sectionHeader()
                            
                            Spacer()
                        }.horizonPadding()
                    }
                    VStack(alignment: .leading){
                        HStack {
                            ForEach(noticeAPI.notices[i].targetGrade, id: \.self) { grade in
                                Text("#\(grade)학년").font(Font.custom("NotoSansKR-Bold", size: 12)).foregroundColor(Color("accent"))
                            }
                        }
                        Text("\(noticeAPI.notices[i].content)")
                                .mealMenu()
                                
                    }.padding()
                    .frame(width: abs(geometry.size.width-40))
                    .background(CustomBox())
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.horizontal, 20)
                    
                }
    
            }
        }
        .navigationBarTitle("전체 공지사항")
    }
}
