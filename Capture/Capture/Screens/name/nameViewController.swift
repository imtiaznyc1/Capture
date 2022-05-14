//
//  nameViewController.swift
//  Capture
//
//  Created by Imtiaz Rahman on 5/7/22.
//

import UIKit
import AVFoundation

class nameViewController: UIViewController {
    
    @IBOutlet var f:UITextField!
    public var inputtedText: String?
    @IBOutlet var returningMessage: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let x = UserDefaults.standard.bool(forKey: "setUpUser")
        let y = UserDefaults.standard.string(forKey: "nameOfUser")
        
        if (x == true){
            var tempString = "Welcome back, \(y!)! You may update name if needed."
            returningMessage.text = tempString
        }
        let a = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(a)
        // Do any additional setup after loading the view.
    }
    
    @objc func hideKeyboard(){
        view.endEditing(true)
    }
    
    func playSound(){
        let fP = Bundle.main.url(forResource: "pokemon", withExtension: "mp3")
        player = try? AVAudioPlayer(contentsOf: fP!)
        player.play()
    }
    
    @IBAction func nextBtn(){
        if (f.text?.trimmingCharacters(in: .whitespaces).isEmpty == true){
            let g = UIImpactFeedbackGenerator(style: .medium)
            g.impactOccurred()
            let alert = UIAlertController(title: "Oops...", message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title:"OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        }else{
            self.playSound()
            let g = UIImpactFeedbackGenerator(style: .medium)
            g.impactOccurred()
            let nm = storyboard?.instantiateViewController(identifier: "vehicle") as! vehicleInfoViewController
            nm.modalPresentationStyle = .fullScreen
            nm.modalTransitionStyle = .crossDissolve
            nm.t = "Good evening, " + f.text! + "! Answer the following questions:"
            UserDefaults.standard.setValue(true, forKey: "setUpUser")
            UserDefaults.standard.setValue(f.text, forKey: "nameOfUser")
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
