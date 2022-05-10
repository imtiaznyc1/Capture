//
//  mainScreenViewController.swift
//  Capture
//
//  Created by Imtiaz Rahman on 5/8/22.
//

import UIKit
import Foundation
import CoreLocation

class mainScreenViewController: UIViewController, CLLocationManagerDelegate {
    
    var long: Double?
    var lat: Double?
    var lM: CLLocationManager?
    var results = [response]()
    let headers = [
        "content-type":"application/json",
        "x-api-key":"4b798pJGLtrNnnnHMGjR7Mjrp4pDPh3F"
    ]
    
    let parameters = [
        "from": ["address": "Main str, Dallas, TX"],
        "to": ["address": "Addison, TX"],
        "waypoints": [["address": "Plano, TX"], ["address": "Allen, TX"]],
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
      ] as [String : Any]
    
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
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //getRequest()
        //lM = CLLocationManager()
        //lM?.requestAlwaysAuthorization()
        //lM?.startUpdatingLocation()
        //lM?.delegate = self
        //lM?.allowsBackgroundLocationUpdates = true
        
        // Do any additional setup after loading the view.
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let l = locations.last{
            long = l.coordinate.longitude
            lat = l.coordinate.latitude
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
