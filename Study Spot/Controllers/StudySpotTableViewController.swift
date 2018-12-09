//
//  ViewController.swift
//  Study Spot
//
//  Created by Ricky Kuang on 11/19/18.
//  Copyright © 2018 Ricky Kuang. All rights reserved.
//

import UIKit
import FirebaseFirestore

class StudySpotTableViewController: UITableViewController {
    
    var db: Firestore!
    var studySpots = [StudySpot]()
    var docRefs = [DocumentReference]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundView = nil
        tableView.backgroundColor = UIColor(red: 241/255, green: 241/255, blue: 241/255, alpha: 1)
        
//        getSpots()
        test()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studySpots.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath) as! ListViewCell
        cell.populate(spot: studySpots[indexPath.row])
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "detailSegue") {
            let vc = segue.destination as! StudySpotDetailViewController
            let index = self.tableView.indexPathForSelectedRow!.row
            vc.spot = studySpots[index]
            vc.docRef = docRefs[index]
        }
    }
    
    func test() {
        Firestore.firestore().retrieveStudySpots { (spots, docRefs) in
            self.studySpots = spots
            self.docRefs = docRefs
            self.tableView.reloadData()
        }
    }
}

