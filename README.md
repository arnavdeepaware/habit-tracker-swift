# Habit Tracker - iOS App

A beautiful iOS habit tracking app with GitHub-style contribution streaks. Built with SwiftUI and SwiftData for iOS 17+.

## Features

### 🔥 Streak Page (Default)
- **GitHub-style contribution grid** for each habit
- Visual representation with green squares for completed days
- Gray squares for incomplete/skipped days
- Display current streak count with flame icon
- Scrollable grid showing up to 1 year of history

### ➕ Add Habit Page
- Create new habits with:
  - Habit name
  - Start date (when streak counting begins)
  - Time of day
  - Optional notes
  - Days of week selection (choose which days the habit applies)

### ✅ Today Page
- View all habits scheduled for the selected day
- Mark habits as complete with a simple tap
- Habits automatically cross off when completed
- Shows habit time and current streak
- Date picker to view/complete habits from other days
- Sorted by time of day

## Requirements

- **Xcode 15.0+**
- **iOS 17.0+**
- **iPhone only** (optimized for iPhone)

## Installation & Setup

### Option 1: Open in Xcode

1. **Open the project:**
   ```bash
   cd /Users/arnav/Desktop/projects/habit-tracker-swift
   open HabitTracker.xcodeproj
   ```

2. **Select your target device:**
   - In Xcode, select your iPhone from the device dropdown (top toolbar)
   - Or select an iPhone simulator (iPhone 15 Pro recommended)

3. **Run the app:**
   - Press `Cmd + R` or click the Play button
   - The app will build and launch on your selected device/simulator

### Option 2: Run on Your Physical iPhone

1. **Connect your iPhone** to your Mac via USB

2. **Trust your computer** on your iPhone (if prompted)

3. **Set up code signing** in Xcode:
   - Open the project in Xcode
   - Select the project in the navigator (blue icon)
   - Select the "HabitTracker" target
   - Go to "Signing & Capabilities" tab
   - Check "Automatically manage signing"
   - Select your Apple ID team

4. **Select your iPhone** from the device dropdown

5. **Build and Run** (Cmd + R)

6. **Trust the developer** on your iPhone:
   - Go to Settings > General > VPN & Device Management
   - Tap on your developer profile
   - Tap "Trust"

## Project Structure

```
HabitTracker/
├── HabitTrackerApp.swift          # App entry point with SwiftData setup
├── ContentView.swift              # Main tab view navigation
├── Models/
│   ├── Habit.swift                # Habit data model
│   └── HabitCompletion.swift      # Completion tracking model
├── Views/
│   ├── StreakView.swift           # Main streak page
│   ├── TodayView.swift            # Daily habit checklist
│   ├── AddHabitView.swift         # Add new habit form
│   └── Components/
│       └── ContributionGridView.swift  # GitHub-style grid component
└── Assets.xcassets/               # App icons and colors
```

## Technology Stack

- **SwiftUI**: Modern declarative UI framework
- **SwiftData**: Apple's latest data persistence framework
- **iOS 17+**: Latest iOS features and APIs

## Key Features Explained

### Streak Calculation
- Streaks are calculated based on consecutive completions
- Only counts days where the habit is scheduled (selected days of week)
- Starts counting from the habit's start date
- Breaks when a scheduled day is missed

### GitHub-Style Visualization
- Each cell represents one day
- Green cells = completed
- Gray cells = incomplete or not scheduled
- Light gray cells = before start date or future dates
- Horizontal scrolling to view full history

### Data Persistence
- All data is stored locally on your iPhone using SwiftData
- Data persists between app launches
- No internet connection required
- Privacy-focused (no data leaves your device)

## Usage Tips

1. **Start Small**: Add 1-3 habits to begin with
2. **Be Realistic**: Choose achievable days of the week
3. **Use Notes**: Add helpful reminders or motivations
4. **Check Daily**: Use the Today tab to complete your habits
5. **Track Progress**: Watch your streaks grow on the Streak page

## Customization Ideas

You can customize the app by modifying:
- **Colors**: Change accent colors in `Assets.xcassets`
- **Grid Size**: Adjust `cellSize` in `ContributionGridView.swift`
- **Streak Colors**: Modify the `cellColor` function for different color schemes
- **Number of Weeks**: Change `columns` variable to show more/less history

## Troubleshooting

### "Cannot run on device"
- Ensure your iPhone is running iOS 17 or later
- Check that your Apple ID is signed in to Xcode

### "Build failed"
- Clean build folder: Product > Clean Build Folder (Cmd + Shift + K)
- Restart Xcode
- Make sure all files are included in the target

### "App crashes on launch"
- Check that SwiftData models are properly configured
- Verify iOS deployment target is set to 17.0

## Future Enhancements

Potential features to add:
- Edit/delete habits
- Statistics and insights
- Habit categories/tags
- Notifications/reminders
- Export data
- Dark mode customization
- Widgets for home screen
- Multiple streak colors based on intensity

## License

This project is open source and available for personal use and modification.

## Contact

For questions or suggestions, please open an issue on GitHub.

---

**Built with ❤️ using Swift and SwiftUI**