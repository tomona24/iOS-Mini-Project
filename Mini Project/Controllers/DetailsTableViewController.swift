//
//  DetailsTableViewController.swift
//  Mini Project
//
//  Created by Leandro Prado on 2020-05-26.
//  Copyright © 2020 Leandro Prado. All rights reserved.
//

import UIKit

class DetailsTableViewController: UITableViewController {

    var data: MainData!
    @IBOutlet weak var totalCasesLabel: UILabel!
    @IBOutlet weak var totalDeathsLabel: UILabel!
    @IBOutlet weak var totalRecoveryLabel: UILabel!
    @IBOutlet weak var activeCasesLabel: UILabel!
    @IBOutlet weak var totalTestsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let unknown = "N/A"
        totalCasesLabel.text = data.data[.totalCases]?.description ?? unknown
        totalDeathsLabel.text = data.data[.totalDeaths]?.description ?? unknown
        totalRecoveryLabel.text = data.data[.totalRecoveries]?.description ?? unknown
        activeCasesLabel.text = data.data[.activeCases]?.description ?? unknown
        totalTestsLabel.text = data.data[.totalTests]?.description ?? unknown
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        var cell: UITableViewCell
//
//        switch indexPath.section {
//        case 0:
//            cell = tableView.dequeueReusableCell(withIdentifier: "TotalCasesCell", for: indexPath)
//            cell.textLabel?.text = data.data[.totalCases]?.description
//        case 1:
//            cell = tableView.dequeueReusableCell(withIdentifier: "TotalDeathsCell", for: indexPath)
//            cell.textLabel?.text = data.data[.totalDeaths]?.description
//        case 2:
//            cell = tableView.dequeueReusableCell(withIdentifier: "TotalRecoveryCell", for: indexPath)
//            cell.textLabel?.text = data.data[.totalRecoveries]?.description
//        case 3:
//            cell = tableView.dequeueReusableCell(withIdentifier: "ActiveCasesCell", for: indexPath)
//            cell.textLabel?.text = data.data[.activeCases]?.description
//        case 4:
//            cell = tableView.dequeueReusableCell(withIdentifier: "TotalTestsCell", for: indexPath)
//            cell.textLabel?.text = data.data[.totalTests]?.description
//        default:
//            cell = UITableViewCell.init()
//        }
        
        // Configure the cell...
        
//        return cell
//    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
