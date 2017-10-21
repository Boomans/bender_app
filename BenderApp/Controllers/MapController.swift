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
    
    let routeOffsetX: CGFloat = 5
    let routeOffsetY: CGFloat = 5
    
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
        
        //showRoom(id: 11, atFloor: 1)
        //showRoom(id: 12, atFloor: 1)
        //showRoom(id: 13, atFloor: 1)
        //showRoom(id: 14, atFloor: 1)
        //showRoom(id: 15, atFloor: 1)
        //showRoom(id: 16, atFloor: 1)
        showRoute(Route(path: [11, 12, 13, 14, 15, 16]))
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
    
    func showRoute(_ route: Route) {
        
        // Create line
        let line = UIBezierPath()
        
        for id in route.path {
            let room = RoomsManager.shared.getRoom(id: id)
            
            if let room = room {
    
                let center = room.center
                
                if id == route.path.first {
                    line.move(to:center)
                }
                
                // FIXME: Test calutation of control points
                let controlPoint1 = CGPoint(x: center.x + routeOffsetX, y: center.y - routeOffsetY)
                let controlPoint2 = CGPoint(x: center.x - routeOffsetX, y: center.y + routeOffsetY)
                line.addCurve(to: room.center, controlPoint1: controlPoint1, controlPoint2: controlPoint2)
                
            } else {
                continue
            }
        }

        // Design line in layer
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = line.cgPath
        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeLayer.fillColor = UIColor.white.withAlphaComponent(0).cgColor
        shapeLayer.lineWidth = 4.0
        
        mapView.zoomView?.layer.addSublayer(shapeLayer)
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

