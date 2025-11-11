//
//  HabitCompletion.swift
//  HabitTracker
//
//  Created on 11/11/2025.
//

import Foundation
import SwiftData

@Model
final class HabitCompletion {
    var id: UUID
    var date: Date
    var habit: Habit?
    
    init(date: Date) {
        self.id = UUID()
        self.date = date
    }
}
