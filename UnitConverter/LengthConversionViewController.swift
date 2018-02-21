//
//  LengthConversionViewController.swift
//  UnitConverter
//
//  Created by Anh Phung on 2/18/18.
//  Copyright © 2018 Truong Pham. All rights reserved.
//

import UIKit

class LengthConversionViewController: UIViewController, UITextFieldDelegate {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var conversionInfo = LengthConversionInfo()
    
    @IBOutlet weak var fromValue: UITextField!
    @IBOutlet weak var toValue: UITextField!
    @IBOutlet weak var fromUnit: UILabel!
    @IBOutlet weak var toUnit: UILabel!
    
    @IBAction func fromEditingChanged(_ sender: Any) {
        if let value = Double(fromValue.text!) {
            toValue.text = String(value * conversionInfo.conversionFactor)
        }
        else {
            fromValue.text = ""
            toValue.text = ""
            return
        }
    }
    
    // TODO: Anchor and resize from/to value controls
    // TODO: Close keyboard on enter or tab
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fromValue.delegate = self
        fromUnit.text = conversionInfo.fromUnit
        toUnit.text = conversionInfo.toUnit
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        SaveCurrentConversion()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        let allowedDecimal = !textField.text!.contains(".") && string.elementsEqual(".")
        return allowedCharacters.isSuperset(of: characterSet) || allowedDecimal
    }

    func SaveCurrentConversion() {
        guard let fromValue = Double(fromValue.text!) else { return }
        guard let toValue = Double(toValue.text!) else { return }
        
        let newConversion = Conversion(context: context)
        let converted = "\(fromValue) \(fromUnit.text!) = \(toValue) \(toUnit.text!)"
        newConversion.item = converted
        newConversion.convertedDate = Date()
        newConversion.type = "Length"

        // Save the data to coredata
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
    }
}
