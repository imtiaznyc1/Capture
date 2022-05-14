//
//  StartupViewController.swift
//  Capture
//
//  Created by Imtiaz Rahman on 5/7/22.
//

import UIKit
import AVFoundation

class StartupViewController: UIViewController {
    @IBOutlet var c: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animate()
        // Do any additional setup after loading the view.
    }
    
    @objc func animate(){
        UIView.animate(withDuration: 2, animations: {
            self.c.frame = CGRect(x: 94, y: 540, width: 226.5, height: 38.5)
        })
    }
    
    func playSound(){
        let fP = Bundle.main.url(forResource: "pokemon", withExtension: "mp3")
        player = try? AVAudioPlayer(contentsOf: fP!)
        player.play()
    }
    
    @IBAction func nextBtn(){
        self.playSound()
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
