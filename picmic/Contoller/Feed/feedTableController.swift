//
//  feedTableController.swift
//  picmic
//
//  Created by mac on 2018. 9. 15..
//  Copyright © 2018년 mac. All rights reserved.
//

import Foundation
import UIKit

class feedTableController:UITableView{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Section \(section)"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "feedCell", for: indexPath)
        
        cell.textLabel?.text = "Section \(indexPath.section) Row \(indexPath.row)"
        
        return cell
    }
    
}
