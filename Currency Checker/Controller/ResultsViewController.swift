//
//  ResultsViewController.swift
//  Currency Checker
//
//  Created by Gabriel Castillo Serafim on 1/9/22.
//

import UIKit

class ResultsViewController: UIViewController {
    
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var fromCurrencyLabel: UILabel!
    @IBOutlet weak var toCurrencyLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    
    var total: Double?
    var rate: Double?
    var fromCurrency: String?
    var toCurrency: String?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        totalLabel.text = String(format: "%.2f", total!)
        rateLabel.text = String(format: "%.2f", rate!)
        fromCurrencyLabel.text = fromCurrency
        toCurrencyLabel.text = toCurrency
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
}
