//
//  MainView.swift
//  dimigoin-ios
//
//  Created by 엄서훈 on 2020/06/26.
//  Copyright © 2020 seohun. All rights reserved.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var mealAPI: MealAPI
    @ObservedObject var noticeAPI = NoticeAPI()
    @ObservedObject var tokenAPI: TokenAPI
    @ObservedObject var ingangAPI = IngangAPI()
    @ObservedObject var userAPI = UserAPI()
    @State var showProfile = false
    @State var meals: [Dimibob] = []
    
    init(tokenAPI: TokenAPI, mealAPI: MealAPI) {
        self.tokenAPI = tokenAPI
        self.mealAPI = mealAPI
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                TimetableRow(timetable: dummyTimeTable).padding()
                NoticeRow(noticeAPI: noticeAPI).padding()
                MealRow(mealAPI: mealAPI).padding()
                if(isWeekday()) {
                    IngangRow(ingangAPI: ingangAPI, userAPI: userAPI).padding()
                }
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .navigationBarTitle(Text(getDate()))
            .navigationBarItems(
                trailing: Button(action: {
                        self.showProfile.toggle()
                }) {
                    Image(systemName: userAPI.user.photo)
                        .resizable()
                        .frame(width: 30, height: 30)
                }.sheet(isPresented: $showProfile) {
                    ProfileView(tokenAPI: tokenAPI, userAPI: userAPI)
                }
            )
        }
        
    }
}

//struct MainView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainView()
//    }
//}
