# evApp
This Flutter app displays information about Electric Vehicle (EV) charging stations. It fetches data from a mock API and presents a list of charging stations with details like name, power type, wattage, and status. Users can view station details and see their profile information.

## Features

- Fetches charging station data from a mock API.
- Displays a list of charging stations with key details.
- Allows users to view detailed information about a specific charging station.
- Shows user profile information and provides a logout option.

## Prerequisites

- Flutter installed on your machine. [Flutter Installation Guide](https://flutter.dev/docs/get-started/install)
- IDE with Flutter and Dart plugins (e.g., Visual Studio Code, Android Studio).
- Mobile emulator or physical device for testing.

## Getting Started

1. Clone the repository:

    ```bash
    git clone [https://github.com/Gauravpandey001/evApp.git]
    ```

2. Change directory:

    ```bash
    cd EvChargingApplication
    ```

3. Run the app:

    ```bash
    flutter run
    ```

4. Explore the app on your emulator or physical device.

## Dependencies

- `flutter/material.dart` for building the UI.
- `http` package for making HTTP requests.
- `get` package for navigation management.
- `firebase_core` package for Firebase initialization.

## Structure

- `main.dart`: Entry point of the application.
- `login_screen.dart`: Contains the login page UI and logic.
- `home_page.dart`: Displays the list of charging stations and user profile.
- `charging_station_details.dart`: Shows detailed information about a specific charging station.

## Notes

- The app currently fetches data from a mock API (https://mocki.io/v1/d86221e4-6755-4666-96ba-bf88b61a3cdc). Replace this with your actual data source.
- The user profile section and logout functionality are placeholders. Implement actual authentication and user management as needed.

Feel free to explore and customize the app according to your requirements!
