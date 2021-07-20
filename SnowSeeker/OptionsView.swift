//
//  OptionsView.swift
//  SnowSeeker
//
//  Created by Brandon Knox on 7/18/21.
//

import SwiftUI

extension String: Identifiable {
    public var id: String { self }
}

struct OptionsView: View {
    @Binding var selectedCountry: String
    @Binding var selectedSize: Int
    @Binding var selectedPrice: Int
    @Binding var sortMethod: SortType
    @Binding var noFilter: Bool
    
    @State var selectedFilter: FilterType = .country
    enum FilterType {
        case country, size, price
    }
    
    let resorts: [Resort] = Bundle.main.decode("resorts.json")
    var allCountries: [String] {
        var countries = [String]()
        for resort in Resort.allResorts {
            countries.append(resort.country)
        }
        return Array(Set(countries)).sorted()
    }
    
    var allSizes: [Int] {
        var sizes = [Int]()
        for resort in Resort.allResorts {
            sizes.append(resort.size)
        }
        return Array(Set(sizes)).sorted()
    }
    
    var allPrices: [Int] {
        var prices = [Int]()
        for resort in Resort.allResorts {
            prices.append(resort.price)
        }
        return Array(Set(prices)).sorted()
    }
    
    var sizeString: String {
        switch selectedSize {
        case 1:
            return "Small"
        case 2:
            return "Average"
        default:
            return "Large"
        }
    }
    
    var priceString: String {
        String(repeating: "$", count: selectedPrice)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Group {
                    Text("Sort selection")
                        .font(.headline)
                    Picker("Sort selection", selection: $sortMethod) {
                        ForEach(SortType.allCases, id: \.self) { sortValue in
                            Text(sortValue.rawValue.capitalized)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    Spacer()
                }
                
                Group {
                    Text("Filter selections")
                        .font(.headline)
                    Text("Country: \(selectedCountry)")
                    Text("Size: \(sizeString)")
                    Text("Price: \(priceString)")
                    Button(action: {
                        noFilter = true
                    }) {
                        Text("Clear Filters")
                    }
                    Spacer()
                }
                
                Group {
                    Text("Filters")
                        .font(.headline)
                    Text("Country")
                    ForEach(allCountries) { country in
                        Button(action: {
                            selectedCountry = country
                            noFilter = false
                        }) {
                            Text(country)
                        }
                    }
                    Text("Size")
                    ForEach(allSizes, id: \.self) { size in
                        Button(action: {
                            selectedSize = size
                            noFilter = false
                        }) {
                            Text(String(size))
                        }
                    }
                    Text("Price")
                    ForEach(allPrices, id: \.self) { price in
                        Button(action: {
                            selectedPrice = price
                            noFilter = false
                        }) {
                            Text(String(price))
                        }
                    }
                }
            }
        }
    }
    
    
}

struct OptionsView_Previews: PreviewProvider {

    static var previews: some View {
        OptionsView(selectedCountry: .constant("France"),
                    selectedSize: .constant(1),
                    selectedPrice: .constant(1),
                    sortMethod: .constant(.alphabetical),
                    noFilter: .constant(true))
    }
}
