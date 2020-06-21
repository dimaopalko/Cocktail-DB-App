//
//  Drink.swift
//  Cocktail DB App
//
//  Created by Dima Opalko on 20.06.2020.
//  Copyright © 2020 Dima Opalko. All rights reserved.
//

import Foundation
import UIKit

struct Drinks: Decodable {
    var drinks: [Drink]
}

struct Drink: Decodable {
    let strDrink: String
    let strDrinkThumb: String
}
