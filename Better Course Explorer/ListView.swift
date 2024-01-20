//
//  ListView.swift
//  Better Course Explorer
//
//  Created by Lehan Yang on 1/12/24.
//

import SwiftUI
import course_explorer_api

struct ListView: View {
    let courses: [Course]
    @State var searchText = ""
    
    var body: some View {
        NavigationView {
            List(searchResult, id: \.id) { course in
                let sectionString = course.course + " (" + course.subjectID + " " + course.courseID + ") "
                VStack {
                    NavigationLink(destination: CourseView(course: course)) {
                        Text(sectionString)
                    }
                }
            }
        }
        .searchable(text: $searchText)
        .navigationTitle("Course List")
    }
    
    var searchResult: [Course] {
        if searchText.isEmpty {
            return courses
        } else {
            return courses.filter {
                $0.subject.localizedStandardContains(searchText) || $0.subjectID.localizedStandardContains(searchText) || $0.course.localizedStandardContains(searchText) || $0.courseID.localizedCaseInsensitiveContains(searchText) ||
                $0.id.localizedStandardContains(searchText)
            }
        }
    }
}

#Preview {
    ListView(courses: [])
}
