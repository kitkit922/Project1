//
//  MainViewController.swift
//  Project1
//
//  Created by Tsz Kit Cheung on 2023-12-02.
//

import UIKit

class MainViewController: UIViewController, NetworkingDelegate {


    @IBOutlet weak var TF1: UITextField!
    
    @IBOutlet weak var TF2: UITextField!
    
    @IBOutlet weak var TF3: UITextField!
    
    @IBOutlet weak var TF4: UITextField!
    
    @IBOutlet weak var B1: UIButton!
    
    @IBOutlet weak var B2: UIButton!
    
    @IBOutlet weak var B3: UIButton!
    
    @IBOutlet weak var B4: UIButton!
    
    @IBOutlet weak var B5: UIButton!
    
    @IBOutlet weak var LB1: UILabel!
    
    @IBOutlet weak var LB2: UILabel!
    
    @IBOutlet weak var LB3: UILabel!
    
    @IBOutlet weak var LB4: UILabel!
    
    @IBOutlet weak var LB5: UILabel!
    
    var thisStock: stockTS!
    
    var num1: Int = 0
    
    var num2: Int = 0
    
   
    
//    var allStockList = (UIApplication.shared.delegate as! AppDelegate).allStock

    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkingManager.shared.delegate = self
    }
    
    
    // ensures that the delegate is reset every time the view appears
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NetworkingManager.shared.delegate = self
    }


    
    @IBAction func SearchStock(_ sender: Any) {
        if let stockname = TF1.text, let datename = TF2.text, !stockname.isEmpty, !datename.isEmpty {
            
            self.LB1.text = ""
            self.LB2.text = ""
            self.LB3.text = ""
            self.LB4.text = ""
            self.LB5.text = "-"

            NetworkingManager.shared.getStockData(stockName: stockname, date: datename)
    
        }
    }
    
    @IBAction func searchMultipleDate(_ sender: Any) {
        
        if let stockname = TF1.text, let datename1 = TF3.text, let datename2 = TF4.text, !stockname.isEmpty, !datename1.isEmpty, !datename2.isEmpty {
            
            self.LB5.text = "-"
            
            NetworkingManager.shared.getMultiStockData(stockName: stockname, date1: datename1, date2: datename2)
            
            
            
        }
    }
        
    func networkingDidFinishWithSuccess(stock: stockTS) {
        print("Success method called with stock: \(stock)")
        
        thisStock = stock
        DispatchQueue.main.async {
            print(stock.open)
            print(stock.close)
            
            let openValue = stock.open
            let closeValue = stock.close
            let openCloseDiff = round((closeValue - openValue)*1000)/1000
            let openClosePercentage = round((openCloseDiff / openValue)*10000)/100
            
            self.LB1.text = "\(round(openValue*1000)/1000)"
            self.LB2.text = "\(round(closeValue*1000)/1000)"
            
            if openCloseDiff >= 0 {
                self.LB3.text = "+\(openCloseDiff)"
                self.LB4.text = "+\(openClosePercentage)%"
                self.LB3.textColor = UIColor.green
                self.LB4.textColor = UIColor.green
            }
            
            else{
                self.LB3.text = "\(openCloseDiff)"
                self.LB4.text = "\(openClosePercentage)%"
                self.LB3.textColor = UIColor.red
                self.LB4.textColor = UIColor.red
            }
            
        }
        
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.allStock.append(stock)
        
        print(stock.open)
        print(stock.close)
        
    }
    
    func networkingDidFinishWithList(stockTotalList: stockTotalList) {
        
    }
    
    func networkingDidFinishWithError() {
        DispatchQueue.main.async {
            self.LB5.text = "Invalid Data!"
            print("Invalid Data!")
        }
    }
}


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


