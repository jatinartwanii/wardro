//
//  CheckoutView.swift
//  Wardro
//
//  Created by Jatin Artwani on 15/10/24.
//

import SwiftUI

struct CheckoutView: View {
    var body: some View {
        VStack {
            Text("Checkout")
                .font(.largeTitle)
                .padding()
            Text("This is the checkout page. Coming soon!")
                .font(.headline)
                .padding()
        }
        .navigationTitle("Checkout")
    }
}

#Preview {
    CheckoutView()
}


