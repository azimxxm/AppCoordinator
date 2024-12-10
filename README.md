# Your App with SwiftUI UIKit Navigation Integration

This project demonstrates how to integrate **SwiftUI** with **UIKit Navigation** using `AppCoordinator.swift`. The app uses `AppCoordinator` to handle navigation flows, providing a clean and modular way to manage views in the application.

---

## Key Features

- **UIKit Navigation Integration**: Combines SwiftUI's declarative UI with UIKit's navigation capabilities.
- **Centralized Navigation Control**: Uses an `AppCoordinator` to manage app-wide navigation logic.
- **Dynamic Root View Management**: Dynamically sets the root view with customizable properties like navigation bar visibility.
- **Easy Customization**: Allows developers to add new flows or update existing ones with minimal code changes.

---

## Code Overview

The app's entry point uses `@UIApplicationDelegateAdaptor` and `AppCoordinator` to define the root view for the navigation.

### Example Entry Point

```swift
import SwiftUI
import AppCoordinator

let coordinator = AppCoordinator()

@main
struct YourAppName: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            coordinator.setRootView(RootScreen(), setNavBarHidden: true)
        }
    }
}
```

### Explanation

1. **`AppCoordinator`**:
   - Manages navigation and transitions.
   - The `setRootView(_:setNavBarHidden:)` method sets the `RootScreen` as the initial screen.
   - The `setNavBarHidden: true` hides the navigation bar for the root screen.

2. **`RootScreen`**:
   - Replace `RootScreen` with your app's starting view.
   - Use SwiftUI for declarative UI development, wrapped in UIKit navigation when necessary.

3. **`@UIApplicationDelegateAdaptor`**:
   - Integrates the `AppDelegate` for handling application lifecycle events.

---

## How to Set Up

### Prerequisites

- Xcode 14.0 or later.
- iOS 15.0+.

Here is a `INSTALL_SPM_PACKAGE.md` document to guide you on how to add and configure an SPM (Swift Package Manager) package in your iOS project.

---

# Installing a Swift Package Manager (SPM) Package in Your iOS Project

This guide explains how to add a Swift Package Manager (SPM) dependency to your iOS project in Xcode.

---

## Steps to Add an SPM Package

1. **Open Your Project in Xcode**
   - Launch Xcode and open your iOS project.

2. **Navigate to Package Dependencies**
   - Select your project in the Project Navigator.
   - Go to the **Project Settings** and select your target.
   - Click the **"Package Dependencies"** tab.

3. **Add a New Package**
   - Click the **"+"** button at the bottom left of the **Package Dependencies** section.

4. **Enter Package URL**
   - In the dialog that appears, enter the **Git repository URL** of the package. Example:
     ```
     https://github.com/azimxxm/AppCoordinator.git
     ```

5. **Select Dependency Version**
   - Choose the version rule for the package:
     - **Up to Next Major Version** (recommended for most cases).
     - **Exact Version** (if you need a specific version).
     - **Branch or Commit** (for development versions).
   - Click **Next**.

6. **Add the Package to Your Target**
   - Select the target(s) to which you want to add the package and click **Finish**.

---

## How to Use the Package in Your Code

Once the package is installed, you can use its modules in your Swift files:

1. **Import the Module**
   ```swift
   import AppCoordinator
   ```


---

## Updating a Package

To update the package to a newer version:

1. **Go to Package Dependencies**
   - In Xcode, select your project and go to the **Package Dependencies** tab.

2. **Select the Package**
   - Click the package you want to update and select **Update Package**.

---

## Removing a Package

If you no longer need a package:

1. **Navigate to Package Dependencies**
   - Go to the **Package Dependencies** tab in your project settings.

2. **Remove the Package**
   - Select the package and click the **"-"** button to remove it.

---

## Common Issues and Solutions

- **"Missing Package" Error**: Ensure you have internet access and that the repository URL is correct.
- **Build Errors After Adding a Package**: Check that the package version is compatible with your Xcode and Swift version.
- **Module Not Found**: Ensure you’ve imported the package correctly and added it to the correct target.

---

If you have any questions or encounter issues, refer to the package's official documentation or contact the package maintainer.

---

## How to Use

### Navigation Structure

The `AppCoordinator` handles the navigation logic. To add or modify navigation flows:

1. Open `AppCoordinator.swift`.
2. Use the `start()` method to define the initial view or flow.
3. Add new methods to handle specific navigation cases, e.g., pushing, presenting modals, or replacing root views.

### SwiftUI Views Integration

SwiftUI views can be added by wrapping them in `UIHostingController`. Example:

```swift
func showHomeScreen() {
    let homeView = HomeView()
    let hostingController = UIHostingController(rootView: homeView)
    navigationController.pushViewController(hostingController, animated: true)
}
```

---

## Key Concepts

### 1. `AppCoordinator`
The heart of the app's navigation. It manages a `UINavigationController` to transition between views.

### 2. UIKit-SwiftUI Bridge
SwiftUI views are embedded into UIKit's navigation stack using `UIHostingController`.

### 3. Modular Navigation
Each navigation step is encapsulated in methods, allowing for easy updates and debugging.

---

## Customization

- **Add New Features**:
  - Extend `AppCoordinator` for new flows.
  - Add SwiftUI views and wrap them in `UIHostingController`.
- **Dynamic Navigation**:
  - Add logic in `AppCoordinator` for deep linking or conditional flows.

---

## Contribution

Contributions are welcome! If you have suggestions or improvements, please submit a pull request.

---