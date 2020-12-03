//
//  Summary.swift
//  CovidLookup
//
//  Created by Liubov Kaper  on 12/3/20.
//

import Foundation


// Decodable is part of Codable
struct SummaryWrapper: Codable {
    var countries: [Summary]
    //Codingkeys allow us to rensme properties
    enum CodingKeys: String, CodingKey {
        case countries = "Countries"
    }
}

struct Summary: Codable {
    let country: String
    let totalConfirmed: Int
    let totalRecovered: Int
    
    enum CodingKeys: String, CodingKey {
        case country = "Country"
        case totalConfirmed = "TotalConfirmed"
        case totalRecovered = "TotalRecovered"
    }
}
