//
//  ConverterViewController.swift
//  UnitConverter
//
//  Created by Truong Pham on 2/23/18.
//  Copyright © 2018 Truong Pham. All rights reserved.
//

import UIKit

class ConverterViewController: UIViewController, UITextFieldDelegate {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var conversionInfo = ConversionInfo()
    
    @IBOutlet weak var fromValue: UITextField!
    @IBOutlet weak var toValue: UITextField!
    @IBOutlet weak var fromUnit: UILabel!
    @IBOutlet weak var toUnit: UILabel!
    
    // Convert value as user type
    @IBAction func fromEditingChanged(_ sender: Any) {
        if let value = Double(fromValue.text!) {
            toValue.text = String(conversionInfo.convert(value: value))
        }
        else {
            fromValue.text = ""
            toValue.text = ""
            return
        }
    }
    
    // Setup view on load
    override func viewDidLoad() {
        super.viewDidLoad()
        fromValue.delegate = self
        fromValue.keyboardType = UIKeyboardType.decimalPad
        fromUnit.text = conversionInfo.fromUnit
        toUnit.text = conversionInfo.toUnit
    }
    
    // Save data when back button is pressed
    override func viewWillDisappear(_ animated: Bool) {
        if self.isMovingFromParentViewController {
            SaveCurrentConversion()
        }
    }
    
    // Only allow numeric characters to be typed
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        let allowedDecimal = !textField.text!.contains(".") && string.elementsEqual(".")
        return allowedCharacters.isSuperset(of: characterSet) || allowedDecimal
    }
    
    // Save conversion to coredata
    func SaveCurrentConversion() {
        guard let fromValue = Double(fromValue.text!) else { return }
        guard let toValue = Double(toValue.text!) else { return }
        
        let newItem = ConvertedItem(context: context)
        let display = "\(fromValue) \(fromUnit.text!) = \(toValue) \(toUnit.text!)"
        newItem.item = display
        newItem.convertedDate = Date()
        newItem.type = conversionInfo.type
        
        // Save the data to coredata
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
    }
}
