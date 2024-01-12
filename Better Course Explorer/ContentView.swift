//
//  ContentView.swift
//  Better Course Explorer
//
//  Created by Lehan Yang on 1/10/24.
//

import SwiftUI
import course_explorer_api

struct ContentView: View {
    @State private var sections: [CourseSection] = []
    
    var body: some View {
        NavigationStack {
            List {
                NavigationLink(destination: ListView(sections: sections)) {
                    Text("ListView")
                }
                Text(String(sections.count) + " Sections Fetched")
                Button {
                    fetchData()
                } label: {
                    Text("Fetch")
                }
            }
        }
    }
    
    func fetchData() {
        print("fetching data")
        traverseSubject(urlPrefix: "https://courses.illinois.edu/cisapp/explorer/schedule/2024/spring/AAS") { list in
            print("fetched data")
            if list == nil {
                print("nil data")
                return
            } else {
                self.sections = list!
                print("great success!")
                print(String(self.sections.count) + " sections")
                return
            }
        }
    }

}

#Preview {
    ContentView()
}
