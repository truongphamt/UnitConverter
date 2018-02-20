//
//  LengthConversionViewController.swift
//  UnitConverter
//
//  Created by Anh Phung on 2/18/18.
//  Copyright © 2018 Truong Pham. All rights reserved.
//

import UIKit

class LengthConversionViewController: UIViewController, UITextFieldDelegate {

    var conversionInfo = LengthConversionInfo()
    
    @IBOutlet weak var fromValue: UITextField!
    @IBOutlet weak var toValue: UITextField!
    @IBOutlet weak var fromUnit: UILabel!
    @IBOutlet weak var toUnit: UILabel!
    
    @IBAction func fromEditingChanged(_ sender: Any) {
        toValue.text = String(Double(fromValue.text!)! * conversionInfo.conversionFactor)
    }
    
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
        // save conversion to table
        // Create empty record
//        let newConversion = Conversion(context: context)
//        let now = Date()
//        newConversion.item = "test"
//        newConversion.convertedDate = now
//        newConversion.type = "Length"
//
//        // Save the data to coredata
//        (UIApplication.shared.delegate as! AppDelegate).saveContext()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }

}
