//
//  LengthConversionViewController.swift
//  UnitConverter
//
//  Created by Anh Phung on 2/18/18.
//  Copyright © 2018 Truong Pham. All rights reserved.
//

import UIKit

class LengthConversionViewController: UIViewController, UITextFieldDelegate {

    var conversionFactor = 1.0
    
    @IBOutlet weak var fromValue: UITextField!
    @IBOutlet weak var toValue: UITextField!
    @IBOutlet weak var fromUnit: UILabel!
    @IBOutlet weak var toUnit: UILabel!
    
    @IBAction func fromEditingChanged(_ sender: Any) {
        toValue.text = fromValue.text
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fromValue.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        // save conversion to table
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
