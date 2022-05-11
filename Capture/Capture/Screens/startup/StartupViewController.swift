//
//  StartupViewController.swift
//  Capture
//
//  Created by Imtiaz Rahman on 5/7/22.
//

import UIKit

class StartupViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func nextBtn(){
        let g = UIImpactFeedbackGenerator(style: .medium)
        g.impactOccurred()
        let nm = storyboard?.instantiateViewController(identifier: "name") as! nameViewController
        nm.modalPresentationStyle = .fullScreen
        nm.modalTransitionStyle = .crossDissolve
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
