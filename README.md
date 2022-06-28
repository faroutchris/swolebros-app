# swole_app

A flutter app

# Installation

### 1: Install the required command line tools

Install the Firebase CLI.
Log into Firebase using your Google account by running the following command:

`firebase login`

Install the FlutterFire CLI by running the following command from any directory:

`dart pub global activate flutterfire_cli`

### 2: Configure your apps to use Firebase

Use the FlutterFire CLI to configure your Flutter apps to connect to Firebase.
From your Flutter project directory, run the following command to start the app configuration workflow:

`flutterfire configure`

### 3: Setup firebase

Run firestore init if .firebaserc does not exist/is linked to a firebase project

`firebase init`

Enable the following features

- Firestore
- Functions
- Storage
- Emulators

Enable the following emulators

- Authentication Emulator
- Functions Emulator
- Firestore Emulator
- Storage Emulator

### 4: Install packages

Install packages for flutter

`flutter pub get`

Install IOS deps

`cd ios && pod install`

Install firebase functions packages

`cd functions && npm install`

# Development

### 1: With firebase emulator

Make sure you've built the firebase functions at least once

In /functions

`npm run build`

Start emulator services

`firebase emulators:start`

### 2: Run app

`flutter run -d <deviceId> --flavor <prod/staging/dev> -t <entryFile>`

Or use the launch configuration in VSCode

# Build & distribute

TODO
