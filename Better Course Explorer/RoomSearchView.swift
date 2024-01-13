//
//  RoomSearchView.swift
//  Better Course Explorer
//
//  Created by Lehan Yang on 1/13/24.
//

import SwiftUI
import course_explorer_api
/*
struct RoomSearchView: View {
    let sections: [CourseSection]
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(searchResults, id: \.self) { name in
                    NavigationLink {
                        Text(name)
                    } label: {
                        Text(name)
                    }
                }
            }
            .navigationTitle("Contacts")
        }
        .searchable(text: $searchText)
    }
    
    var searchResults: [String] {
        if searchText.isEmpty {
            return sections
        } else {
            return sections.filter { $0.contains(searchText) }
        }
    }
}

#Preview {
    RoomSearchView()
}*/
