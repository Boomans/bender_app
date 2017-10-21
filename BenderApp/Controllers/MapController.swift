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
    
    var currentFloor: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        selectFloorAction(floorButtons[currentFloor-1])
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapOnMapAction(_:)))
        mapView.zoomView?.isUserInteractionEnabled = true
        mapView.zoomView?.addGestureRecognizer(tapGestureRecognizer)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        showRoom(id: 11, atFloor: 1)
        showRoom(id: 12, atFloor: 1)
        showRoom(id: 13, atFloor: 1)
        showRoom(id: 14, atFloor: 1)
        showRoom(id: 15, atFloor: 1)
        showRoom(id: 16, atFloor: 1)
    }

    // MARK: Map
    
    func loadMap(floor: Int) {
        let map = UIImage(named:"Floor\(floor)") ?? UIImage()
        mapView.display(image: map)
    }
    
    func showRoom(id: Int, atFloor floor: Int) {
        
        let room = RoomsManager.shared.getRoom(id: id)
        
        if let room = room, currentFloor == floor {
            let roomView = UIView(frame: room.frame)
            roomView.backgroundColor = UIColor(displayP3Red: CGFloat(arc4random()) / CGFloat(UInt32.max),
                                               green: CGFloat(arc4random()) / CGFloat(UInt32.max),
                                               blue: CGFloat(arc4random()) / CGFloat(UInt32.max),
                                               alpha: 1.0)
            
            mapView.zoomView?.addSubview(roomView)
            print("Show room \(id) \(room.frame)")
        } else {
            print("Can't find room \(id)")
        }
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
        
        // Update floor & label
        currentFloor = Int((sender.titleLabel?.text)!) ?? 1
        floorLabel.text = "\((sender.titleLabel?.text)!) этаж"
        
        // Load needed map
        loadMap(floor: currentFloor)
    }
    
    @objc func tapOnMapAction(_ sender: UITapGestureRecognizer) {
        print("Tap in \(sender.location(in: mapView.zoomView))")
    }
}

