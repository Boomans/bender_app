//
//  FloorButton.swift
//  BenderApp
//
//  Created by bestK1ng on 21/10/2017.
//  Copyright © 2017 bestK1ng. All rights reserved.
//

import UIKit

class FloorButton: UIButton {

    enum SelectedState {
        case selected
        case unselected
    }
    
    var selectedState: SelectedState = .unselected {
        didSet {
            updateState()
        }
    }
    
    private func updateState() {
        
        switch(selectedState) {
        case .selected:
            backgroundColor = UIColor(displayP3Red: 51/255, green: 102/255, blue: 102/255, alpha: 1.0)
            setTitleColor(UIColor.white, for: .normal)
            break
        case .unselected:
            backgroundColor = UIColor.white.withAlphaComponent(0)
            setTitleColor(UIColor(displayP3Red: 51/255, green: 102/255, blue: 102/255, alpha: 1.0), for: .normal)
            break
        }
    }
}
