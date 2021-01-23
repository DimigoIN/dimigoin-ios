//
//  HomeView.swift
//  dimigoin
//
//  Created by 변경민 on 2020/11/08.
//  Copyright © 2020 seohun. All rights reserved.
//

import SwiftUI
import DimigoinKit
import SDWebImageSwiftUI

struct HomeView: View {
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @EnvironmentObject var mealAPI: MealAPI
    @EnvironmentObject var alertManager: AlertManager
    @EnvironmentObject var tokenAPI : TokenAPI
    @EnvironmentObject var userAPI: UserAPI
    @EnvironmentObject var attendanceLogAPI: AttendanceLogAPI
    @EnvironmentObject var placeAPI: PlaceAPI
    @EnvironmentObject var ingangAPI: IngangAPI
    @State var currentLocation = 0
    @State var showLogoutButton: Bool = false
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(showsIndicators: false){
                VStack{
                    ZStack {
                        VStack {
                            VSpacer(50)
                            if(horizontalSizeClass == .compact) {
                                Image("school").resizable().aspectRatio(contentMode: .fit).frame(maxWidth: .infinity).opacity(0.3)
                            }
                            else {
                                Image("school").resizable().frame(maxWidth: .infinity).opacity(0.3)
                            }
                        }
                        HStack {
                            Image("logo").renderingMode(.template).resizable().aspectRatio(contentMode: .fit).frame(height: 38).foregroundColor(Color.accent)
                            Spacer()
                            Button(action: {
                                withAnimation(Animation.easeInOut(duration: 0.75)) {
                                    self.showLogoutButton.toggle()
                                }
                            }) {
                                ZStack {
                                    Circle().fill(Color.systemBackground).frame(width: 38, height: 38)
                                    withAnimation() {
                                        userAPI.userPhoto
                                            .resizable()
                                            .foregroundColor(Color.accent)
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 38)
                                            .clipShape(Circle())
                                            .overlay(
                                                Circle().stroke(Color.accent, lineWidth: 2)
                                            )
                                            .accessibility(identifier: "profile")
                                    }
                                }
                            }
                            if showLogoutButton {
                                Button(action: {
                                    tokenAPI.clearTokens()
                                }) {
                                    Image("logout").renderingMode(.template).resizable().aspectRatio(contentMode: .fit).frame(width: 30).foregroundColor(Color.accent)
                                }
                            }
                        }.horizonPadding()
                    }
                    VSpacer(15)
                    LocationSelectionView(currentLocation: $currentLocation)
                        .environmentObject(attendanceLogAPI)
                        .environmentObject(placeAPI)
                        .environmentObject(alertManager)
                    Spacer()
                    Text("오늘의 급식").font(Font.custom("NotoSansKR-Bold", size: 20)).horizonPadding()
                    MealPagerView()
                        .environmentObject(mealAPI)
                }
            }
        }
    }
}


