//
//  HistoryTableViewController.swift
//  Project1
//
//  Created by Tsz Kit Cheung on 2023-12-02.
//

import UIKit

class HistoryTableViewController: UITableViewController, NetworkingDelegate {

    
    var stockList = (UIApplication.shared.delegate as! AppDelegate).allStock
//    var stockList = [stockTS]()

    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkingManager.shared.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Load data from AppDelegate's allStock
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        stockList = appDelegate.allStock

        tableView.reloadData()
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return stockList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = stockList[indexPath.row].stockID
        cell.detailTextLabel?.text = stockList[indexPath.row].date
        return cell
    }

    
    func networkingDidFinishWithSuccess(stock: stockTS) {
        
        stockList.append(stock)
        tableView.reloadData()

    }
    
    
    func networkingDidFinishWithError() {

    }
    
    func networkingDidFinishWithList(stockTotalList: stockTotalList) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // segue (for whole list/ instance)
        if segue.identifier == "toDetail",
           let detailVC = segue.destination as? DetailViewController,
           
            // segue path to selected row
           let indexPath = tableView.indexPathForSelectedRow{
           
            // choose a row from a list
            let selectedStock = stockList[indexPath.row]
                
                // segue whole list
                detailVC.stock = selectedStock
            
        }
    
    }
    
  
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
