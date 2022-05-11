//
//  ViewController.swift
//  Capture
//
//  Created by Imtiaz Rahman on 5/10/22.
//

import UIKit

class addTollViewController: UIViewController {
    @IBOutlet var fromPoint:UITextField?
    @IBOutlet var toPoint:UITextField?
    @IBOutlet var price:UILabel?
    @IBOutlet var k:UIActivityIndicatorView?
    @IBOutlet var cancel:UIButton?
    var tollCost: Double? = 0.00
    
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
                  print("Response data string:\n \(dataString)")
              }
          }
        }).resume()
    }
    
    func parse(d: Data){
        let decoder = JSONDecoder()
        let jsonResponse = try! decoder.decode(responses.self, from: d)
        for i in jsonResponse.routes{
            print("the cost of the tag is: \n")
            print(i.costs.tag)
            tollCost = i.costs.tag
            if (i.costs.tag > 0){
                cancel?.setTitle("C O N F I R M", for: .normal)
            }
            let x:String = String(i.costs.tag)
            var result = "$ "
            for i in x{
                result += String(i)
                result += " "
            }
            k?.stopAnimating()
            price!.text = result
        }
    }
    
    @IBAction func canc(){
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
