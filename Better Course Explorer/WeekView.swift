//
//  WeekView.swift
//  Better Course Explorer
//
//  Created by Lehan Yang on 2/9/24.
//

import SwiftUI
import course_explorer_api

struct Event {
    let dayIndex: Int // Index of the day in the week (0 for Sunday, 1 for Monday, etc.)
    let startHour: Double // Start hour of the event
    let endHour: Double // End hour of the event
    let color: Color // Color of the event block
}

struct EventBlockView: View {
    let event: Event
    let cellWidth: CGFloat // Width of each cell in the calendar
    let cellHeight: CGFloat // Height of each cell in the calendar
    
    var body: some View {
        Rectangle()
            .foregroundColor(event.color)
            .frame(width: cellWidth, height: CGFloat(event.endHour - event.startHour) * cellHeight)
            .offset(y: CGFloat(event.startHour) * cellHeight)
    }
}

struct WeekCalendarView: View {
    let hoursOfDay = Array(stride(from: 7, through: 21.5, by: 0.5))
    let daysOfTheWeek = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    
    let events: [Event]
    
    var body: some View {
        VStack(spacing: 0) {
            ForEach(hoursOfDay, id: \.self) { hour in
                HStack(spacing: 0) {
                    if (hour.truncatingRemainder(dividingBy:1.0) == 0) {
                        Text("\(Int(hour)):00")
                            .frame(width: 50, alignment: .trailing)
                    } else {
                        Text("")
                            .frame(width: 50, alignment: .trailing)
                    }
                    ForEach(self.daysOfTheWeek.indices, id: \.self) { dayIndex in
                        Rectangle()
                            .stroke(Color.gray)
                            .frame(maxWidth: .infinity)
                            .overlay(self.eventBlock(for: dayIndex, hour: hour))
                    }
                }
                .frame(maxWidth: .infinity)
            }
        }
        .padding()
    }
    
    func eventBlock(for dayIndex: Int, hour: Double) -> some View {
        if let event = events.first(where: { $0.dayIndex == dayIndex && $0.startHour <= hour && $0.endHour > hour }) {
            return AnyView(EventBlockView(event: event, cellWidth: (UIScreen.main.bounds.width-100) / 7, cellHeight: (UIScreen.main.bounds.width-150) / 30)
                .frame(maxWidth: .infinity))
        } else {
            return AnyView(EmptyView())
        }
    }
}

struct WeekView: View {
    //let courseSections: [CourseSection]
    
    let events = [
        Event(dayIndex: 1, startHour: 7, endHour: 10, color: .blue),
            Event(dayIndex: 2, startHour: 9, endHour: 12, color: .green),
            Event(dayIndex: 3, startHour: 11, endHour: 15, color: .red)
        ]
    
    var body: some View {
        VStack {
            WeekCalendarView(events: events)
                .border(Color.gray)
                .padding()
        }
    }
}

struct WeekView_preview: PreviewProvider {
    static var previews: some View {
        WeekView()
    }
}
