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
                
            }
            .navigationTitle(course.subjectID + " " + course.courseID + " ")
        }
    }
}
/*
#Preview {
    CourseView(course: course_explorer_api.Course()
}
*/
