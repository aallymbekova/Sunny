//
//  TableViewCell.swift
//  Sunny
//
//  Created by darmaraht on 23/11/23.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var cityImageView: UIImageView!
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var cityDescription: UILabel!
    @IBOutlet weak var cityTemperature: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(currentWeather: CurrentWeather) {
        self.cityName.text = currentWeather.cityName
        self.cityTemperature.text = currentWeather.cityTempratureString + "ºC"
        self.cityDescription.text = currentWeather.description
        self.cityImageView.image = UIImage(systemName: currentWeather.systemIconNameString)
    }

}
