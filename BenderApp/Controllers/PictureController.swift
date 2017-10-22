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
    
    @IBOutlet weak var materialView: UIView!
    @IBOutlet weak var technicView: UIView!
    
    var pictureInfo = PictureInfo(dictionary: [:])
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Объект"
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 40
    }

    func loadPictureInfo(id: String) {

        NetworkManager.shared.getPicture(id: id, success: { (picture) in
            
            self.pictureInfo = picture
            
            self.imageView.af_setImage(withURL: picture.imageURL!)
            self.titleLabel.text = picture.title
            
            if let country = picture.country {
                self.descriptionLabel.text = "\(country). \(picture.time ?? "")"
            } else {
                self.descriptionLabel.text = picture.time
            }
            
            if let material = picture.material {
                self.materialView.isHidden = false
                self.materialLabel.text = material
            } else {
                self.materialView.isHidden = true
            }
        
            if let technic = picture.technic {
                self.technicView.isHidden = false
                self.technicLabel.text = technic
            } else {
                self.technicView.isHidden = true
            }
            
        }, failure: nil)
    }
    
    @IBAction func showRouteAction(_ sender: UIButton) {
        
        if let tabBarController = self.tabBarController {
            
            if let viewControllers = tabBarController.viewControllers {
                let vc = viewControllers[1] as! MapController
                
                NetworkManager.shared.getRoute(from: 13, to: self.pictureInfo.room!, success: { (route) in
                    
                    DispatchQueue.main.async {
                        vc.showRoute(route)
                        tabBarController.selectedIndex = 1
                    }
                    
                }, failure: { (error) in
                    
                    DispatchQueue.main.async {
                        sender.isEnabled = false
                    }
                })
            }
        }
    }
}
