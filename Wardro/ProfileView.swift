//
//  ProfileView.swift
//  Wardro
//
//  Created by Jatin Artwani on 15/10/24.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        VStack {
            Text("Profile")
                .font(.largeTitle)
                .padding()
            Text("This is the profile page. Coming soon!")
                .font(.headline)
                .padding()
        }
        .navigationTitle("Profile")
    }
}

#Preview {
    ProfileView()
}


