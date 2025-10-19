# Posts App

This is a simple SwiftUI project that fetches posts from a public API and lets users:
- View a list of posts  
- Search posts by title  
- Open a post to view its details  
- Mark or unmark posts as favorites  

---

## ⚙️ Project Setup

1. Open the project in **Xcode 15.0** or later.  
2. Build and run on an iOS **16.2+** simulator or device.  

**Tech stack:** Swift 5.9, SwiftUI, MVVM architecture.

---

## 🧩 Architecture Overview

The app is built using the **MVVM (Model–View–ViewModel)** pattern to keep the code modular and easy to maintain.

- **Model** – Contains data structures and entities (`Post`, `FavoriteManager`)  
- **ViewModel** – Handles data fetching, state management, and user actions (`PostsViewModel`)  
- **View** – Responsible for displaying UI and binding to the ViewModel (`PostsListView`, `PostDetailView`)

This structure keeps logic separate from UI, making the project scalable and testable.

---

## 🌐 API

All posts are fetched from the public endpoint:  
`https://jsonplaceholder.typicode.com/posts`

Each post includes a user ID, title, and body text.

---

## 💭 Assumptions & Possible Improvements

### Assumptions
- The API is always available and returns valid data.  

### Improvements (if more time was available)
- Add pagination
- Improve UI with better theming and subtle animations.  

---

**Developed by Ishank Tyagi**  
Built with **SwiftUI** following the **MVVM** design pattern.
