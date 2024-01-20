//
//  CourseView.swift
//  Better Course Explorer
//
//  Created by Lehan Yang on 1/13/24.
//

import SwiftUI
import course_explorer_api

struct CourseView: View {
    let course: Course
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    HStack {
                        Text("Course")
                        Spacer()
                        Text(course.course).multilineTextAlignment(.trailing)
                    }
                    HStack {
                        Text("Department")
                        Spacer()
                        Text(course.subject).multilineTextAlignment(.trailing)
                    }
                }
                Section("Sections") {
                    ForEach(course.sections, id: \.id) { section in
                        NavigationLink(destination: DetailView(section: section)) {
                            Text(section.sectionNumber)
                        }
                    }
                }
            }
            .navigationTitle(course.subjectID + " " + course.courseID + " ")
        }
    }
}
/*
#Preview {
    CourseView(course: )
}
*/
