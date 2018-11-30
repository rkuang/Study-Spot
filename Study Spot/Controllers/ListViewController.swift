//
//  ViewController.swift
//  Study Spot
//
//  Created by Ricky Kuang on 11/19/18.
//  Copyright © 2018 Ricky Kuang. All rights reserved.
//

import UIKit
import FirebaseFirestore

class ListViewController: UITableViewController {
    
    var db: Firestore!
    var spots = [StudySpot]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundView = nil
        tableView.backgroundColor = UIColor(red: 241/255, green: 241/255, blue: 241/255, alpha: 1)
        
        getSpots()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return spots.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath) as! ListViewCell
        cell.populate(spot: spots[indexPath.row])
        return cell
    }
    
    func getSpots() {
        db = Firestore.firestore()
        let query = db.collection("spots").limit(to: 25)
        query.getDocuments { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    if let model = StudySpot(dictionary: document.data()) {
                        print("\(document.documentID) => \(document.data())")
                        self.spots.append(model)
                    } else {
                        print("error")
                    }
                }
            }
            print(self.spots)
            self.tableView.reloadData()
        }
    }
    
    
}

