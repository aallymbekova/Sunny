//
//  TableViewController.swift
//  Sunny
//
//  Created by darmaraht on 23/11/23.
//

import UIKit

class TableViewController: UITableViewController {
    
    var nameCitiesArray = ["Bishkek", "London", "Japan"]
    var citiesArray = [CurrentWeather]()
    let currentWeather = CurrentWeather()
    
    let networkWeatherManager = NetworkWeatherManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        for city in nameCitiesArray {
            networkWeatherManager.fetchCurrentWeather(forRequestType: .cityName(city: city))
            networkWeatherManager.onCompletion = {[weak self] currentWeather in
                guard let self = self else { return }
                self.citiesArray.append(currentWeather)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            }
        }

   
    }

    @IBAction func searchCityButton(_ sender: UIBarButtonItem) {
        
        self.presentSearchAlertController(withTitle: "Enter city name", message: nil, style: .alert) { city in
            self.networkWeatherManager.fetchCurrentWeather(forRequestType: .cityName(city: city))
            self.networkWeatherManager.onCompletion = { [weak self] currentWeather in
                guard let self = self else { return }
                self.citiesArray.append(currentWeather)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            }
        }
    }
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return citiesArray.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        
        var weather = CurrentWeather()
        weather = citiesArray[indexPath.row]
        
        cell.configure(currentWeather: weather)

        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
   

   

}
