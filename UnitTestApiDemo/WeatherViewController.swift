//
//  WeatherViewController.swift
//  UnitTestApiDemo
//
//  Created by Ganesh on 12/07/23.
//

import UIKit

final class WeatherViewController: UIViewController {
    
    @IBOutlet weak var lblTemperature: UILabel!
    
    private let viewModel: WeatherViewModel
        
    init(viewModel: WeatherViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.temperatureChanged = { [weak self] descriptionText in
            DispatchQueue.main.async {
                self?.lblTemperature.text = descriptionText
            }
        }
        
        viewModel.onStart()
    
    }
    
    @IBAction func tapGetWeather(_ sender: Any) {
        viewModel.getCurrentTemperature()
    }
}


