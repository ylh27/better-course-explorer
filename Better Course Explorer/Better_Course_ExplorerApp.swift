//
//  Better_Course_ExplorerApp.swift
//  Better Course Explorer
//
//  Created by Lehan Yang on 1/10/24.
//

import SwiftUI

@main
struct Better_Course_ExplorerApp: App {
    @StateObject private var sectionsData = SectionsData()
    
    var body: some Scene {
        WindowGroup {
            ContentView(sectionsData: sectionsData)
                /*.task {
                    sectionsData.load()
                }
                .onChange(of: sectionsData.courses) { _ in
                    sectionsData.save()
                }*/
        }
    }
}
