//
//  mainScreenViewController.swift
//  Capture
//
//  Created by Imtiaz Rahman on 5/8/22.
//

import UIKit
import Foundation
import CoreLocation
import AudioToolbox

class mainScreenViewController: UIViewController, CLLocationManagerDelegate {
    
    var long: Double?
    var lat: Double?
    var lM: CLLocationManager?
    var results = [response]()
    var w: String?
    @IBOutlet var f:UIImageView!
    @IBOutlet var m:UILabel?
    @IBOutlet var k:UIActivityIndicatorView?
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
    
    func parseWeather(d: Data){
        let decoder = JSONDecoder()
        let jsonResponse = try! decoder.decode(weather.self, from: d)
        for i in jsonResponse.weather{
            w = i.main
        }
        if w == "Clouds"{
            k?.hidesWhenStopped = true
            k?.stopAnimating()
            f.image = UIImage(named: "cloudy")
            m?.text = "Good to wash that car!"
        }else if w == "Clear"{
            k?.hidesWhenStopped = true
            k?.stopAnimating()
            f.image = UIImage(named: "sunny")
            m?.text = "When was the last time you washed those wheels? Today looking perfect!"
        }else{
            k?.hidesWhenStopped = true
            k?.stopAnimating()
            f.image = UIImage(named: "raining")
            m?.text = "Going to wash your car? Mother nature says otherwise..."
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //getRequest()
        k?.startAnimating()
        lM = CLLocationManager()
        lM?.requestAlwaysAuthorization()
        lM?.startUpdatingLocation()
        lM?.delegate = self
        lM?.allowsBackgroundLocationUpdates = true
        long = lM?.location?.coordinate.longitude
        lat = lM?.location?.coordinate.latitude
        print(long)
        print(lat)
        if (long == nil || lat == nil){
            f.image = UIImage(named: "dashed")
            m?.text = "Unable to retrieve weather! Wash car at your own risk :("
            k?.hidesWhenStopped = true
            k?.stopAnimating()
        }else{
            let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(lat!)&lon=\(long!)&exclude=hourly,daily&appid=43c15c1ed8511b521c98bf9fc10e61d4")!
            let t = URLSession.shared.dataTask(with: url){
            data, response, error in
                if (error != nil){
                    print(error)
                }else{
                    self.parseWeather(d: data!)
                    print(String(data:data!, encoding: .utf8)!)
            }
            }.resume()
        }
        
       
        // Do any additional setup after loading the view.
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let l = locations.last{
            long = l.coordinate.longitude
            lat = l.coordinate.latitude
        }
    }
    
    @IBAction func addToll(){
        let g = UIImpactFeedbackGenerator(style: .medium)
        g.impactOccurred()
        let nm = storyboard?.instantiateViewController(identifier: "addTollScreen") as! addTollViewController
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
