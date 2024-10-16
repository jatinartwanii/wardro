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
    // Track the drag offset for the swiping animation
    @State private var dragOffset: CGSize = .zero
    // Control opacity for smooth transition during swipe
    @State private var cardOpacity: Double = 1.0

    var body: some View {
        VStack {
            Spacer()
            
            // Show the current emoji inside a card
            if currentIndex < emojis.count {
                ZStack {
                    // The card background
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.white)
                        .shadow(radius: 10)
                        .frame(width: 300, height: 400)
                        .offset(x: dragOffset.width) // Move the card as per the drag offset
                        .rotationEffect(.degrees(Double(dragOffset.width / 20))) // Add a slight rotation effect
                        .opacity(cardOpacity) // Control opacity for smooth disappearance
                        .gesture(
                            DragGesture()
                                .onChanged { value in
                                    dragOffset = value.translation // Track drag offset
                                }
                                .onEnded { value in
                                    if value.translation.width < -100 {
                                        // Swiped left, remove the card with animation
                                        swipeLeft()
                                    } else if value.translation.width > 100 {
                                        // Swiped right, add to wishlist and remove the card with animation
                                        swipeRight()
                                    } else {
                                        // Return the card to the center if the drag was not far enough
                                        resetCardPosition()
                                    }
                                }
                        )
                    
                    // The emoji displayed on top of the card
                    Text(emojis[currentIndex])
                        .font(.system(size: 100))
                        .padding()
                        .offset(x: dragOffset.width) // Move the emoji with the card
                        .rotationEffect(.degrees(Double(dragOffset.width / 20))) // Rotate the emoji with the card
                        .opacity(cardOpacity)
                }
                .animation(.spring()) // Add smooth spring animation for transitions
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
            // Show the swipe message for 1.5 seconds, then hide it
            showSwipeMessage = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                showSwipeMessage = false
            }
        }
    }
    
    // Function to handle swipe left (dismiss the card)
    func swipeLeft() {
        withAnimation {
            dragOffset = CGSize(width: -500, height: 0) // Move card off the screen to the left
            cardOpacity = 0 // Fade out the card
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            showNextEmoji()
            resetCardPosition()
        }
        swipeMessage = "❌"
        swipeMessageColor = .red
    }
    
    // Function to handle swipe right (add to wishlist and dismiss the card)
    func swipeRight() {
        withAnimation {
            dragOffset = CGSize(width: 500, height: 0) // Move card off the screen to the right
            cardOpacity = 0 // Fade out the card
        }
        wishlist.append(emojis[currentIndex])
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            showNextEmoji()
            resetCardPosition()
        }
        swipeMessage = "Added to wishlist"
        swipeMessageColor = .green
    }
    
    // Function to move to the next emoji
    func showNextEmoji() {
        if currentIndex < emojis.count - 1 {
            currentIndex += 1
        } else {
            currentIndex = 0 // Go back to the first emoji after the last
        }
    }
    
    // Function to reset card position after a failed swipe attempt
    func resetCardPosition() {
        withAnimation {
            dragOffset = .zero // Reset position to center
            cardOpacity = 1.0 // Restore opacity
        }
    }
}

#Preview {
    ContentView(wishlist: .constant([]))
}






