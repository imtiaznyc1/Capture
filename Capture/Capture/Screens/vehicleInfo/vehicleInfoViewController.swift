//
//  vehicleInfoViewController.swift
//  Capture
//
//  Created by Imtiaz Rahman on 5/7/22.
//

import UIKit

class vehicleInfoViewController: UIViewController {
    
    @IBOutlet var l: UILabel!
    var t: String?
    var vehicleType: String? = ""
    var ezPass: Bool? = nil
    var plNumber: String?
    @IBOutlet var sed: UILabel!
    @IBOutlet var suv:UILabel!
    @IBOutlet var yes: UILabel!
    @IBOutlet var no:UILabel!
    @IBOutlet var plateN:UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if t != nil{
            self.l.text = t
        }else{
            self.l.text = "F"
        }
        let a = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(a)
        // Do any additional setup after loading the view.
    }
    @objc func hideKeyboard(){
        view.endEditing(true)
    }
    
    @IBAction func pressSedan(){
        let g = UIImpactFeedbackGenerator(style: .medium)
        g.impactOccurred()
        vehicleType = "sedan"
        sed.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha:1.0)
        sed.textColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha:1.0)
        suv.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha:1.0)
        suv.textColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha:1.0)
    }
    
    @IBAction func pressSUV(){
        let g = UIImpactFeedbackGenerator(style: .medium)
        g.impactOccurred()
        vehicleType = "suv"
        suv.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha:1.0)
        suv.textColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha:1.0)
        sed.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha:1.0)
        sed.textColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha:1.0)
    }
    
    @IBAction func pressYes(){
        let g = UIImpactFeedbackGenerator(style: .medium)
        g.impactOccurred()
        ezPass = true
        yes.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha:1.0)
        yes.textColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha:1.0)
        no.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha:1.0)
        no.textColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha:1.0)
    }
    
    @IBAction func pressNo(){
        let g = UIImpactFeedbackGenerator(style: .medium)
        g.impactOccurred()
        ezPass = false
        no.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha:1.0)
        no.textColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha:1.0)
        yes.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha:1.0)
        yes.textColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha:1.0)
    }

    @IBAction func pressFinish(){
        let g = UIImpactFeedbackGenerator(style: .medium)
        g.impactOccurred()
        plNumber = plateN.text
        if(ezPass == nil || vehicleType?.isEmpty == true || plNumber?.trimmingCharacters(in: .whitespaces).isEmpty == true){
            let alert = UIAlertController(title: "Oops...", message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title:"OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        }else{
            let nm = storyboard?.instantiateViewController(identifier: "mainscreen") as! mainScreenViewController
            nm.modalPresentationStyle = .fullScreen
            nm.modalTransitionStyle = .crossDissolve
            present(nm, animated: true)
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

}
