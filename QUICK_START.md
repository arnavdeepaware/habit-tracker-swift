# Quick Start Guide - Habit Tracker

## Opening the Project in Xcode

### Step 1: Locate the Project
```bash
cd /Users/arnav/Desktop/projects/habit-tracker-swift
```

### Step 2: Open in Xcode
**Option A - Command Line:**
```bash
open HabitTracker.xcodeproj
```

**Option B - Finder:**
1. Open Finder
2. Navigate to `/Users/arnav/Desktop/projects/habit-tracker-swift`
3. Double-click `HabitTracker.xcodeproj`

**Option C - Xcode:**
1. Open Xcode
2. File → Open
3. Navigate to the project folder
4. Select `HabitTracker.xcodeproj`
5. Click "Open"

---

## Running on iOS Simulator

### Step 1: Select Simulator
- In Xcode's top toolbar, click the device dropdown (next to "HabitTracker")
- Choose any iPhone simulator (recommended: **iPhone 15 Pro**)

### Step 2: Build and Run
- Click the Play button (▶️) or press `Cmd + R`
- Wait for the build to complete
- The simulator will launch automatically
- Your app will open on the simulated iPhone

### Step 3: Test the App
1. You'll land on the Streaks page (empty at first)
2. Tap "Add Habit" tab at the bottom
3. Create your first habit
4. Go back to Streaks tab to see the contribution grid
5. Go to Today tab to mark it complete

---

## Running on Your Physical iPhone

### Prerequisites
- iPhone with iOS 17 or later
- USB cable to connect iPhone to Mac
- Apple ID (free is fine)

### Step 1: Connect iPhone
1. Connect your iPhone to your Mac using USB cable
2. Unlock your iPhone
3. If prompted "Trust This Computer?" → Tap "Trust"
4. Enter your iPhone passcode if requested

### Step 2: Set Up Code Signing
1. In Xcode, select the project file (blue icon at top of navigator)
2. Select "HabitTracker" under TARGETS
3. Click the "Signing & Capabilities" tab
4. Check "Automatically manage signing"
5. Under "Team", select your Apple ID
   - If you don't see your Apple ID:
     - Click "Add Account..."
     - Sign in with your Apple ID
     - Select it as your team

### Step 3: Select Your iPhone
- In Xcode's top toolbar, click the device dropdown
- Your iPhone should appear at the top of the list
- Select it (e.g., "Arnav's iPhone")

### Step 4: Build and Run
1. Click the Play button (▶️) or press `Cmd + R`
2. Wait for the build to complete
3. Xcode will install the app on your iPhone
4. The app will launch automatically

### Step 5: Trust Developer (First Time Only)
If this is your first time running a self-signed app:

1. On your iPhone, you'll see "Untrusted Developer" alert
2. Go to **Settings** → **General** → **VPN & Device Management**
3. Under "Developer App", tap your Apple ID
4. Tap "Trust [Your Apple ID]"
5. Confirm by tapping "Trust" again
6. Return to home screen
7. Open the Habit Tracker app

---

## Troubleshooting

### Problem: "Failed to prepare device for development"
**Solution:**
- Disconnect and reconnect your iPhone
- Restart Xcode
- Make sure your iPhone is unlocked

### Problem: "No signing certificate found"
**Solution:**
- Go to Xcode → Settings → Accounts
- Sign in with your Apple ID
- Download manual profiles if prompted

### Problem: "Unable to install [app name]"
**Solution:**
- Delete any existing version of the app from iPhone
- Try building again
- Check that your iPhone has enough storage

### Problem: "Minimum deployment target"
**Solution:**
- Update your iPhone to iOS 17 or later
- Or modify deployment target in project settings (not recommended)

### Problem: Build fails with SwiftData errors
**Solution:**
- Clean build folder: Product → Clean Build Folder (Cmd + Shift + K)
- Close and reopen Xcode
- Ensure all files are included in target

### Problem: App crashes on launch
**Solution:**
- Check Console log in Xcode for error messages
- Verify all model files are present
- Try running in simulator first to isolate issue

---

## Verifying Installation

### Check Files Exist
Run in Terminal:
```bash
ls -R /Users/arnav/Desktop/projects/habit-tracker-swift/HabitTracker/
```

You should see:
- HabitTrackerApp.swift
- ContentView.swift
- Models/Habit.swift
- Models/HabitCompletion.swift
- Views/StreakView.swift
- Views/TodayView.swift
- Views/AddHabitView.swift
- Views/Components/ContributionGridView.swift

### Check Project Builds
1. In Xcode: Product → Build (Cmd + B)
2. Wait for compilation
3. Should see "Build Succeeded" message
4. Check for any warnings or errors in the Issue Navigator

---

## Using the App

### Creating Your First Habit

1. **Open the app** (it launches on Streaks page)

2. **Tap "Add Habit" tab** (bottom right, plus icon)

3. **Fill in the form:**
   - **Habit Name**: "Morning Run" (or anything you want)
   - **Start Date**: Leave as today (or choose a date)
   - **Time of Day**: Choose when you typically do this habit
   - **Days of Week**: Tap circles to select days (e.g., M-T-W-T-F)
   - **Notes**: Optional (e.g., "30 minutes, before breakfast")

4. **Tap "Create Habit"**
   - Success alert appears
   - Form clears
   - Ready to add another habit (optional)

5. **Go to Streaks tab**
   - See your new habit listed
   - See the contribution grid (mostly gray since it's new)

6. **Go to Today tab**
   - See your habit listed (if today is a selected day)
   - Tap the circle to mark it complete
   - Circle turns green, text strikes through
   - Go back to Streaks tab to see green square for today

### Tips for Daily Use

1. **Morning Routine:**
   - Open app
   - Go to Today tab
   - Complete your morning habits

2. **Throughout Day:**
   - Check back to complete habits as you do them

3. **Evening Review:**
   - Go to Streaks tab
   - Review your progress
   - Feel motivated by the green squares

4. **Weekly Planning:**
   - Add new habits on Sunday/Monday
   - Adjust your routine as needed

---

## App Features Summary

| Feature | Location | What It Does |
|---------|----------|--------------|
| View Streaks | Streaks Tab | See all habits with contribution grids |
| Check Today's Habits | Today Tab | See and complete today's scheduled habits |
| Add New Habit | Add Habit Tab | Create a new habit to track |
| Mark Complete | Today Tab | Tap circle next to habit |
| View History | Streaks Tab | Scroll grid horizontally |
| See Streak Count | Streaks Tab | Number with flame icon |

---

## What Makes This App Special?

✅ **GitHub-Style Visualization**: Just like developer contribution graphs, but for your habits

✅ **Flexible Scheduling**: Choose which days each habit applies to

✅ **Privacy-Focused**: All data stays on your device, no accounts needed

✅ **Simple & Beautiful**: Clean design, easy to use daily

✅ **Motivating**: Watch your streaks grow, visual progress tracking

✅ **Offline-First**: No internet required, works anywhere

---

## Next Steps

1. ✅ Open project in Xcode
2. ✅ Run on simulator or iPhone
3. ✅ Create 2-3 habits to start
4. ✅ Use daily for a week
5. ✅ Watch your streaks grow!

Optional enhancements you could add:
- Edit existing habits
- Delete habits (swipe to delete)
- Habit categories/colors
- Statistics dashboard
- Export data as CSV
- Notifications/reminders
- iCloud sync
- Widgets
- Apple Watch app

---

## Need Help?

If you encounter any issues:

1. **Check the README.md** for detailed documentation
2. **Review VISUAL_GUIDE.md** for understanding the architecture
3. **Clean and rebuild** the project in Xcode
4. **Restart Xcode** if things seem stuck
5. **Check Console logs** for error messages
6. **Try simulator first** before testing on device

---

## Success Checklist

Before considering the project complete, verify:

- [ ] Project opens in Xcode without errors
- [ ] Project builds successfully (Cmd + B)
- [ ] App runs in iOS simulator
- [ ] Can create a new habit
- [ ] Can see habit on Streaks page
- [ ] Can see habit on Today page
- [ ] Can mark habit as complete
- [ ] Completion shows as green square in grid
- [ ] Data persists when app is closed and reopened
- [ ] All three tabs are accessible

---

**You're all set! Enjoy tracking your habits! 🎉**
