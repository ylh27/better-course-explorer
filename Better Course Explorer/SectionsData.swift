//
//  SectionsData.swift
//  Better Course Explorer
//
//  Created by Lehan Yang on 1/13/24.
//

import Foundation
import course_explorer_api

class SectionsData: ObservableObject {
    @Published var courses: [Course] = []
    
    func fetchSubjectData(baseURL: String, year: String, semester: String, subject: String) {
        print("fetching data")
        traverseSubject(urlPrefix: baseURL+"/"+year+"/"+semester+"/"+subject) { list in
            print("fetched data")
            if list == nil {
                print("nil data")
                return
            } else {
                self.courses = list!
                print("great success!")
                print(String(self.courses.count) + " sections")
                return
            }
        }
    }
    
    func save() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(courses) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: "SavedCourses")
        }
    }
    
    func load() {
        let defaults = UserDefaults.standard
        if let savedCourses = defaults.object(forKey: "SavedCourses") as? Data {
            let decoder = JSONDecoder()
            if let loadedCourses = try? decoder.decode([Course].self, from: savedCourses) {
                self.courses = loadedCourses
            }
        }
    }
}
