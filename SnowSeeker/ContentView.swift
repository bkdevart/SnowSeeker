//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Brandon Knox on 7/11/21.
//

import SwiftUI

struct UserView: View {
    var body: some View {
        Group {
            Text("Name: Paul")
            Text("Country: England")
            Text("Pets: Luna, Arya, and Toby")
        }
    }
}

struct ContentView: View {
    @State private var layoutVertically = false
    
    var body: some View {
        Group {
            if layoutVertically {
                VStack {
                    UserView()
                }
            } else {
                HStack {
                    UserView()
                }
            }
        }
        .onTapGesture {
            self.layoutVertically.toggle()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
