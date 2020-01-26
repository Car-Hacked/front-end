//
//  StackViewController.swift
//  ParkALot
//
//  Created by Aidan Gutierrez on 1/25/20.
//  Copyright © 2020 Spencer Jolie. All rights reserved.
//

import UIKit

class StackViewController: UIViewController {
    //Outlets
    @IBOutlet weak var Stack: UIStackView!
    
    
    
    //Vars
    var Garages: [Garage] = []
    var taken: Int!
    var total: Int!
    
    func createButtons(){
        for garage in  Garages{
            let button = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
            button.backgroundColor = UIColor.magenta
            button.setTitle(garage.name, for: .normal)
            //button.addTarget(self, action: #selector(handelButton), for: .touchUpInside)
            button.clipsToBounds = false
            button.layer.cornerRadius = button.frame.width / 30;
            Stack.addArrangedSubview(button)
        }
    }
    
//    @objc func handelButton(sender: UIButton){
//        for rapper in wrappers {
//            if rapper.name == sender.titleLabel?.text{
//                carryName = rapper.name
//                carryDescription = rapper.description
//                carryImage = sender.currentBackgroundImage
//            }
//        }
//        let singleDisplay = ViewController()
//        singleDisplay.Name = carryName
//        RVC.Image = carryImage
//        RVC.Description = carryDescription
//        self.present(RVC, animated: true, completion: nil)
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Api Call
        let apicall = DispatchGroup();
        let garageJson = "https://park-hack-api.herokuapp.com/garages"
        guard let url = URL(string: garageJson) else {return}
        apicall.enter();
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {print(error)}
            guard let data = data else {return}
            do{
                let garages = try JSONDecoder().decode([Garage].self, from: data)
                //self.garageList.append(garages.Garage)
                print(garages);
                
                for garage in garages {
                    var garageObj: Garage!
                    garageObj.name = garage.name
                    garageObj._id = garage._id
                    self.taken = selectedGarage.carsInLot
                    self.total = selectedGarage.capacity
                }
                
//                self.avail = self.total - self.taken;
                
            }catch let err{
                print (err)
                
            }
            apicall.leave()
        }
        .resume()
        apicall.notify(queue: .main){
//            self.ttlAvl = "Total Spots Available: " + String(self.avail);
//            self.availableSpots.text = self.ttlAvl ;
//            self.track.text = self.trackTtl;
//            self.parking.text = self.parkingTtl;
//            self.outOf.text = String(self.taken) + self.slashT + String(self.total) + self.sptFll;
            
            for button in buttons{
                button.imageView?.contentMode = .scaleAspectFill
                button.subviews.first?.contentMode = .scaleAspectFill
                stackview.addArrangedSubview(button)
            }
        }
        
    }

}
