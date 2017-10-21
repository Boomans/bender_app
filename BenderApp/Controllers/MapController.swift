//
//  SecondViewController.swift
//  BenderApp
//
//  Created by bestK1ng on 20/10/2017.
//  Copyright © 2017 bestK1ng. All rights reserved.
//

import UIKit

class MapController: UIViewController {

    @IBOutlet weak var floorLabel: UILabel!
    @IBOutlet var floorButtons: [FloorButton]!
    @IBOutlet weak var mapView: MapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        selectFloorAction(floorButtons[0])
    }

    // MARK: Map
    
    func loadMap(floor: Int) {
        let map = UIImage(named:"Floor\(floor)") ?? UIImage()
        mapView.display(image: map)
    }
    
    // MARK: Actions
    
    @IBAction func selectFloorAction(_ sender: FloorButton) {
        
        // Update button states
        for button in floorButtons {
            if button == sender {
                button.selectedState = .selected
            } else {
                button.selectedState = .unselected
            }
        }
        
        // Update label
        floorLabel.text = "\((sender.titleLabel?.text)!) этаж"
        
        // Load needed map
        loadMap(floor: Int((sender.titleLabel?.text)!) ?? 1)
    }
}

