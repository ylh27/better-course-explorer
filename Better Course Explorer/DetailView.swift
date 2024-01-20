//
//  DetailView.swift
//  Better Course Explorer
//
//  Created by Lehan Yang on 1/11/24.
//

import SwiftUI
import course_explorer_api

struct DetailView: View {
    let section: CourseSection
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    HStack {
                        Text("Course")
                        Spacer()
                        Text(section.course).multilineTextAlignment(.trailing)
                    }
                    HStack {
                        Text("Department")
                        Spacer()
                        Text(section.subject).multilineTextAlignment(.trailing)
                    }
                }
                ForEach(section.meetings, id: \.id) { meeting in
                    Section("Meeting " + meeting.id) {
                        HStack {
                            Text("Type")
                            Spacer()
                            Text(meeting.type).multilineTextAlignment(.trailing)
                        }
                        HStack {
                            Text("Start")
                            Spacer()
                            Text(meeting.start).multilineTextAlignment(.trailing)
                        }
                        HStack {
                            Text("End")
                            Spacer()
                            Text(meeting.end).multilineTextAlignment(.trailing)
                        }
                        HStack {
                            Text("Days")
                            Spacer()
                            Text(meeting.daysOfTheWeek).multilineTextAlignment(.trailing)
                        }
                        HStack {
                            Text("Building")
                            Spacer()
                            Text(meeting.buildingName).multilineTextAlignment(.trailing)
                        }
                        HStack {
                            Text("Room")
                            Spacer()
                            Text(meeting.roomNumber).multilineTextAlignment(.trailing)
                        }
                        NavigationLink(destination: Text("More")) {
                            Text("More")
                        }
                    }
                }
            }
            .navigationTitle(section.subjectID + " " + section.courseID + " " + section.sectionNumber)
        }
    }
}

#Preview {
    DetailView(section: exampleSection())
}
