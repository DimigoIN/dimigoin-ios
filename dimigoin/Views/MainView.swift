//
//  MainView.swift
//  dimigoin-ios
//
//  Created by 엄서훈 on 2020/06/26.
//  Copyright © 2020 seohun. All rights reserved.
//

import SwiftUI
import UserNotifications
import DimigoinKit

struct MainView: View {
    @ObservedObject var mealAPI = MealAPI()
    @ObservedObject var noticeAPI = NoticeAPI()
    @ObservedObject var tokenAPI: TokenAPI
    @ObservedObject var ingangAPI = IngangAPI()
    @ObservedObject var userAPI = UserAPI()
    @ObservedObject var timetableAPI = TimetableAPI()
    @ObservedObject var alertManager: AlertManager
    var NotificationAPI = NotificationManager()
    @State var index = 2
    @State var showIdCard = false
    
    init(tokenAPI: TokenAPI, alertManager: AlertManager) {
        self.tokenAPI = tokenAPI
        self.alertManager = alertManager
        let notificationManager = NotificationManager()
        notificationManager.requestPermission()
    }
    var body: some View {
        ZStack {
            VStack {
                switch self.index {
                case 0: ProfileView(userAPI: userAPI, tokenAPI: tokenAPI, alertManager: alertManager)
                    case 1: IngangView(ingangAPI: ingangAPI, tokenAPI: tokenAPI, alertManager: alertManager)
                    case 2: HomeView(mealAPI: mealAPI, alertManager: alertManager, tokenAPI: tokenAPI, userAPI: userAPI, showIdCard: $showIdCard)
                    case 3: MealView(mealAPI: mealAPI)
                    case 4: TimetableView(timetableAPI: timetableAPI, userAPI: userAPI)
                    default: Text("Error")
                }
                TapBar(index: self.$index)
            }
            StudentIdCardModalView(isShowing: $showIdCard, userAPI: userAPI)
            if(alertManager.isShowing) {
                AlertView(alertType: alertManager.alertType, content: alertManager.content, sub: alertManager.sub, isShowing: $alertManager.isShowing)
            }
        }
    }
}

