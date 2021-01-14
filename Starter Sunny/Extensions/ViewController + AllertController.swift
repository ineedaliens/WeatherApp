//
//  ViewController + AllertController.swift
//  Starter Sunny
//
//  Created by Евгений Сергеевич on 10.01.2021.
//

import UIKit


// MARK: EXTENSION FOR VIEW CONTROLLER
extension ViewController {
    
    // MARK: FUNC PRESENT SEARCH ALERT CONTROLLER
    func presentSearchAlertController(withTitle title: String?, message: String?, style: UIAlertController.Style, complitionHandler: @escaping (String) -> Void) {
        // create alert controller
        let ac = UIAlertController(title: title, message: message, preferredStyle: style)
        // add text field in alert controller
        ac.addTextField { textField in
            // create array of cities
            let cities = ["New York" , "London","Vena","Peru","Kair","Moscow","Tokyo"]
            // add placeholder in text field
            textField.placeholder = cities.randomElement()
        }
        // create search button for allert controller
        let search = UIAlertAction(title: "Search", style: .default, handler: {_ in
            // create textField constant
            let textField = ac.textFields?.first
            // get non optional 
            guard let cityName = textField?.text else { return }
            if cityName != ""{
                // create new constant with replace cymbol space
                let city = cityName.split(separator: " ").joined(separator: "%20")
                complitionHandler(city)
            }
        })
        // create cancel button for alert controller
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        // add action for alert controller
        ac.addAction(search)
        ac.addAction(cancel)
        // present alert controller in view controller
        present(ac, animated: true, completion: nil)
    }
}
