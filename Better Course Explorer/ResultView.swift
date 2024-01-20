//
//  ResultView.swift
//  Better Course Explorer
//
//  Created by Lehan Yang on 1/20/24.
//

import SwiftUI
import course_explorer_api

struct ResultView: View {
    let courseSections: [CourseSection]
    
    var body: some View {
        NavigationView {
            List(courseSections, id: \.id) { section in
                let sectionString = section.course + " (" + section.subjectID + " " + section.courseID + " " + section.sectionNumber + ") "
                VStack {
                    NavigationLink(destination: DetailView(section: section)) {
                        Text(sectionString)
                    }
                }
            }
        }
    }
}
/*
#Preview {
    ResultView()
}
*/
