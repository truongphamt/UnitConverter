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
        "Kilometer to Miles",
        "Miles to Kilometer",
        "Yard to Feet",
        "Feet to Yard",
        "Inches to Centimeters",
        "Centimeters to Inches"
    ]
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var recents: [Conversion] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return [conversions.count, recents.count][section]
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ["Conversions", "Recents"][section]
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)

        // Configure the cell...
        if indexPath.section == 0 {
            cell.textLabel?.text = String(conversions[indexPath.row])
            cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        } else {
            let recent = recents[indexPath.row]
            cell.textLabel?.text = recent.item
        }

        return cell
    }

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return indexPath.section == 1
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            //tableView.deleteRows(at: [indexPath], with: .fade)
            let recent = recents[indexPath.row]
            context.delete(recent)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            getData()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            self.performSegue(withIdentifier: "lengthToConverter", sender: conversions[indexPath.item])
            
            // Create empty record
            let newConversion = Conversion(context: context)
            let now = Date()
            newConversion.item = "test"
            newConversion.convertedDate = now
            newConversion.type = "Length"
            
            // Save the data to coredata
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            getData()
        }
    }
    
    func getData() {
        do {
            // Create Fetch Request
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Conversion")
            
            // Add Sort Descriptor
            let sortDescriptor = NSSortDescriptor(key: "convertedDate", ascending: false)
            fetchRequest.sortDescriptors = [sortDescriptor]
            
            // Add Predicate
            let predicate = NSPredicate(format: "type CONTAINS %@", "Length")
            fetchRequest.predicate = predicate
            
            recents = try context.fetch(fetchRequest) as! [Conversion]
        } catch {
            print("Fetching Failed")
        }
        tableView.reloadData()
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
