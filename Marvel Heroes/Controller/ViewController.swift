//
//  ViewController.swift
//  Marvel Heroes
//
//  Created by Владислав Керечанин on 25.11.2020.
//

import UIKit

class ViewController: UITableViewController {

    
    var pictures = [String]()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Marvel Heroes"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        
        let fileManager = FileManager.default
        
        let path = Bundle.main.resourcePath!
        
        let items = try! fileManager.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasSuffix(".jpg") {
                pictures.append(item)
            }
        }
    }

    
    
    override func tableView(_: UITableView, numberOfRowsInSection: Int) -> Int {
         return pictures.count
     }
     
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = String(pictures[indexPath.row].dropLast(4))
        return cell
     }
     
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectedImage = pictures[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }

}
                
