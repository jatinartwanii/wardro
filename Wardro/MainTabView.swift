//
//  MainTabView.swift
//  Wardro
//
//  Created by Jatin Artwani on 15/10/24.
//

import SwiftUI

struct MainTabView: View {
    // Wishlist is a shared state across multiple tabs
    @State private var wishlist: [String] = []
    
    var body: some View {
        VStack {
            
            // App Title at the top
            Text("Wardro.")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 10)
            
            // Subtitle beneath the title
            Text("Personalized fashion recommendations")
                .font(.subheadline)
                .foregroundColor(.gray)
                .padding(.top, -20)
            
            Spacer() // Creates space between the title and the tabs
            
            // Tab View for the bottom navigation
            TabView {
                // Home (Swiping Page)
                ContentView(wishlist: $wishlist)
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }
                
                // Wishlist Page
                WishlistView(wishlist: $wishlist)
                    .tabItem {
                        Label("Wishlist", systemImage: "heart")
                    }
                
                // Checkout Page (Placeholder)
                CheckoutView()
                    .tabItem {
                        Label("Checkout", systemImage: "cart")
                    }
                
                // Profile Page (Placeholder)
                ProfileView()
                    .tabItem {
                        Label("Profile", systemImage: "person")
                    }
            }
            .accentColor(.black)
            .padding(.top, -1) // Slight padding to remove space above the tab bar
        }
    }
}

#Preview {
    MainTabView()
}

