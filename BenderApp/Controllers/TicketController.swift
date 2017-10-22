//
//  TicketController.swift
//  BenderApp
//
//  Created by a.belkov on 21/10/2017.
//  Copyright © 2017 bestK1ng. All rights reserved.
//

import UIKit

class TicketController: UIViewController {

    @IBOutlet weak var tickerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Do any additional setup after loading the view.
        let shadowView = UIView(frame: tickerView.frame)
        shadowView.translatesAutoresizingMaskIntoConstraints = false
        shadowView.backgroundColor = UIColor.white
        shadowView.layer.masksToBounds = false
        shadowView.layer.shadowOffset = CGSize(width: 2.5, height: 2.5)
        shadowView.layer.shadowOpacity = 0.3
        shadowView.layer.shadowRadius = 15
        shadowView.layer.cornerRadius = 15
        
        self.view.insertSubview(shadowView, at: 0)
    }
}
