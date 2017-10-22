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
        mapView.contentInset = UIEdgeInsetsMake(40, 0, 0, 0)
        
        selectFloorAction(floorButtons[currentFloor-1])
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapOnMapAction(_:)))
        mapView.zoomView?.isUserInteractionEnabled = true
        mapView.zoomView?.addGestureRecognizer(tapGestureRecognizer)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //showRoom(id: 11, atFloor: 1)
        //showRoute(Route(path: [11, 12, 13, 14, 15, 16]))
    }

    // MARK: Map
    
    func loadMap(floor: Int) {
        let map = UIImage(named:"Floor\(floor)") ?? UIImage()
        mapView.display(image: map)
    }
    
    func showPoint(_ point: CGPoint) {
        
        let radius: CGFloat = 5
        
        let view = UIView(frame: CGRect(origin: point, size: CGSize(width: 2*radius, height: 2*radius)))
        view.layer.cornerRadius = radius
        view.backgroundColor = UIColor(displayP3Red: 193/255, green: 65/255, blue: 83/255, alpha: 1)
        mapView.zoomView?.addSubview(view)
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
        
        // Create route line
        let routeLine = UIBezierPath()
        
        var lastRoom: Room?
        for id in route.path {
            let room = RoomsManager.shared.getRoom(id: id)

            if let lastRoom = lastRoom {
                if let room = room {
                 
                    var point = CGPoint()
                    if let enter = lastRoom.enterToRoom(id: room.id) {
                        point = enter.point
                    } else {
                        point = room.center
                    }
                    
                    routeLine.addLine(to: point)
                    routeLine.addArc(withCenter: point, radius: 0.5, startAngle: 0, endAngle: 2*CGFloat.pi, clockwise: true)
                    
                } else {
                    continue
                }
            } else {
                lastRoom = room
                routeLine.move(to:(room?.center ?? CGPoint(x: 0, y: 0)))
            }
            
            lastRoom = room
        }

        // Design line in layer
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = routeLine.cgPath
        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeLayer.fillColor = UIColor.white.withAlphaComponent(0).cgColor
        shapeLayer.lineWidth = 3.0
        
        // Add layer with route line
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
    
    @IBAction func findLocationAction(_ sender: Any) {
        
        if let room = RoomsManager.shared.getRoom(id: 13) {
            showPoint(room.center)
            mapView.zoom(to: room.frame, animated: true)
        }
    }
}
