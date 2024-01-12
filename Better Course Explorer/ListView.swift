//
//  ListView.swift
//  Better Course Explorer
//
//  Created by Lehan Yang on 1/12/24.
//

import SwiftUI
import course_explorer_api

struct ListView: View {
    let sections: [CourseSection]
    
    var body: some View {
        NavigationView {
            List(sections, id: \.id) { section in
                VStack {
                    Text(section.course!)
                }
            }
        }
    }
    
    }

#Preview {
    ListView(sections: [])
}
