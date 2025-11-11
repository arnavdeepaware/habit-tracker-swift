# Habit Tracker - Visual Guide

## App Architecture Overview

### Navigation Structure
```
TabView (Bottom Navigation)
├── 🔥 Streaks Tab (Default)
│   └── StreakView
│       └── List of ContributionGridView components
│
├── ✓ Today Tab
│   └── TodayView
│       └── List of HabitCheckRow components
│
└── ➕ Add Habit Tab
    └── AddHabitView
        └── Form with habit details
```

## Data Models

### Habit Model
```swift
Habit {
    - id: UUID
    - name: String
    - startDate: Date
    - time: Date
    - notes: String
    - selectedDays: [Int]  // [0-6] where 0=Sunday, 6=Saturday
    - completions: [HabitCompletion]
    
    Methods:
    - isScheduledFor(dayOfWeek:)
    - isCompleted(on:)
    - calculateStreak()
}
```

### HabitCompletion Model
```swift
HabitCompletion {
    - id: UUID
    - date: Date
    - habit: Habit?
}
```

## Page Descriptions

### 1. Streaks Page (Default Landing)

**Purpose**: Visualize habit progress over time

**Features**:
- GitHub-style contribution grid for each habit
- Streak counter with flame icon
- Scrollable horizontal grid
- Shows ~1 year of history (53 weeks)

**Grid Colors**:
- 🟢 Green: Completed day
- ⬜ Gray: Incomplete scheduled day
- 🔲 Light Gray: Not scheduled or before start date
- ⬜ Future: Days that haven't occurred yet

**Empty State**:
- Displays when no habits exist
- Encourages user to add first habit

---

### 2. Today Page

**Purpose**: Daily checklist for completing habits

**Features**:
- Date picker to select any date
- List of habits scheduled for selected day
- Tap circle to mark complete/incomplete
- Strikethrough animation on completion
- Shows habit time and streak count
- Sorted by time of day

**Filtering Logic**:
- Only shows habits scheduled for the selected day of week
- Only shows habits where date >= start date
- Real-time updates when date changes

**Empty State**:
- Displays when no habits scheduled for selected day
- Encourages rest or adding habits

---

### 3. Add Habit Page

**Purpose**: Create new habits

**Form Fields**:
1. **Habit Name** (required)
   - Text field
   - Auto-correct disabled
   
2. **Start Date** (required)
   - Date picker
   - Defaults to today
   - Determines when streak counting begins
   
3. **Time of Day** (required)
   - Time picker
   - Used for sorting in Today view
   
4. **Days of Week** (required)
   - 7 circular buttons (S M T W T F S)
   - Multi-select
   - Green when selected
   - Must select at least 1 day
   
5. **Notes** (optional)
   - Text editor
   - Helpful for reminders or motivations

**Actions**:
- **Clear Button**: Resets all form fields
- **Create Habit Button**: Saves habit to database
  - Disabled until name and days are selected
  - Shows success alert on completion

---

## User Flow Examples

### Creating Your First Habit

```
1. Open app → Lands on Streaks page (empty state)
2. Tap "Add Habit" tab at bottom
3. Enter habit name: "Morning Meditation"
4. Select start date: Today
5. Select time: 7:00 AM
6. Select days: M T W T F (weekdays)
7. Add note: "10 minutes of mindfulness"
8. Tap "Create Habit"
9. Success alert appears
10. Tap "OK" → Form clears
11. Navigate to Streaks tab → See new habit with empty grid
```

### Completing Today's Habits

```
1. Open app → Navigate to "Today" tab
2. See list of today's scheduled habits
3. Complete morning meditation → Tap circle
4. Circle fills green, text strikes through
5. Navigate to Streaks tab
6. See green square appear for today
7. Streak counter updates
```

### Checking Streak History

```
1. Navigate to Streaks tab
2. See all habits listed vertically
3. Scroll horizontally on any grid
4. View up to 1 year of completion history
5. Green squares show consistency
6. Notice gaps where habits were missed
7. See streak count with flame icon
```

---

## Technical Implementation Details

### SwiftData Persistence
- Automatic saving when habits are created
- Automatic saving when completions are toggled
- Data stored locally on device
- No cloud sync (privacy-focused)

### Date Handling
- All dates normalized to start of day
- Timezone-aware calculations
- Calendar-based date arithmetic

### Streak Algorithm
```
1. Start from today, work backwards
2. Check if date is scheduled day of week
3. If scheduled:
   - If completed: increment streak
   - If not completed: break loop
4. Stop at start date or broken streak
5. Return streak count
```

### Grid Generation
- Calculates 53 weeks × 7 days = 371 cells
- Each cell calculates its date relative to today
- Each cell checks completion status from model
- Color determined by: scheduled, completed, future, before-start

---

## Customization Guide

### Change Accent Color
1. Open `Assets.xcassets`
2. Select `AccentColor`
3. Choose your preferred color
4. Affects tab icons, buttons, and selected states

### Modify Grid Size
In `ContributionGridView.swift`:
```swift
let cellSize: CGFloat = 12  // Change to 10 or 15
let spacing: CGFloat = 3    // Change to 2 or 4
let columns = 53            // Change to show more/less weeks
```

### Add New Streak Colors
In `cellColor()` function:
```swift
if isCompleted {
    // Current: green
    return Color.green.opacity(0.8)
    
    // Options:
    // return Color.blue.opacity(0.8)
    // return Color.purple.opacity(0.8)
    // or add intensity levels based on completion count
}
```

### Change Tab Order
In `ContentView.swift`, reorder the TabView items

---

## Performance Considerations

- **Lazy Loading**: Uses `LazyVStack` for efficient scrolling
- **Query Optimization**: SwiftData queries are indexed
- **Date Caching**: Calendar calculations are minimal
- **Memory Management**: Preview content uses in-memory storage

---

## Accessibility Features

- **SF Symbols**: System icons scale with text size
- **Dynamic Type**: All text respects user font size preferences
- **VoiceOver**: Standard SwiftUI components are accessible
- **Color Contrast**: Default colors meet WCAG guidelines

---

## Testing in Xcode

### Preview Multiple States
Use Xcode previews to test:
- Empty states
- Single habit
- Multiple habits
- Different completion patterns

### Simulator Testing
1. Run on iPhone 15 Pro simulator
2. Test date picker interactions
3. Test completion toggles
4. Test form validation
5. Test horizontal scrolling

### Device Testing
1. Install on physical iPhone
2. Test with real daily usage
3. Verify persistence across app launches
4. Test offline functionality

---

## Debugging Tips

### Check SwiftData Storage
```swift
// Add breakpoint in Habit.swift init
// Inspect created habits

// Add print statements in completion toggle
print("Toggling completion for \(habit.name) on \(date)")
```

### View Database State
```swift
// In StreakView
.onAppear {
    print("Loaded \(habits.count) habits")
    habits.forEach { habit in
        print("- \(habit.name): \(habit.completions?.count ?? 0) completions")
    }
}
```

### Monitor Memory
- Use Xcode's Memory Graph Debugger
- Check for retain cycles in model relationships
- Profile with Instruments for performance issues

---

## FAQ

**Q: Can I edit a habit after creating it?**
A: Not in the current version. You would need to add an edit feature.

**Q: What happens if I miss a day?**
A: Your streak resets to 0. Start fresh the next day!

**Q: Can I delete habits?**
A: You would need to add swipe-to-delete functionality.

**Q: Does data sync across devices?**
A: No, data is stored locally. iCloud sync could be added.

**Q: Can I set reminders?**
A: Not yet. Local notifications could be implemented.

**Q: How far back does history go?**
A: The grid shows ~1 year, but all data is stored indefinitely.

---

## Next Steps

Once you have the app running:
1. Add your first habit
2. Use it daily for a week
3. Watch your streaks grow
4. Add more habits gradually
5. Customize colors and sizes to your preference

Enjoy building your habits! 🚀
