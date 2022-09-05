//
//  ViewController.swift
//  Currency Checker
//
//  Created by Gabriel Castillo Serafim on 30/8/22.
//

import UIKit

class CurrencyViewController: UIViewController {
    
    
    @IBOutlet weak var currencyFieldOne: UITextField!
    @IBOutlet weak var currencyFieldTwo: UITextField!
    @IBOutlet weak var amountTextField: UITextField!
    
    var curentRoll1 = 0
    var curentRoll2 = 0
    
    var pickerView1 = UIPickerView()
    var pickerView2 = UIPickerView()
    var dataStruct = DataStruct()
    var networking = Networking()
    
    var total: Double?
    var rate: Double?
    var fromCurrency: String?
    var toCurrency: String?
    
    lazy var currencies = dataStruct.currenciesForDisplay
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        amountTextField.delegate = self
        currencyFieldOne.delegate = self
        currencyFieldTwo.delegate = self
        pickerView1.delegate = self
        pickerView1.dataSource = self
        pickerView2.delegate = self
        pickerView2.dataSource = self
        networking.delegate = self
        
        //Setup for toolBar accessory used on pickerView and numpad.
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1)
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(self.donePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([ spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        currencyFieldOne.inputView = pickerView1
        currencyFieldOne.inputAccessoryView = toolBar
        currencyFieldTwo.inputView = pickerView2
        currencyFieldTwo.inputAccessoryView = toolBar
        amountTextField.inputAccessoryView = toolBar
        
        //Tags to identify which element is interacting.
        pickerView1.tag = 1
        pickerView2.tag = 2
        currencyFieldOne.tag = 1
        currencyFieldTwo.tag = 2
        
    }
    
    @IBAction func convertButtonPressed(_ sender: UIButton) {
        
        let currency1 = curentRoll1
        let currency2 = curentRoll2
        let amount = amountTextField.text!
        
        if currencyFieldOne.text != "" && currencyFieldOne.text != "-" && currencyFieldTwo.text != "" && currencyFieldTwo.text != "-" {
            
            networking.makeNetworking(currency1: currency1, currency2: currency2, amount: amount)
            
        } else {
            showAlert()
        }
        
        func showAlert(){
            let alert = UIAlertController(title: "Missing Input ", message: "Please fill all input fields.", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
            
            present(alert, animated: true)
        }
        
    }
    

}


//MARK: - UITextFieldDelegate


extension CurrencyViewController: UITextFieldDelegate {
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if amountTextField.text != "" {
            amountTextField.endEditing(true)
        } else {
            amountTextField.placeholder = "Please enter amount."
        }
        return true
    }
}


//MARK: - UIPickerViewDelegate


extension CurrencyViewController: UIPickerViewDelegate {
    
    //Row title.
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencies[row]
    }
    //Sets textField's text to row's content
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 1 {
            currencyFieldOne.text = currencies[row]
            curentRoll1 = row
        } else {
            currencyFieldTwo.text = currencies[row]
            curentRoll2 = row
        }
    }
    
    //Functionality of done button on pickerView's toolbar accessory.
    @objc func donePicker() {
        self.view.endEditing(true)
    }
    
    
}

//MARK: - UIPickerViewDataSource


extension CurrencyViewController: UIPickerViewDataSource {
    
    // Number of 'columns' to display.
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    // Number of rows to display.
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencies.count
    }
    
}

//MARK: - NetworkingDelegate

extension CurrencyViewController: NetworkingDelegate {
    
    func didGetError(error: Error) {
        print(error)
    }
    
    func receiveProcessedData(networking: Networking, processedData: CurrencyModel) {
        
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "goToResultsPage", sender: self)
        }
        total = processedData.total
        rate = processedData.rate
        fromCurrency = processedData.fromCurrency
        toCurrency = processedData.toCurrency
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goToResultsPage" {
            
            let resultsViewController = segue.destination as! ResultsViewController
            
            resultsViewController.total = total
            resultsViewController.fromCurrency = fromCurrency
            resultsViewController.toCurrency = toCurrency
            resultsViewController.rate = rate
        }
    }
    
}

//MARK: - Extra setup for buttons

@IBDesignable extension UIButton {

    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }

    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }

    @IBInspectable var borderColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
}
