//
//  LengthTableViewController.swift
//  UnitConverter
//
//  Created by Truong Pham on 2/17/18.
//  Copyright © 2018 Truong Pham. All rights reserved.
//

import UIKit
import CoreData

class LengthTableViewController: UITableViewController {

    let conversions = [
        ConversionInfo(type: "Length", fromUnit: "Kilometers", toUnit: "Miles", conversionFactor: 0.621371),
        ConversionInfo(type: "Length", fromUnit: "Miles", toUnit: "Kilometers", conversionFactor: 1.60934),
        ConversionInfo(type: "Length", fromUnit: "Yard", toUnit: "Feet", conversionFactor: 3.0),
        ConversionInfo(type: "Length", fromUnit: "Feet", toUnit: "Yard", conversionFactor: 0.33333),
        ConversionInfo(type: "Length", fromUnit: "Inches", toUnit: "Centimeters", conversionFactor: 2.54),
        ConversionInfo(type: "Length", fromUnit: "Centimeters", toUnit: "Inches", conversionFactor: 0.3937)
    ]
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var recents: [ConvertedItem] = []
    
    override func viewWillAppear(_ animated: Bool) {
        getData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    // Setting number of rows in each section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return [conversions.count, recents.count][section]
    }
    
    // Setting section header
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ["Conversions", "Recents"][section]
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)

        // Configure the cell...
        if indexPath.section == 0 {
            cell.textLabel?.text = "\(conversions[indexPath.row].fromUnit) to \(conversions[indexPath.row].toUnit)"
            cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        } else {
            let recent = recents[indexPath.row]
            cell.textLabel?.text = recent.item
        }

        return cell
    }

    // Override to support conditional editing of the table view.
    // Allow recent section to be editable
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return indexPath.section == 1
    }

    // Override to support editing the table view.
    // Allow recent section to delete
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let recent = recents[indexPath.row]
            context.delete(recent)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            getData()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            self.performSegue(withIdentifier: "lengthToConverter", sender: self)
        }
    }
    
    // Fetching recent items
    func getData() {
        do {
            // Create Fetch Request
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ConvertedItem")
            
            // Add Sort Descriptor
            let sortDescriptor = NSSortDescriptor(key: "convertedDate", ascending: false)
            fetchRequest.sortDescriptors = [sortDescriptor]
            
            // Add Predicate
            let predicate = NSPredicate(format: "type CONTAINS %@", "Length")
            fetchRequest.predicate = predicate
            
            recents = try context.fetch(fetchRequest) as! [ConvertedItem]
        } catch {
            print("Fetching Failed")
        }
        tableView.reloadData()
    }


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let viewController = segue.destination as? ConverterViewController {
            viewController.conversionInfo = conversions[(self.tableView.indexPathForSelectedRow?.row)!]
        }
    }

}
