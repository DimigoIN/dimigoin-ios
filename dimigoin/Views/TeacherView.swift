//
//  TeacherView.swift
//  dimigoin
//
//  Created by 변경민 on 2021/02/18.
//  Copyright © 2021 seohun. All rights reserved.
//

import SwiftUI
import DimigoinKit

struct TeacherView: View {
    @EnvironmentObject var api: DimigoinAPI
    @State var searchText: String = ""
    @State var showDetailView: Bool = false
    @State var showHistoryView: Bool = false
    @State var attendanceList: [Attendance] = []
    @State var selectedAttendance: Attendance = Attendance()

    @State var selectedGrade: Int = 1
    @State var selectedClass: Int = 1
    
    @State var isFetching: Bool = false
    @State var isFetchingAttendanceLog: Bool = false
    
    init() {
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().tintColor = UIColor(.accent)
    }
    
    var body: some View {
        ZStack {
            GeometryReader { geometry in
                ScrollView {
                    HStack {
                        VStack(alignment: .leading, spacing: 0) {
                            Text(getStringTimeZone()).notoSans(.bold, size: 13, .gray4)
                            HStack {
                                Text("\(selectedGrade)학년 \(selectedClass)반").notoSans(.black, size: 30)
                                Button(action: {
                                    Alert.logoutCheck(api: api)
                                }) {
                                    Image("logout").renderingMode(.template).foregroundColor(.accent)
                                }
                                Spacer()
                                Button(action: {
                                    withAnimation(.easeInOut) { self.isFetchingAttendanceLog = true }
                                    getClassHistory(api.accessToken, grade: selectedGrade, class: selectedClass) { result in
                                        print(result)
                                        switch result {
                                        case .success(let attendanceLog):
                                            Alert.classHistory(grade: selectedGrade, class: selectedClass, attendanceLog: attendanceLog)
                                        case .failure(_):
                                            print("get attendanceLog failed in Attendance HistoryView")
                                        }
                                        withAnimation(.easeInOut) { self.isFetchingAttendanceLog = false }
                                    }
                                }) {
                                    if isFetchingAttendanceLog {
                                        ProgressView()
                                            .scaleEffect(0.7, anchor: .center)
                                            .frame(width: 74, height: 25)
                                            .background(Color.accent.cornerRadius(13))
                                    } else {
                                        Text("히스토리")
                                            .notoSans(.bold, size: 12, .white)
                                            .frame(width: 74, height: 25)
                                            .background(Color.accent.cornerRadius(13))
                                    }
                                }
                            }
                        }
                    }.horizonPadding()
                    .padding(.top, 30)
                    AttendanceChart(attendanceList: $attendanceList, geometry: geometry)
                    VSpacer(20)
                    SearchBar(searchText: $searchText, geometry: geometry)
                    VSpacer(25)
                    if isFetching {
                        ProgressView()
                    } else {
                        AttendanceList(attendanceList: $attendanceList,
                                       userType: api.user.type,
                                       searchText: $searchText,
                                       selectedAttendance: $selectedAttendance,
                                       showDetailView: $showDetailView,
                                       geometry: geometry)
                    }
                    VSpacer(130)
                }
            }
            
            VStack {
                Spacer()
                VStack {
                    Picker("반을 선택해주세요", selection: $selectedGrade) {
                        ForEach(1..<4, id: \.self) { grade in
                            Text("\(grade)학년")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                    .horizonPadding()
                    VSpacer(5)
                    Picker("교실을 선택해주세요", selection: $selectedClass) {
                        ForEach(1..<7, id: \.self) { `class` in
                            Text("\(`class`)반")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                    .horizonPadding()
                }.frame(height: 120)
                .frame(maxWidth: .infinity)
                .background(
                    RoundSquare(topLeft: 10, topRight: 10, bottomLeft: 0, bottomRight: 0)
                        .fill(Color.systemBackground)
                        .shadow(color: Color.black.opacity(0.05), radius: 20, x: 0, y: 0)
                        .edgesIgnoringSafeArea(.all)
                )
                .edgesIgnoringSafeArea(.all)
            }.unredacted()
        }
        .onAppear {
            fetchAttendanceList()
        }
        .onChange(of: selectedGrade) { _ in
            fetchAttendanceList()
        }
        .onChange(of: selectedClass) { _ in
            fetchAttendanceList()
        }
        
    }
    func fetchAttendanceList() {
        withAnimation(.easeInOut) { self.isFetching = true }
        getAttendenceList(api.accessToken, grade: selectedGrade, class: selectedClass) { result in
            switch result {
            case .success(let attendanceList):
                withAnimation(.easeInOut) { self.attendanceList = attendanceList }
            case .failure(_):
                print("error")
            }
            withAnimation(.easeInOut) { self.isFetching = false }
        }
    }
}
