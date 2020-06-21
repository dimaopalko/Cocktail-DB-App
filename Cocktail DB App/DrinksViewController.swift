//
//  DrinksViewController.swift
//  Cocktail DB App
//
//  Created by Dima Opalko on 20.06.2020.
//  Copyright © 2020 Dima Opalko. All rights reserved.
//

import UIKit

class DrinksViewController: UITableViewController {
    
    let networkManager = NetworkManager()
    var listOfDrinks: [Drink] = []
    var listOfCategories: [Category]? = []
    var sectionData:[[Drink]] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        downloadData()
    }
    
    func downloadData() {
        fetchCategories()
        fetchDrinks(url: "https://www.thecocktaildb.com/api/json/v1/1/filter.php?c=Ordinary%20Drink")
    }
    func fetchCategories() {
           networkManager.getListOfDrinks { [weak self] (list) in
               self?.listOfCategories = list?.drinks
               DispatchQueue.main.async {
                   self?.tableView.reloadData()
               }
           }
       }
       
       func fetchDrinks(url: String) {
           
           self.networkManager.getDrinks(url: url, complition: { [weak self] (drinksList) in
               self?.listOfDrinks = drinksList ?? []
               self?.sectionData.append(self?.listOfDrinks ?? [])
               DispatchQueue.main.async {
                   self?.tableView.reloadData()
               }
           })
       }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sectionData.count
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 20))
        view.backgroundColor = UIColor.white
        let label = UILabel(frame: CGRect(x: 15, y: 0, width: tableView.bounds.width - 30, height: 20))
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = UIColor.black
        if section < listOfCategories!.count {
            label.text = listOfCategories![section].categoryName
        } else {
            label.text = nil
        }
        view.addSubview(label)
        return view
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionData[section].count - 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "drinkCell", for: indexPath)
        let cellText = sectionData[indexPath.section][indexPath.row]
        cell.textLabel?.text = cellText.strDrink
        cell.imageView?.image = UIImage(named: "drink")
        cell.imageView?.downloaded(from: cellText.strDrinkThumb)
        return cell
    }
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
