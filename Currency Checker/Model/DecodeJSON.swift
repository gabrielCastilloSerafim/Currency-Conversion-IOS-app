//
//  DecodeJSON.swift
//  Currency Checker
//
//  Created by Gabriel Castillo Serafim on 1/9/22.
//

import Foundation

struct DecodeJSON:Codable {
    let total:Double
    let quote:Double
    let base_currency: String
    let quote_currency: String
}
