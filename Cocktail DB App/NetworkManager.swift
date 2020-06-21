//
//  NetworkService.swift
//  Cocktail DB App
//
//  Created by Dima Opalko on 20.06.2020.
//  Copyright © 2020 Dima Opalko. All rights reserved.
//

import Foundation

class NetworkManager {
    
    func getDrinks(url: String, complition: @escaping ([Drink]?) -> Void) {
        let url = url
        if let url = URL(string: url) {
            URLSession.shared.dataTask(with: url) { ( data, responce, error) in
                if let data = data {
                    do {
                        let responce = try JSONDecoder().decode(Drinks.self, from: data)
                        let drinksList = responce.drinks
                        print(drinksList)
                        complition(drinksList)
                    } catch {
                        complition(nil)
                        print(error)
                    }
                }
            }.resume()
        }
    }
    
    func getListOfDrinks(complition: @escaping (Filters?) -> Void) {
        let url = "https://www.thecocktaildb.com/api/json/v1/1/list.php?c=list"
        if let url = URL(string: url) {
            URLSession.shared.dataTask(with: url) { ( data, responce, error) in
                if let data = data {
                    do {
                        let list = try JSONDecoder().decode(Filters.self, from: data)
                        complition(list)
                    } catch {
                        complition(nil)
                        print(error)
                    }
                }
            }.resume()
        }
    }
}
