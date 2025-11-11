//
//  ContributionGridView.swift
//  HabitTracker
//
//  Created on 11/11/2025.
//

import SwiftUI

struct ContributionGridView: View {
    let habit: Habit
    let columns = 53 // Number of weeks to show (approximately 1 year)
    let cellSize: CGFloat = 12
    let spacing: CGFloat = 3
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(habit.name)
                .font(.headline)
                .fontWeight(.semibold)
            
            HStack(spacing: 2) {
                Text("\(habit.calculateStreak()) day streak")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                Image(systemName: "flame.fill")
                    .font(.caption)
                    .foregroundColor(.orange)
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: spacing) {
                    ForEach(0..<columns, id: \.self) { weekIndex in
                        VStack(spacing: spacing) {
                            ForEach(0..<7, id: \.self) { dayIndex in
                                contributionCell(weekIndex: weekIndex, dayIndex: dayIndex)
                            }
                        }
                    }
                }
                .padding(.vertical, 4)
            }
            
            if !habit.notes.isEmpty {
                Text(habit.notes)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .padding(.top, 4)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 2)
    }
    
    @ViewBuilder
    private func contributionCell(weekIndex: Int, dayIndex: Int) -> some View {
        let date = dateForCell(weekIndex: weekIndex, dayIndex: dayIndex)
        let calendar = Calendar.current
        let dayOfWeek = calendar.component(.weekday, from: date) - 1
        let isScheduled = habit.isScheduledFor(dayOfWeek: dayOfWeek)
        let isCompleted = habit.isCompleted(on: date)
        let isFutureDate = date > Date()
        let isBeforeStartDate = date < calendar.startOfDay(for: habit.startDate)
        
        RoundedRectangle(cornerRadius: 2)
            .fill(cellColor(isScheduled: isScheduled, isCompleted: isCompleted, isFutureDate: isFutureDate, isBeforeStartDate: isBeforeStartDate))
            .frame(width: cellSize, height: cellSize)
    }
    
    private func dateForCell(weekIndex: Int, dayIndex: Int) -> Date {
        let calendar = Calendar.current
        let today = Date()
        
        // Calculate the date based on weeks and days from today
        let daysFromToday = -(weekIndex * 7 + (6 - dayIndex))
        return calendar.date(byAdding: .day, value: daysFromToday, to: today) ?? today
    }
    
    private func cellColor(isScheduled: Bool, isCompleted: Bool, isFutureDate: Bool, isBeforeStartDate: Bool) -> Color {
        if isBeforeStartDate {
            return Color(.systemGray6)
        }
        
        if isFutureDate {
            return Color(.systemGray5)
        }
        
        if !isScheduled {
            return Color(.systemGray6)
        }
        
        if isCompleted {
            return Color.green.opacity(0.8)
        }
        
        return Color(.systemGray4)
    }
}
