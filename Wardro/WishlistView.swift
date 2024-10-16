//
//  WishlistView.swift
//  Wardro
//
//  Created by Jatin Artwani on 15/10/24.
//

import SwiftUI

struct WishlistView: View {
    // Use @Binding so that changes to the wishlist are reflected back in ContentView
    @Binding var wishlist: [String]
    
    var body: some View {
        VStack {
            if wishlist.isEmpty {
                Text("Your wishlist is empty!")
                    .font(.headline)
                    .padding()
            } else {
                List {
                    ForEach(wishlist, id: \.self) { emoji in
                        Text(emoji)
                            .font(.system(size: 50))
                            .padding()
                    }
                    .onDelete(perform: removeFromWishlist) // Enable swipe-to-delete
                }
            }
        }
        .navigationTitle("Wishlist")
        .padding()
        .toolbar { // Add an edit button to enable swipe-to-delete
            EditButton()
        }
    }
    
    // Function to remove an emoji from the wishlist
    func removeFromWishlist(at offsets: IndexSet) {
        wishlist.remove(atOffsets: offsets)
    }
}

#Preview {
    WishlistView(wishlist: .constant(["😀", "🥳"]))
}




