//
//  MainView.swift
//  dimigoin-ios
//
//  Created by 엄서훈 on 2020/06/26.
//  Copyright © 2020 seohun. All rights reserved.
//

import SwiftUI

struct MainView: View {
    @State var showProfile = false
    @State var meals: [Dimibob] = []

    var body: some View {
        NavigationView {
            ScrollView {
                if getDay() != "토" && getDay() != "일" {
                    TimetableRow(subjects: dummySubjects).padding()
                }
                NoticeRow(notices: [dummyNotice1, dummyNotice2]).padding()

                MealRow(dimibob: dummyDimibob).padding()

                IngangRow(ingangs: [dummyIngang1, dummyIngang2]).padding()
                Spacer()
            }
            .navigationBarTitle(Text(getDate()))
            .navigationBarItems(
                trailing: Button(action: { self.showProfile.toggle() }) {
                    Image(systemName: "person.crop.circle")
                        .resizable()
                        .frame(width: 30, height: 30)
                }.sheet(isPresented: $showProfile) {
                    ProfileView()
                }
            )
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
