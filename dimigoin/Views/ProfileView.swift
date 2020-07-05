//
//  ProfileView.swift
//  dimigoin-ios
//
//  Created by 엄서훈 on 2020/06/27.
//  Copyright © 2020 seohun. All rights reserved.
//

import SwiftUI
//import SPAlert

struct ProfileView: View {
    @Environment(\.presentationMode) private var presentationMode
    var body: some View {
        NavigationView {
            VStack(spacing: 15.0) {
                VStack(alignment: .leading, spacing: 15) {
                    HStack {
                        Text("이름").highlight().headline()
                        Spacer()
                        Text("엄서훈").foregroundColor(Color("DisabledButton"))
                    }
                    Divider().offset(x: 35)
                    HStack {
                        Text("아이디").highlight().headline()
                        Spacer()
                        Text("uhmtoto").foregroundColor(Color("DisabledButton"))
                    }
                    Divider().offset(x: 35)
                    HStack {
                        Text("학적").highlight().headline()
                        Spacer()
                        Text("2학년 5반 19번 (해킹방어과)").foregroundColor(Color("DisabledButton"))
                    }
                    Divider().offset(x: 35)
                    HStack {
                        Text("금주 잔여 인강실 티켓").highlight().headline()
                        Spacer()
                        Text("5개").foregroundColor(Color("DisabledButton"))
                    }
                    Divider().offset(x: 35)
                    HStack {
                        Text("금일 잔여 인강실 티켓").highlight().headline()
                        Spacer()
                        Text("2개").foregroundColor(Color("DisabledButton"))
                    }
                }.CustomBox()
                VSpacer(10)
                Button(action: {
                    if let url = URL(string: "https://student.dimigo.hs.kr/user/profile") {
                        UIApplication.shared.open(url)
                    }
                }) {
                    Text("프로필 수정하기").SquareButton(312, 27)
                }
                Button(action: {
                    // log out
                }) {
                    Text("로그아웃").SquareButtonRed(312, 27)
                }
                Spacer()
            }.padding()
            .navigationBarTitle("나의 프로필")
            .navigationBarItems(
                trailing: Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "xmark")
                }
            )
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
