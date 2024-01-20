//
//  RoomSearchView.swift
//  Better Course Explorer
//
//  Created by Lehan Yang on 1/13/24.
//

import SwiftUI
import course_explorer_api

struct RoomSearchView: View {
    @ObservedObject var sectionsData: SectionsData
    @State private var searchBuildingName = ""
    @State private var searchRoomNumber = ""
    @State private var resultList: [CourseSection] = []
    @State private var isShowing: Bool = false
    
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
                Button {
                    resultList = roomSearch(courseList: sectionsData.courses, buildingName: searchBuildingName, roomNumber: searchRoomNumber)
                    isShowing = true
                } label: {
                    Text("Search")
                }
            }
            .navigationTitle("Search")
            .sheet(isPresented: $isShowing) {
                NavigationStack {
                    ResultView(courseSections: resultList)
                }
            }
        }
    }
}

func roomSearch(courseList: [Course], buildingName: String, roomNumber: String) -> [CourseSection] {
    var returnList: [CourseSection] = []
    
    for course in courseList {
        for section in course.sections {
            for meeting in section.meetings {
                if meeting.buildingName == buildingName {
                    if meeting.roomNumber == roomNumber || roomNumber.isEmpty {
                        returnList.append(section)
                    }
                }
            }
        }
    }
    
    return returnList
}
/*
#Preview {
    RoomSearchView()
}
*/
