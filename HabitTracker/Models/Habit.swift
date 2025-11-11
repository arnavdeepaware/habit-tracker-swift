//
//  Habit.swift
//  HabitTracker
//
//  Created on 11/11/2025.
//

import Foundation
import SwiftData

@Model
final class Habit {
    var id: UUID
    var name: String
    var startDate: Date
    var time: Date
    var notes: String
    var selectedDays: [Int] // 0 = Sunday, 1 = Monday, ..., 6 = Saturday
    var createdAt: Date
    
    @Relationship(deleteRule: .cascade) var completions: [HabitCompletion]?
    
    init(name: String, startDate: Date, time: Date, notes: String, selectedDays: [Int]) {
        self.id = UUID()
        self.name = name
        self.startDate = startDate
        self.time = time
        self.notes = notes
        self.selectedDays = selectedDays
        self.createdAt = Date()
        self.completions = []
    }
    
    // Helper function to check if habit is scheduled for a specific day of week
    func isScheduledFor(dayOfWeek: Int) -> Bool {
        return selectedDays.contains(dayOfWeek)
    }
    
    // Helper function to check if habit is completed on a specific date
    func isCompleted(on date: Date) -> Bool {
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.year, .month, .day], from: date)
        
        guard let completions = completions else { return false }
        
        return completions.contains { completion in
            let completionComponents = calendar.dateComponents([.year, .month, .day], from: completion.date)
            return dateComponents.year == completionComponents.year &&
                   dateComponents.month == completionComponents.month &&
                   dateComponents.day == completionComponents.day
        }
    }
    
    // Calculate current streak
    func calculateStreak() -> Int {
        let calendar = Calendar.current
        var streak = 0
        var currentDate = calendar.startOfDay(for: Date())
        
        while currentDate >= startDate {
            let dayOfWeek = calendar.component(.weekday, from: currentDate) - 1
            
            if isScheduledFor(dayOfWeek: dayOfWeek) {
                if isCompleted(on: currentDate) {
                    streak += 1
                } else {
                    break
                }
            }
            
            guard let previousDay = calendar.date(byAdding: .day, value: -1, to: currentDate) else {
                break
            }
            currentDate = previousDay
        }
        
        return streak
    }
}
