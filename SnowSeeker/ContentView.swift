//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Brandon Knox on 7/11/21.
//

import SwiftUI

// For a real challenge, let the user sort and filter the resorts in ContentView. For sorting use default, alphabetical, and country, and for filtering let them select country, size, or price.

struct ContentView: View {
    @ObservedObject var favorites = Favorites()
    let resorts: [Resort] = Bundle.main.decode("resorts.json")
    @State private var sortName = false
    @State private var selectedCountry = "France"
    @State private var selectedSize = 1
    @State private var selectedPrice = 1
    @State private var showingOptions = false
    
    let filter: FilterType
    
    enum FilterType {
        case country, size, price
    }
    
    var filteredResorts: [Resort] {
        switch filter {
        case .country:
            if sortName {
                return resorts.sorted()
            } else {
                return resorts.sorted { (lhs: Resort, rhs: Resort) -> Bool in
                    return lhs.id > rhs.id
                }.filter { $0.country == selectedCountry }
            }
        case .size:
            if sortName {
//                return resorts.sorted().filter { $0.isContacted }
                return resorts.sorted()
            } else {
                return resorts.sorted { (lhs: Resort, rhs: Resort) -> Bool in
                    return lhs.id > rhs.id
                }.filter { $0.size == selectedSize }
            }
        case .price:
            if sortName {
                return resorts.sorted()
            } else {
                return resorts.sorted { (lhs: Resort, rhs: Resort) -> Bool in
                    return lhs.id > rhs.id
                }.filter { $0.price == selectedPrice }
            }
        }
    }
    
    var body: some View {
        NavigationView {
            List(filteredResorts) { resort in
                NavigationLink(destination: ResortView(resort: resort)) {
                    Image(resort.country)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40, height: 25)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                        .overlay(RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color.black, lineWidth: 1)
                        )
                
                    VStack(alignment: .leading) {
                        Text(resort.name)
                            .font(.headline)
                        
                        Text("\(resort.runs) runs")
                            .foregroundColor(.secondary)
                    }
                    .layoutPriority(1)
                    
                    if self.favorites.contains(resort) {
                        Spacer()
                        Image(systemName: "heart.fill")
                            .accessibility(label: Text("This is a favorite resort"))
                            .foregroundColor(.red)
                    }
                }
            }
            .navigationBarTitle("Resorts")
            .navigationBarItems(trailing: Button(action: {
                showingOptions = true
            }) {
                Text("View Options")
            })
            .sheet(isPresented: $showingOptions) {
                OptionsView(selectedCountry: $selectedCountry, selectedSize: $selectedSize, selectedPrice: $selectedPrice)
            }
            
            WelcomeView()
        }
        .environmentObject(favorites)
//        .phoneOnlyStackNavigationView()  // optional way of overriding default display behavior in phones
    }
}

extension View {
    func phoneOnlyStackNavigationView() -> some View {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return AnyView(self.navigationViewStyle(StackNavigationViewStyle()))
        } else {
            return AnyView(self)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(filter: .country)
    }
}
