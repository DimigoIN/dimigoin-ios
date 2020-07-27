//
//  MealItem.swift
//  dimigoin
//
//  Created by 엄서훈 on 2020/06/27.
//  Copyright © 2020 seohun. All rights reserved.
//

import SwiftUI

struct MealItem: View {
    @State var mealType: MealType
    @ObservedObject var mealData: MealAPI
    
    var body: some View {
        VStack(alignment: .leading) {
            switch mealType {
                case .breakfast: Text("아침").highlight().headline()
                case .lunch: Text("점심").highlight().headline()
                case .dinner: Text("저녁").highlight().headline()
            }
            VSpacer(10)
            switch mealType {
                case .breakfast: Text(self.mealData.meal.breakfast).body()
                case .lunch: Text(self.mealData.meal.lunch).body()
                case .dinner: Text(self.mealData.meal.dinner).body()
            }
            
        }.CustomBox()
    }
}

//struct MealItem_Previews: PreviewProvider {
//    static var previews: some View {
//        MealItem(
//            mealType: .breakfast,
//            mealContent: "훈제오리통마늘구이 | 차조밥 | 쌀밥 | 된장찌개 | 타코야끼 | 쌈무&머스타드 | 포기김치 | 아이스티"
//        )
//            .padding()
//            .previewLayout(.sizeThatFits)
//    }
//}
