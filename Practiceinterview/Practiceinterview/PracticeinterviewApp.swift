//
//  PracticeinterviewApp.swift
//  Practiceinterview
//
//  Created by Farah Metoui on 5/12/2024.
//

import SwiftUI

@main
struct PracticeinterviewApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                
        }
    }
}
struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }

            SearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }

            ProfileView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
        }
    }
}



struct SearchView: View {
    var body: some View {
        VStack {
            Text("Search for items")
            // Add more search-related UI elements or functionality here
        }
        .padding()
    }
}

struct ProfileView: View {
    var body: some View {
        VStack {
            Text("Your Profile Information")
            // Add user profile-related UI here
        }
        .padding()
    }
}
