//
//  ResultView.swift
//  Better Course Explorer
//
//  Created by Lehan Yang on 1/20/24.
//

import SwiftUI
import course_explorer_api

struct ResultView: View {
    let courseSectionsActive: [CourseSection]
    let courseSectionsInactive: [CourseSection]
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Active")) {
                    ForEach(courseSectionsActive, id: \.id) { section in
                        let sectionString = section.course + " (" + section.subjectID + " " + section.courseID + " " + section.sectionNumber + ") "
                        VStack {
                            NavigationLink(destination: DetailView(section: section)) {
                                Text(sectionString)
                            }
                        }
                    }
                    if courseSectionsActive.isEmpty {
                        Text("None")
                    }
                }
                Section(header: Text("Inactive")) {
                    ForEach(courseSectionsInactive, id: \.id) { section in
                        let sectionString = section.course + " (" + section.subjectID + " " + section.courseID + " " + section.sectionNumber + ") "
                        VStack {
                            NavigationLink(destination: DetailView(section: section)) {
                                Text(sectionString)
                            }
                        }
                    }
                    if courseSectionsInactive.isEmpty {
                        Text("None")
                    }
                }
            }
            .toolbar(.hidden)
        }
    }
}
/*
#Preview {
    ResultView()
}
*/
