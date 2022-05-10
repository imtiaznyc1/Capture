//
//  nameViewController.swift
//  Capture
//
//  Created by Imtiaz Rahman on 5/7/22.
//

import UIKit

class nameViewController: UIViewController {
    
    @IBOutlet var f:UITextField!
    public var inputtedText: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func nextBtn(){
        let nm = storyboard?.instantiateViewController(identifier: "vehicle") as! vehicleInfoViewController
        nm.modalPresentationStyle = .fullScreen
        nm.modalTransitionStyle = .crossDissolve
        nm.t = "Good evening, " + f.text! + "! Before we can get you set up, I need to know some info about your vehicle to give the best accurate data. When you’re ready, answer the following questions:"
        present(nm, animated: true)
        
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
