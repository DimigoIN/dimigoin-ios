//
//  MealView.swift
//  dimigoin
//
//  Created by 변경민 on 2020/11/08.
//  Copyright © 2020 seohun. All rights reserved.
//

import SwiftUI
import DimigoinKit

struct MealView: View {
    @EnvironmentObject var mealAPI: MealAPI
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ScrollView(showsIndicators: false) {
                    HStack {
                        ViewTitle("급식", sub: getDateString())
                        Spacer()
                        NavigationLink(destination: WeeklyMealView()) {
                            Image("calender").resizable().aspectRatio(contentMode: .fit).frame(height: 40)
                        }
                    }.horizonPadding()
                    .padding(.top, 40)
                    HDivider().horizonPadding().offset(y: -15)
                    VStack {
                        SectionHeader("아침", sub: "오전 7시 30분")
                        Text(mealAPI.getTodayMeal().breakfast)
                            .mealMenu()
                            .padding()
                            .frame(width: UIScreen.screenWidth-40)
                            .background(CustomBox())
                            .fixedSize(horizontal: false, vertical: true)
                            
                    }
                    VSpacer(20)
                    MealItem("점심", "오후 12시 50분", mealAPI.getTodayMeal().lunch)
                    VSpacer(20)
                    MealItem("저녁", "오후 6시 35분", mealAPI.getTodayMeal().dinner)
                    Spacer()
                }
            }
            .navigationBarHidden(true)
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

