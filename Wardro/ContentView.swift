//
//  ContentView.swift
//  Wardro
//
//  Created by Jatin Artwani on 15/10/24.
//

import SwiftUI

struct ContentView: View {
    // The list of emojis to swipe through
    @State private var emojis = ["😀", "🥳", "😎", "🤩", "😍", "🤖", "🐶", "🍕", "🚀"]
    // The current index of the emoji being displayed
    @State private var currentIndex: Int = 0
    // The wishlist is now passed in from MainTabView
    @Binding var wishlist: [String]
    // Message to display after swipe (feedback message)
    @State private var swipeMessage: String? = nil
    // Controls color of the swipe message feedback
    @State private var swipeMessageColor: Color = .green
    // Controls if the swipe message should be visible
    @State private var showSwipeMessage = false

    var body: some View {
        VStack {
            Spacer()
            
            // Show the current emoji inside a card
            if currentIndex < emojis.count {
                ZStack {
                    // The card background
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.white)
                        .shadow(radius: 10)
                        .frame(width: 350, height: 500)
                    
                    // The emoji displayed on top of the card
                    Text(emojis[currentIndex])
                        .font(.system(size: 200))
                        .padding()
                }
                .gesture(
                    DragGesture()
                        .onEnded { value in
                            if value.translation.width < 0 {
                                // Swiped left
                                swipeMessage = "❌"
                                swipeMessageColor = .red
                                showNextEmoji()
                            } else if value.translation.width > 0 {
                                // Swiped right, add to wishlist
                                wishlist.append(emojis[currentIndex])
                                swipeMessage = "Added to wishlist"
                                swipeMessageColor = .green
                                showNextEmoji()
                            }
                        }
                )
            } else {
                // If no more emojis to swipe, show a message
                Text("No more emojis!")
                    .font(.largeTitle)
                    .padding()
            }
            
            Spacer()
            
            // Show swipe feedback (swipeMessage)
            if showSwipeMessage {
                Text(swipeMessage ?? "")
                    .foregroundColor(swipeMessageColor)
                    .font(.headline)
                    .padding()
                    .transition(.opacity)
            }
            
            Spacer()
        }
        .padding()
        .onChange(of: currentIndex) { _ in
            // Show the swipe message for 0.5 seconds, then hide it
            showSwipeMessage = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                showSwipeMessage = false
            }
        }
    }
    
    // Function to move to the next emoji
    func showNextEmoji() {
        if currentIndex < emojis.count - 1 {
            currentIndex += 1
        } else {
            currentIndex = 0 // Go back to the first emoji after the last
        }
    }
}

#Preview {
    ContentView(wishlist: .constant([]))
}





