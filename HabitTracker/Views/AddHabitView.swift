//
//  AddHabitView.swift
//  HabitTracker
//
//  Created on 11/11/2025.
//

import SwiftUI
import SwiftData

struct AddHabitView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var habitName = ""
    @State private var startDate = Date()
    @State private var habitTime = Date()
    @State private var notes = ""
    @State private var selectedDays: Set<Int> = []
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    let daysOfWeek = [
        (0, "S", "Sunday"),
        (1, "M", "Monday"),
        (2, "T", "Tuesday"),
        (3, "W", "Wednesday"),
        (4, "T", "Thursday"),
        (5, "F", "Friday"),
        (6, "S", "Saturday")
    ]
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Habit Details") {
                    TextField("Habit Name", text: $habitName)
                        .autocorrectionDisabled()
                    
                    DatePicker("Start Date", selection: $startDate, displayedComponents: .date)
                    
                    DatePicker("Time of Day", selection: $habitTime, displayedComponents: .hourAndMinute)
                }
                
                Section("Days of Week") {
                    HStack(spacing: 12) {
                        ForEach(daysOfWeek, id: \.0) { day in
                            DayButton(
                                day: day.1,
                                fullName: day.2,
                                isSelected: selectedDays.contains(day.0)
                            ) {
                                if selectedDays.contains(day.0) {
                                    selectedDays.remove(day.0)
                                } else {
                                    selectedDays.insert(day.0)
                                }
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 8)
                }
                
                Section("Notes (Optional)") {
                    TextEditor(text: $notes)
                        .frame(minHeight: 100)
                }
                
                Section {
                    Button(action: saveHabit) {
                        HStack {
                            Spacer()
                            Text("Create Habit")
                                .fontWeight(.semibold)
                            Spacer()
                        }
                    }
                    .disabled(habitName.isEmpty || selectedDays.isEmpty)
                }
            }
            .navigationTitle("Add New Habit")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Clear") {
                        clearForm()
                    }
                }
            }
            .alert("Success", isPresented: $showAlert) {
                Button("OK") {
                    clearForm()
                }
            } message: {
                Text(alertMessage)
            }
        }
    }
    
    private func saveHabit() {
        guard !habitName.isEmpty else {
            alertMessage = "Please enter a habit name."
            showAlert = true
            return
        }
        
        guard !selectedDays.isEmpty else {
            alertMessage = "Please select at least one day."
            showAlert = true
            return
        }
        
        let newHabit = Habit(
            name: habitName,
            startDate: Calendar.current.startOfDay(for: startDate),
            time: habitTime,
            notes: notes,
            selectedDays: Array(selectedDays).sorted()
        )
        
        modelContext.insert(newHabit)
        
        do {
            try modelContext.save()
            alertMessage = "Habit '\(habitName)' created successfully!"
            showAlert = true
        } catch {
            alertMessage = "Failed to save habit: \(error.localizedDescription)"
            showAlert = true
        }
    }
    
    private func clearForm() {
        habitName = ""
        startDate = Date()
        habitTime = Date()
        notes = ""
        selectedDays = []
    }
}

struct DayButton: View {
    let day: String
    let fullName: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                Text(day)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(isSelected ? .white : .primary)
                    .frame(width: 40, height: 40)
                    .background(isSelected ? Color.green : Color(.systemGray5))
                    .clipShape(Circle())
                
                Text(fullName.prefix(3))
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    AddHabitView()
        .modelContainer(for: [Habit.self, HabitCompletion.self], inMemory: true)
}
