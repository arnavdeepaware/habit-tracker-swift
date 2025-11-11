//
//  ContentView.swift
//  HabitTracker
//
//  Created on 11/11/2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            StreakView()
                .tabItem {
                    Label("Streaks", systemImage: "flame.fill")
                }
            
            TodayView()
                .tabItem {
                    Label("Today", systemImage: "checkmark.circle.fill")
                }
            
            AddHabitView()
                .tabItem {
                    Label("Add Habit", systemImage: "plus.circle.fill")
                }
        }
        .tint(.green)
    }
}

#Preview {
    ContentView()
}
