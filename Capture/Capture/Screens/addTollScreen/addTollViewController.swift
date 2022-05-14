//
//  ViewController.swift
//  Capture
//Sources: https://www.hackingwithswift.com/read/7/3/parsing-json-using-the-codable-protocol
//  Created by Imtiaz Rahman on 5/10/22.
//

import UIKit
import AVFoundation

class addTollViewController: UIViewController {
    
    var tollCost: Double?
    var delegate: updateTollTextDelegate?
    @IBOutlet var fromPoint:UITextField?
    @IBOutlet var toPoint:UITextField?
    @IBOutlet var price:UILabel?
    @IBOutlet var k:UIActivityIndicatorView?
    @IBOutlet var cancel:UIButton?

    
    let headers = [
        "content-type":"application/json",
        "x-api-key":"4b798pJGLtrNnnnHMGjR7Mjrp4pDPh3F"
    ]
    var parameters: [String:Any]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    func getRequest(){
        let postData = try? JSONSerialization.data(withJSONObject: parameters, options: [])
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://dev.tollguru.com/v1/calc/here")! as URL,cachePolicy: .useProtocolCachePolicy,timeoutInterval: 10.0)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = postData as Data?
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
          if (error != nil) {
            print("hey")
          } else {
            let t = response as? HTTPURLResponse
              if data == data, let dataString = String(data:data!, encoding: .utf8){
                  self.parse(d:data!)
                  //print("Response data string:\n \(dataString)")
              }
          }
        }).resume()
    }
    
    func parse(d: Data){
        let decoder = JSONDecoder()
        let jsonResponse = try? decoder.decode(responses.self, from: d)
        if (jsonResponse == nil){
            tollCost = 0
            DispatchQueue.main.async{
                let alert = UIAlertController(title: "Invalid address!", message: "", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title:"OK", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
        }else{
            for i in jsonResponse!.routes{
                print("the cost of the tag is: \n")
                print(i.costs.tag)
                tollCost = i.costs.tag
                print("the tollcost is")
                print(tollCost)
                break
            }
            let x:String = String(tollCost!)
            var result = "$ "
            for i in x{
                print(i)
                result += String(i)
                result += " "
            }
            DispatchQueue.main.async {
                self.price!.text = result
                if (self.tollCost! > 0){
                    self.cancel?.setTitle("C O N F I R M", for: .normal)
                }
                self.k?.stopAnimating()
            }
            
        }

        

    }
    
    @IBAction func canc(){
        let g = UIImpactFeedbackGenerator(style: .medium)
        g.impactOccurred()
        //nm.totalToll!+=tollCost!
        if(tollCost == nil){
            
        }else{
            print("bye")
            print( tollCost!)
            delegate?.changeTollText(thing: tollCost!)
        }
        self.playSound()
        dismiss(animated: true)
    }
    
    @IBAction func check(){
        k?.startAnimating()
        if(fromPoint?.text?.trimmingCharacters(in: .whitespaces).isEmpty == true || toPoint?.text?.trimmingCharacters(in:.whitespaces).isEmpty == true){
            let g = UIImpactFeedbackGenerator(style: .medium)
            g.impactOccurred()
            let alert = UIAlertController(title: "Oops...", message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title:"OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            k?.stopAnimating()
        }else{
            self.playSound()
            let g = UIImpactFeedbackGenerator(style: .medium)
            g.impactOccurred()
            print("I am pressed2")
            parameters = [
                "from": ["address": fromPoint!.text],
                "to": ["address": toPoint!.text],
                "vehicleType": "2AxlesAuto",
                "departure_time": 1551541566,
                "fuelPrice": 2.79,
                "fuelPriceCurrency": "USD",
                "fuelEfficiency": [
                "city": 24,
                "hwy": 30,
                "units": "mpg"
                ],
                "driver": [
                  "wage": 30,
                  "rounding": 15,
                  "valueOfTime": 0
                ],
                "hos": [
                  "rule": 60,
                  "dutyHoursBeforeEndOfWorkDay": 11,
                  "dutyHoursBeforeRestBreak": 7,
                  "drivingHoursBeforeEndOfWorkDay": 11,
                  "timeRemaining": 60
                ]
              ]
            getRequest()
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

protocol updateTollTextDelegate{
    func changeTollText(thing: Double)
}
