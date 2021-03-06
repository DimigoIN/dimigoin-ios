//
//  Widget.swift
//  Widget
//
//  Created by 변경민 on 2020/10/20.
//  Copyright © 2020 seohun. All rights reserved.
//

import WidgetKit
import SwiftUI
import Alamofire
import SwiftyJSON
import DimigoinKit

struct WidgetEntry: TimelineEntry {
    var date: Date
    var breakfast: String
    var lunch: String
    var dinner: String
}

@main
struct MainWidget: Widget {
    var body: some WidgetConfiguration {
        StaticConfiguration(
            kind: "DimigoinWidget",
            provider: Provider()
        ) { data in
            WidgetView(data: data)
        }
        .configurationDisplayName("디미고인 위젯")
        .description("누구보다 빠르게 급식과 시간표를 확인해보세요")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
//        .supportedFamilies([.systemSmall, .systemMedium])

    }
}

struct Provider: TimelineProvider {
    func getTimeline(in context: Context, completion: @escaping (Timeline<WidgetEntry>) -> Void) {
        getMeal(from: getToday8DigitDateString()) { meal in
            let data = WidgetEntry(date: Date(),
                                    breakfast: meal.getBreakfastString(),
                                    lunch: meal.getLunchString(),
                                    dinner: meal.getDinnerString())
            let nextUpdate = Calendar.current.date(byAdding: .minute, value: 15, to: Date())
            let timeline = Timeline(entries: [data], policy: .after(nextUpdate!))
            completion(timeline)
        }
    }
    func getSnapshot(in context: Context, completion: @escaping (WidgetEntry) -> Void) {
        let placeholderEntry = WidgetEntry(date: Date(),
                                      breakfast: sampleMeal.getBreakfastString(),
                                      lunch: sampleMeal.getLunchString(),
                                      dinner: sampleMeal.getDinnerString())
        completion(placeholderEntry)
    }
    func placeholder(in context: Context) -> WidgetEntry {
        let placeholderData = WidgetEntry(date: Date(),
                                      breakfast: sampleMeal.getBreakfastString(),
                                      lunch: sampleMeal.getLunchString(),
                                      dinner: sampleMeal.getDinnerString())
        return placeholderData
    }
}

struct WidgetView: View {
    @Environment(\.widgetFamily) var widgetFamily

    var data: WidgetEntry
    var body: some View {
        switch widgetFamily {
        case .systemSmall: NextMealWidget(data: data).widgetURL(URL(string: "widget://meal")!)
        case .systemMedium: DailyMealWidget(data: data).widgetURL(URL(string: "widget://meal")!)
        case .systemLarge: TimetableWidget(data: data).widgetURL(URL(string: "widget://timetable")!)
        default: Text("error")
        }
    }
}
