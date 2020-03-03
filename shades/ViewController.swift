//
//  ViewController.swift
//  shades
//
//  Created by Sagar Modak on 03/03/20.
//  Copyright © 2020 Sagar Modak. All rights reserved.
//

import UIKit
import RealityKit
import ARKit

class ViewController: UIViewController {
    
    @IBOutlet var arView: ARView!
    var index: Int = 0
    let numberOfShades: Int = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let gesture = UISwipeGestureRecognizer()
        gesture.numberOfTouchesRequired = 1
        gesture.addTarget(self, action: #selector(detectSwipeGesture(gesture:)))
        arView.addGestureRecognizer(gesture)
        
        let config = ARFaceTrackingConfiguration()
        arView.session.run(config)
        
        let blackShade = try! Shades.loadBlack()
        arView.scene.anchors.append(blackShade)
    }
    
    @objc func detectSwipeGesture(gesture: UISwipeGestureRecognizer) {
        if gesture.direction == .right {
            changeShade()
        }
    }
    
    func changeShade() {
        if index == numberOfShades {
            index = 0
        } else {
            index = index + 1
        }
        arView.scene.anchors.removeAll()
        loadShadeWith(sceneNumber: index)
    }
    
    func loadShadeWith(sceneNumber: Int) {
        switch sceneNumber {
        case 0:
            let blackShade = try! Shades.loadBlack()
            arView.scene.anchors.append(blackShade)
        case 1:
            let yellowShade = try! Shades.loadYellow()
            arView.scene.anchors.append(yellowShade)
        case 2:
            let beachShade = try! Shades.loadBeach()
            arView.scene.anchors.append(beachShade)
        default:
            let blackShade = try! Shades.loadBlack()
            arView.scene.anchors.append(blackShade)
        }
    }
}
