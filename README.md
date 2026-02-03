# AdVista

AdVista is a SwiftUI iOS MVP built to explore and analyze ad creatives.
The goal of this project is to demonstrate fast execution, clean architecture,
and realistic data handling using Firebase and CSV seed data.

---

## ✨ Features

- Browse ad creatives with key KPIs
- Dashboard / overview screen
- Creatives list and detail views
- Dynamic data loading
- Firebase (Firestore) integration
- CSV seed data import
- Switch between **CSV data source** and **Firebase data source**
- Clean SwiftUI interface (Apple-style)

---

## 🧠 Architecture

- **SwiftUI**
- **MVVM**
- Modular feature-based structure
- Clear separation of concerns:
  - Views
  - ViewModels
  - Services
  - Models

---

## 📦 Data Sources

The application supports **two data sources**:

1. **CSV (local)**
   - Uses the CSV file provided in the assignment
   - Parsed and mapped into domain models
   - Useful for local testing and MVP setup

2. **Firebase (Firestore)**
   - The CSV data is treated as *seed / fake data*
   - Imported into Firestore as structured documents (JSON)
   - The app can fetch creatives directly from Firestore
   - A **switch** allows changing the active data source at runtime

> Firestore is used only as a data source for this MVP  
> (no authentication or advanced backend logic).

---

## 🔥 Firebase Setup

- Firebase is initialized using the standard iOS SDK
- Configuration is done via `GoogleService-Info.plist`
- No admin credentials are used or exposed
- Firestore is used in read mode for this test

---

## 📁 Project Structure

```
AdVista/                ← repo root
├── AdVista/            ← app source root
│   ├── App/
│   ├── Core/
│   ├── DesignSystem/
│   ├── Features/
│   ├── Navigation/
│   ├── Resources/
│   ├── Preview/
│   ├── Assets.xcassets/
│   └── Preview Content/
├── AdVista.xcodeproj/
├── AdVistaTests/
└── AdVistaUITests/

```

---

## ▶️ Build & Run

1. Open `AdVista.xcodeproj` in Xcode
2. Select the **AdVista** scheme
3. Choose an **iOS simulator (iOS 18.2+)**
4. Run the app (`Cmd + R`)

---

## 🧪 MVP Scope & Trade-offs

- Focused on **core functionality and execution**
- UI kept simple and clean (no heavy animations)
- Firebase usage kept minimal and pragmatic
- CSV import logic adapted to Firestore constraints (JSON documents)

This approach reflects a **realistic MVP mindset**:  
shipping something functional, extensible, and easy to iterate on.

---

## 🛠 Tools

- SwiftUI
- Firebase (Firestore)
- Xcode
- Codex CLI (used to accelerate development)

---

## 📌 Notes

This project was built as a **1-day MVP test**.
Improvements such as authentication, advanced filtering,
offline caching, or pagination can easily be added if needed.

---
