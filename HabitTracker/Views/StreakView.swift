//
//  StreakView.swift
//  HabitTracker
//
//  Created on 11/11/2025.
//

import SwiftUI
import SwiftData

struct StreakView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Habit.createdAt, order: .forward) private var habits: [Habit]
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.systemGroupedBackground)
                    .ignoresSafeArea()
                
                if habits.isEmpty {
                    VStack(spacing: 20) {
                        Image(systemName: "calendar.badge.plus")
                            .font(.system(size: 60))
                            .foregroundColor(.gray)
                        
                        Text("No Habits Yet")
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        Text("Start building your habits by adding one!")
                            .font(.body)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                    }
                } else {
                    ScrollView {
                        LazyVStack(spacing: 16) {
                            ForEach(habits) { habit in
                                ContributionGridView(habit: habit)
                                    .padding(.horizontal)
                            }
                        }
                        .padding(.vertical)
                    }
                }
            }
            .navigationTitle("Habit Streaks")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

#Preview {
    StreakView()
        .modelContainer(for: [Habit.self, HabitCompletion.self], inMemory: true)
}
