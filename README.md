# Weather

This app uses [Weather API](https://www.weatherapi.com/) to fetch weather data and features MVVM architecture, SwiftUI, local-package-based modular design and comprehensive unit tests. 

## Quick Start

Follow these steps to get started:

1. **Clone the Repository**
   ```bash
   git clone https://github.com/wdesimini/Weather.git
   cd weather
   ```

2. **Open the Project in Xcode**
   Open the `.xcodeproj` file in Xcode.

3. **Add Your API Key**
   - Navigate to `APIService.swift` located in the `Networking` package.
   - Replace `WEATHER_API_KEY` with your actual API key:
     ```swift
     public enum APIEnvironment {
         public static let key = "WEATHER_API_KEY"
     }
     ```

4. **Run the App**
   - Select a simulator or a connected device.
   - Build and run the app using the play button in Xcode or by pressing `Cmd + R`.

## Features

### MVVM Architecture
Uses a combination of dependency-injected `@Observable` ViewModels and async/await-based Services.

### Modular Local Packages
The project is divided into reusable Swift packages, making it easier to maintain, scale, and test.

### Unit Testing
Includes unit tests for ViewModels and Services using the XCTest framework. Mock services are provided to test ViewModels in isolation.

