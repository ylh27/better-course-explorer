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
    @State private var year: String = ""
    @State private var semester: String = "winter"
    @State private var selectedSubject: String = ""
    
    var body: some View {
        NavigationStack {
            List {
                Section(content: {
                    NavigationLink(destination: ListView(courses: sectionsData.courses)) {
                        Text("Course List")
                    }
                    NavigationLink(destination: RoomSearchView(sectionsData: sectionsData)) {
                        Text("Search by Room")
                    }
                    Text(String(sectionsData.courses.count) + " Courses Fetched")
                    Text("Last Successful Fetch at " + sectionsData.lastSuccess.formatted(date: .omitted, time: .standard))
                    })
                Section("Fetch Parameters") {
                    /*
                    // didn't really work
                    Picker("Year", selection: $year) {
                        ForEach(sectionsData.years.indices) { index in
                            Text(sectionsData.years[index]).tag(sectionsData.years[index])
                        }
                    }
                    */
                     HStack {
                        Text("Year")
                        Spacer()
                        TextField("Year", text: $year)
                            .multilineTextAlignment(.trailing)
                            .keyboardType(.numberPad)
                    }
                    Picker("Semester", selection: $semester) {
                        Text("Winter").tag("winter")
                        Text("Spring").tag("spring")
                        Text("Summer").tag("summer")
                        Text("Fall").tag("fall")
                    }
                    Button {
                        sectionsData.fetchSemester(baseURL: "https://courses.illinois.edu/cisapp/explorer/schedule", year: year, semester: semester)
                    } label: {
                        Text("Fetch " + year + " " + semester.capitalized)
                    }
                        .alert("Fetching Data\nPlease Be Patient", isPresented: $showingAlert) {
                            Button("OK") { }
                        }
                }
            }
        }
        .onAppear {
            sectionsData.getYearsList(baseURL: "https://courses.illinois.edu/cisapp/explorer/schedule")
        }
    }
}

#Preview {
    ContentView(sectionsData: SectionsData())
}
