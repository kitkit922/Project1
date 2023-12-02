//
//  multipleDetailViewController.swift
//  Project1
//
//  Created by Tsz Kit Cheung on 2023-12-09.
//

import UIKit

class multipleDetailViewController: UIViewController {

    var stock: stockTS?
    
    @IBOutlet weak var LB1: UILabel!
    @IBOutlet weak var LB2: UILabel!
    @IBOutlet weak var LB3: UILabel!
    @IBOutlet weak var LB4: UILabel!
    @IBOutlet weak var LB5: UILabel!
    @IBOutlet weak var LB6: UILabel!
    
    @IBOutlet weak var LB7: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LB7.text = "Detailed Information: \(stock!.date), \(stock!.stockID)"
        
        LB1.text = "\(stock!.open)"
        LB2.text = "\(stock!.close)"
        LB3.text = "\(stock!.high)"
        LB4.text = "\(stock!.low)"
        LB5.text = "\(stock!.volume)"
        LB6.text = "\(stock!.numOfTrades)"

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
