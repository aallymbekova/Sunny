//
//  SettingsViewController.swift
//  Sunny
//
//  Created by darmaraht on 24/11/23.
//

import UIKit

enum Theme: Int {
    case device
    case light
    case dark
    
    func getUserIntarfaceStyle() -> UIUserInterfaceStyle {
        
        switch self {
        case .device:
            return .unspecified
        case .light:
            return .light
        case .dark:
            return .dark
        }
    }
}

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var changeModeLabel: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: "backgroundColor")
        
        changeModeLabel.selectedSegmentIndex = MTUserDefaults.shared.theme.rawValue
     
    }

    
    @IBAction func changeMode(_ sender: UISegmentedControl) {
        
        MTUserDefaults.shared.theme = Theme(rawValue: sender.selectedSegmentIndex) ?? .device
        view.window?.overrideUserInterfaceStyle = MTUserDefaults.shared.theme.getUserIntarfaceStyle()
    }
    
}

