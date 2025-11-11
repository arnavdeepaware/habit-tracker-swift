//
//  TodayView.swift
//  HabitTracker
//
//  Created on 11/11/2025.
//

import SwiftUI
import SwiftData

struct TodayView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Habit.time, order: .forward) private var allHabits: [Habit]
    
    @State private var selectedDate = Date()
    
    var todaysHabits: [Habit] {
        let calendar = Calendar.current
        let dayOfWeek = calendar.component(.weekday, from: selectedDate) - 1
        
        return allHabits.filter { habit in
            let isScheduled = habit.isScheduledFor(dayOfWeek: dayOfWeek)
            let isAfterStartDate = selectedDate >= calendar.startOfDay(for: habit.startDate)
            return isScheduled && isAfterStartDate
        }
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.systemGroupedBackground)
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    // Date Picker
                    DatePicker(
                        "Select Date",
                        selection: $selectedDate,
                        displayedComponents: .date
                    )
                    .datePickerStyle(.compact)
                    .padding()
                    .background(Color(.systemBackground))
                    
                    if todaysHabits.isEmpty {
                        VStack(spacing: 20) {
                            Image(systemName: "checkmark.circle")
                                .font(.system(size: 60))
                                .foregroundColor(.gray)
                            
                            Text("No Habits Today")
                                .font(.title2)
                                .fontWeight(.semibold)
                            
                            Text("Enjoy your free day or add habits for this day of the week!")
                                .font(.body)
                                .foregroundColor(.secondary)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal)
                        }
                        .frame(maxHeight: .infinity)
                    } else {
                        ScrollView {
                            LazyVStack(spacing: 12) {
                                ForEach(todaysHabits) { habit in
                                    HabitCheckRow(habit: habit, date: selectedDate)
                                }
                            }
                            .padding()
                        }
                    }
                }
            }
            .navigationTitle(formattedDate)
            .navigationBarTitleDisplayMode(.large)
        }
    }
    
    private var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMM d"
        return formatter.string(from: selectedDate)
    }
}

struct HabitCheckRow: View {
    @Environment(\.modelContext) private var modelContext
    let habit: Habit
    let date: Date
    
    @State private var isCompleted: Bool = false
    
    var body: some View {
        HStack(spacing: 16) {
            // Checkbox
            Button(action: toggleCompletion) {
                Image(systemName: isCompleted ? "checkmark.circle.fill" : "circle")
                    .font(.system(size: 32))
                    .foregroundColor(isCompleted ? .green : .gray)
            }
            .buttonStyle(.plain)
            
            // Habit Info
            VStack(alignment: .leading, spacing: 4) {
                Text(habit.name)
                    .font(.headline)
                    .strikethrough(isCompleted)
                    .foregroundColor(isCompleted ? .secondary : .primary)
                
                HStack(spacing: 12) {
                    Label(formattedTime, systemImage: "clock")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    if !habit.notes.isEmpty {
                        Label("Has notes", systemImage: "note.text")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    
                    HStack(spacing: 2) {
                        Text("\(habit.calculateStreak())")
                            .font(.caption)
                            .fontWeight(.semibold)
                        Image(systemName: "flame.fill")
                            .font(.caption)
                    }
                    .foregroundColor(.orange)
                }
            }
            
            Spacer()
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 2)
        .onAppear {
            isCompleted = habit.isCompleted(on: date)
        }
        .onChange(of: date) { oldValue, newValue in
            isCompleted = habit.isCompleted(on: newValue)
        }
    }
    
    private var formattedTime: String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: habit.time)
    }
    
    private func toggleCompletion() {
        let calendar = Calendar.current
        let targetDate = calendar.startOfDay(for: date)
        
        if isCompleted {
            // Remove completion
            if let completions = habit.completions {
                if let completionToRemove = completions.first(where: { completion in
                    calendar.isDate(completion.date, inSameDayAs: targetDate)
                }) {
                    modelContext.delete(completionToRemove)
                }
            }
        } else {
            // Add completion
            let newCompletion = HabitCompletion(date: targetDate)
            newCompletion.habit = habit
            modelContext.insert(newCompletion)
            
            if habit.completions == nil {
                habit.completions = []
            }
            habit.completions?.append(newCompletion)
        }
        
        do {
            try modelContext.save()
            isCompleted.toggle()
        } catch {
            print("Failed to save completion: \(error)")
        }
    }
}

#Preview {
    TodayView()
        .modelContainer(for: [Habit.self, HabitCompletion.self], inMemory: true)
}
