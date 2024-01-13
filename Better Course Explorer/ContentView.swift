//
//  ContentView.swift
//  Better Course Explorer
//
//  Created by Lehan Yang on 1/10/24.
//

import SwiftUI
import course_explorer_api

struct ContentView: View {
    @ObservedObject var sectionsData: SectionsData
    @State private var showingAlert = false
    @State private var semester: String = "winter"
    @State private var selectedSubject: String = ""
    
    var body: some View {
        NavigationStack {
            List {
                Section(content: {
                    NavigationLink(destination: ListView(courses: sectionsData.courses)) {
                        Text("List")
                    }
                    /*NavigationLink(destination: RoomSearchView()) {
                        Text("Search by Room")
                     }*/
                    Text(String(sectionsData.courses.count) + " Courses Fetched")
                    })
                Section(content: {
                    Picker("Semester", selection: $semester) {
                        Text("Winter").tag("winter")
                        Text("Spring").tag("spring")
                        Text("Summer").tag("summer")
                        Text("Fall").tag("fall")
                    }
                }, header: {
                    Text("Search Parameters")
                })
                Section(content: {
                    TextField("Subject", text: $selectedSubject)
                    Button {
                        sectionsData.fetchSubjectData(baseURL: "https://courses.illinois.edu/cisapp/explorer/schedule", year: "2024", semester: semester, subject: selectedSubject.uppercased())
                        showingAlert = true
                    } label: {
                        Text("Fetch " + selectedSubject.uppercased())
                    }
                        .alert("Fetching Data\nPlease Be Patient", isPresented: $showingAlert) {
                        Button("OK") { }
                        }
                }, header: {
                    Text("Search by Subject")
                })
            }
        }
    }
}

#Preview {
    ContentView(sectionsData: SectionsData())
}
