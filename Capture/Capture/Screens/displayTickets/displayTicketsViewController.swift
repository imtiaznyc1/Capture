//
//  displayTicketsViewController.swift
//  Capture
//
//  Created by Imtiaz Rahman on 5/13/22.
//

import UIKit

class displayTicketsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var tv: UITableView!
    @IBOutlet var goodNews: UILabel!
    var de: [String] = []
    var p: [String] = []
    var numNeeded : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "ticketTableViewCell", bundle: nil)
        tv.register(nib, forCellReuseIdentifier: "ticketTableViewCell")
        let storedPlateNumber = UserDefaults.standard.string(forKey: "plateNumber")
        print(numNeeded!)

        let link = URL(string: "https://data.cityofnewyork.us/resource/nc67-uf89.json?plate=\(numNeeded!)")
        if (link == nil){
            print("bad link")
        }else{
            let t = URLSession.shared.dataTask(with: link!){
            data, response, error in
                if (error != nil){
                    print(error)
                }else{
                    self.parseTickets(d: data!)
                   // print(String(data:data!, encoding: .utf8)!)
                    print(self.de)
                    print(self.p)
            }
            }.resume()
        }
        
        tv.delegate = self
        tv.dataSource = self
    
        // Do any additional setup after loading the view.
    }
    
    func parseTickets(d: Data){
        let decoder = JSONDecoder()
        let jsonResponse = try! decoder.decode([tickets].self, from: d)
        for i in jsonResponse{
            de.append(i.violation)
            p.append(i.fine_amount)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if(de.count == 0){
            goodNews.text = "N O   T I C K E T S   F O U N D"
        }
        return de.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let y = tableView.dequeueReusableCell(withIdentifier: "ticketTableViewCell", for: indexPath) as! ticketTableViewCell
        y.desc.text = de[indexPath.row]
        y.fine.text = "$ " + p[indexPath.row]
        return y
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
