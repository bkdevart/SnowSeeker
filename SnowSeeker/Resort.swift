//
//  Resort.swift
//  SnowSeeker
//
//  Created by Brandon Knox on 7/13/21.
//

import Foundation

struct Resort: Codable, Identifiable, Comparable {
    static func < (lhs: Resort, rhs: Resort) -> Bool {
        lhs.name < rhs.name
    }
    
    let id: String
    let name: String
    let country: String
    let description: String
    let imageCredit: String
    let price: Int
    let size: Int
    let snowDepth: Int
    let elevation: Int
    let runs: Int
    let facilities: [String]
    
    var facilityTypes: [Facility] {
        facilities.map(Facility.init)
    }
    
    var allCountries: [String] {
        var countries = [String]()
        for resort in Resort.allResorts {
            countries.append(resort.country)
        }
        return Array(Set(countries))
    }
    
    static let allResorts: [Resort] = Bundle.main.decode("resorts.json")
    static let example = allResorts[0]
    
    
}
