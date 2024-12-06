//
//  Product.swift
//  Practiceinterview
//
//  Created by Farah Metoui on 6/12/2024.
//

import Foundation


struct Product : Identifiable, Codable {
    
    let id: Int
    let title : String
    let price : Double
    let description : String
    let image : String
    let category : String
    let rating : Rating
}
