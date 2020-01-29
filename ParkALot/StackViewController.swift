//
//  StackViewController.swift
//  ParkALot
//
//  Created by Aidan Gutierrez on 1/25/20.
//  Copyright © 2020 Spencer Jolie. All rights reserved.
//

import UIKit

struct Root : Decodable {
   let Garages: [Garage]
}

struct Garage: Decodable{
    var _id: String
    var garageName: String
    var address: String
    var carsInLot: Int
    var capacity: Int
    var createdAt: String
    var updatedAt: String
    var __v: Int
    //var available: Int
}

class StackViewController: UIViewController,  UITableViewDelegate, UITableViewDataSource{
    
    //outlets
    @IBOutlet weak var headerBackground: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var refresh: UIButton!
    
    //vars
    var Garages: [Garage] = []
    var taken: Int!
    var total: Int!
    var carryGarry: Garage? = nil
    
    
    @IBAction func refreshBtn(_ sender: Any) {
        pullApi()
    }
    
    // pulls form the api and populates the list with updated data.
    // This ouccers every 30 seconds.
    @objc func pullApi(){
        //Must delete current garage list first
        Garages = []
        // Api Call
        let apicall = DispatchGroup();
        let garageJson = "https://park-a-lot.herokuapp.com/api/v1/garages/"
        guard let url = URL(string: garageJson) else {return}
        apicall.enter();
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {print(error)}
            guard let data = data else {return}
            do{
                let garages = try JSONDecoder().decode([Garage].self, from: data)
                for garage in garages {
                    print(garage);
                    self.Garages.append(garage)
                }
            }catch let err{
                print (err)
            }
            apicall.leave()
        }
        .resume()
        apicall.notify(queue: .main){
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        headerBackground.layer.cornerRadius = headerBackground.frame.width/15
        refresh.imageEdgeInsets = UIEdgeInsets(top: 10,left: 10,bottom: 10,right: 10)
        refresh.layer.cornerRadius = headerBackground.frame.width/35
        refresh.clipsToBounds = false;
        refresh.layer.shadowColor = UIColor.black.cgColor;
        refresh.layer.shadowOffset = .zero;
        refresh.layer.shadowOpacity = 1;
        refresh.layer.shadowRadius = 15;
        pullApi()
    
        //timer calls pull api to refresh data every 30seconds.
        let timer = Timer.scheduledTimer(timeInterval: 60.0, target: self, selector: #selector(pullApi), userInfo: nil, repeats: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "toSingle") {
            let vc = segue.destination as! ViewController
            vc.currGar = self.carryGarry
        }
    }
    
    //TABLE VIEW CALLS
    // Return the number of rows for the table.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {return Garages.count * 2}

    // Provide a cell object for each row.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       // Fetch a cell of the appropriate type.
        if (indexPath.row % 2) == 0 {
            let gapCell = tableView.dequeueReusableCell(withIdentifier: "gap") as! gapTableViewCell
             return gapCell
        }
        let currGar = Garages[indexPath.row / 2]
        let cell = tableView.dequeueReusableCell(withIdentifier: "garagescell") as! garageTableViewCell
        cell.setup(garage: currGar )
       
       return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.row % 2) == 0 {return 20}

        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        carryGarry = Garages[indexPath.row/2]
        self.performSegue(withIdentifier: "toSingle", sender: Any?.self)
    }

}
