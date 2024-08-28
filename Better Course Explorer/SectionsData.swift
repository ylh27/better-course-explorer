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
    @Published var lastSuccess: Date = Date.now
    @Published var years: [String] = []
    @Published var buildingNames: [String] = []
    
    func fetchBuildingNames() -> Set<String> {
        var list: Set<String> = []
        for course in courses {
            for section in course.sections {
                for meeting in section.meetings {
                    list.insert(meeting.buildingName)
                }
            }
        }
        return list
    }
    
    func fetchSemester(baseURL: String, year: String, semester: String) {
        DispatchQueue.global().async {
            print("fetching data for " + year + " " + semester)
            traverseSemester(urlPrefix: baseURL+"/"+year+"/"+semester) { list in
                if list == nil {
                    print("nil list returned")
                    return
                } else {
                    DispatchQueue.main.async {
                        self.courses = list!
                        self.lastSuccess = Date.now
                        self.buildingNames = self.fetchBuildingNames().sorted()
                    }
                    print("list updated to full semester")
                    print(String(self.courses.count) + " secitons")
                    print("building names listed")
                    return
                }
            }
        }
    }
    
    func fetchSubjectData(baseURL: String, year: String, semester: String, subject: String) {
        DispatchQueue.global().async {
            print("fetching data")
            traverseSubject(urlPrefix: baseURL+"/"+year+"/"+semester+"/"+subject) { list in
                print("fetched data")
                if list == nil {
                    print("nil data")
                    return
                } else {
                    DispatchQueue.main.async {
                        self.courses = list!
                        self.lastSuccess = Date.now
                    }
                    print("great success!")
                    print(String(self.courses.count) + " sections")
                    return
                }
            }
        }
    }
    
    func getYearsList(baseURL: String) {
        DispatchQueue.global().async {
            print("fetching years list")
            getYears(urlPrefix: baseURL) { list in
                print("fetched years")
                if list == nil {
                    print("nil data")
                    return
                } else {
                    DispatchQueue.main.async {
                        self.years = list!
                    }
                    print("fetched years!")
                    print(String(self.years.count) + " years")
                    print(self.years)
                    return
                }
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
    
    func buildingsSave() {
        let buildingEncoder = JSONEncoder()
        if let buildingEncoded = try? buildingEncoder.encode(buildingNames) {
            let defaults = UserDefaults.standard
            defaults.set(buildingEncoded, forKey: "SavedBuildings")
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
        if let savedBuildings = defaults.object(forKey: "SavedBuildings") as? Data {
            let decoder = JSONDecoder()
            if let loadedBuildings = try? decoder.decode([String].self, from: savedBuildings) {
                self.buildingNames = loadedBuildings
            }
        }
    }
}
