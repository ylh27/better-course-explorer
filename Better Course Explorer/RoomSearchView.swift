//
//  RoomSearchView.swift
//  Better Course Explorer
//
//  Created by Lehan Yang on 1/13/24.
//

import SwiftUI
import course_explorer_api

var returnListActive: [CourseSection] = []
var returnListInactive: [CourseSection] = []

struct RoomSearchView: View {
    @ObservedObject var sectionsData: SectionsData
    @State private var searchBuildingName = ""
    @State private var searchRoomNumber = ""
    @State private var resultList: [CourseSection] = []
    @State private var isShowing: Bool = false
    @State private var isShowingWeek: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                Picker("Building Name", selection: $searchBuildingName) {
                    ForEach(Array(sectionsData.buildingNames), id: \.self) { buildingName in
                        Text(buildingName).tag(buildingName)
                    }
                }
                HStack {
                    Text("Room Number")
                    Spacer()
                    TextField("Room Number", text: $searchRoomNumber)
                        .multilineTextAlignment(.trailing)
                        .keyboardType(.numberPad)
                }
                /*Button {
                    resultList = roomSearch(courseList: sectionsData.courses, buildingName: searchBuildingName, roomNumber: searchRoomNumber)
                    isShowing = false
                    isShowingWeek = true
                } label: {
                    Text("Week View")
                }*/
                Button {
                    roomSearch(courseList: sectionsData.courses, buildingName: searchBuildingName, roomNumber: searchRoomNumber)
                    isShowing = true
                    isShowingWeek = false
                } label: {
                    Text("Search")
                }
            }
            .navigationTitle("Search")
            .sheet(isPresented: $isShowing) {
                NavigationStack {
                    ResultView(courseSectionsActive: returnListActive, courseSectionsInactive: returnListInactive)
                }
            }
            .sheet(isPresented: $isShowingWeek) {
                NavigationStack {
                    WeekView()
                }
            }
        }
    }
}

func roomSearch(courseList: [Course], buildingName: String, roomNumber: String) {
    // clear existing courses
    returnListActive.removeAll()
    returnListInactive.removeAll()
    
    for course in courseList {
        for section in course.sections {
            for meeting in section.meetings {
                if meeting.buildingName == buildingName {
                    if meeting.roomNumber == roomNumber || roomNumber.isEmpty {
                        if isActive(meeting: meeting) {
                            returnListActive.append(section)
                        } else {
                            returnListInactive.append(section)
                        }
                    }
                }
            }
        }
    }
}

func isActive(meeting: Meeting) -> Bool {
    let inFormatter = DateFormatter()
    inFormatter.locale = NSLocale(localeIdentifier: "en_US") as Locale
    inFormatter.timeZone = TimeZone(abbreviation: "CST")
    inFormatter.dateFormat = "hh:mm a"

    let startOp = inFormatter.date(from: meeting.start)
    let endOp = inFormatter.date(from: meeting.end)
    
    let calendar = Calendar.current
    
    let startTime = calendar.dateComponents([.hour, .minute], from: startOp!)
    let endTime = calendar.dateComponents([.hour, .minute], from: endOp!)
    let currTime = calendar.dateComponents([.hour, .minute, .weekday], from: Date())
    
    switch currTime.weekday! {
    case 2: // mon
        if !meeting.daysOfTheWeek.contains("M") {
            return false
        }
    case 3: // tue
        if !meeting.daysOfTheWeek.contains("T") {
            return false
        }
    case 4: // wed
        if !meeting.daysOfTheWeek.contains("W") {
            return false
        }
    case 5: // thu
        if !meeting.daysOfTheWeek.contains("R") {
            return false
        }
    case 6: // fri
        if !meeting.daysOfTheWeek.contains("F") {
            return false
        }
    default:
        return false
    }
    
    if startTime.hour! <= currTime.hour! && startTime.minute! <= currTime.minute! &&
        endTime.hour! >= currTime.hour! && endTime.minute! >= currTime.minute! {
        return true
    }
    
    return false
}

/*
#Preview {
    RoomSearchView()
}
*/
