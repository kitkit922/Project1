//
//  MultipleTableViewController.swift
//  Project1
//
//  Created by Tsz Kit Cheung on 2023-12-09.
//

import UIKit

class MultipleTableViewController: UITableViewController, NetworkingDelegate {


//    var stockList = (UIApplication.shared.delegate as! AppDelegate).allStockTotalList
    var stockList: stockTotalList = stockTotalList(results: [])
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NetworkingManager.shared.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Load data from AppDelegate's allStock
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        stockList = appDelegate.allStockTotalList

        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return stockList.results.count
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath)
       
        // Access the results array for data
        let stock = stockList.results[indexPath.row]
        cell.textLabel?.text = stock.stockID
        cell.detailTextLabel?.text = stock.date
        

        return cell
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // segue (for whole list/ instance)
        if segue.identifier == "toDetail2",
           let detailVC = segue.destination as? multipleDetailViewController,
           
            // segue path to selected row
           let indexPath = tableView.indexPathForSelectedRow{
           
            // choose a row from a list
            let selectedStock = stockList.results[indexPath.row]
                
            // segue whole list
            detailVC.stock = selectedStock
            
        }
    
    }

    func networkingDidFinishWithSuccess(stock: stockTS) {
        
    }
    
    func networkingDidFinishWithList(stockTotalList: stockTotalList) {
        
        self.stockList = stockTotalList
        tableView.reloadData()
        
    }
    
    func networkingDidFinishWithError() {
        
    }
    
}

