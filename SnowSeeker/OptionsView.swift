//
//  OptionsView.swift
//  SnowSeeker
//
//  Created by Brandon Knox on 7/18/21.
//

import SwiftUI

struct OptionsView: View {
    @Binding var selectedCountry: String
    @Binding var selectedSize: Int
    @Binding var selectedPrice: Int
    
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
    
    
}

struct OptionsView_Previews: PreviewProvider {
//    @State static var selectedCountry = "France"
//    @State static var selectedSize = 1
//    @State static var selectedPrice = 1

    static var previews: some View {
        OptionsView(selectedCountry: .constant("France"), selectedSize: .constant(1), selectedPrice: .constant(1))
    }
}
