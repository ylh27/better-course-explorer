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
    
    var body: some View {
        NavigationView {
            List(courses, id: \.id) { course in
                let sectionString = course.course + " (" + course.subjectID + " " + course.courseID + ") "
                VStack {
                    NavigationLink(destination: CourseView(course: course)) {
                        Text(sectionString)
                    }
                }
            }
        }
    }
    
    }

#Preview {
    ListView(courses: [])
}
