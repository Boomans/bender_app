//
//  PictureController.swift
//  BenderApp
//
//  Created by a.belkov on 22/10/2017.
//  Copyright © 2017 bestK1ng. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class PictureController: UITableViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var materialLabel: UILabel!
    @IBOutlet weak var technicLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Объект"
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 40
    }

    func loadPictureInfo(id: String) {

        NetworkManager.shared.getPicture(id: id, success: { (picture) in
            
            self.imageView.af_setImage(withURL: picture.imageURL!)
            self.titleLabel.text = picture.title
            
            if let country = picture.country {
                self.descriptionLabel.text = "\(country). \(picture.time ?? "")"
            } else {
                self.descriptionLabel.text = picture.time
            }
            
            if let material = picture.material {
                self.materialLabel.isHidden = false
                self.materialLabel.text = material
            } else {
                self.materialLabel.isHidden = true
            }
        
            if let technic = picture.technic {
                self.technicLabel.isHidden = false
                self.technicLabel.text = technic
            } else {
                self.technicLabel.isHidden = true
            }
            
        }, failure: nil)
    }
    
    @IBAction func showRouteAction(_ sender: Any) {
        
        if let tabBarController = self.tabBarController {
            tabBarController.selectedIndex = 1
        }
    }
}
