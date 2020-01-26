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
    //Outlets

    
    @IBOutlet weak var headerBackground: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    
    
    
    //Vars
    var Garages: [Garage] = []
    var taken: Int!
    var total: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // hard data View setup
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
        cell.setup(name: currGar.garageName , local: currGar.address )
       
       return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.row % 2) == 0 {return 30}

        return 80
    }

}
