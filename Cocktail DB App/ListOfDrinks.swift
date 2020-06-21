//
//  ListOfDrinks.swift
//  Cocktail DB App
//
//  Created by Dima Opalko on 20.06.2020.
//  Copyright © 2020 Dima Opalko. All rights reserved.
//

import Foundation

struct Filters: Decodable {
    
    let drinks: [Category]
    
}
struct Category: Codable {
    
    let categoryName: String
    
    private enum CodingKeys: String, CodingKey {
        case categoryName = "strCategory"
        
    }
}



