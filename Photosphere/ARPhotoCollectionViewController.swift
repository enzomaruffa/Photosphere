//
//  ARPhotoCollectionViewController.swift
//  Photosphere
//
//  Created by Enzo Maruffa Moreira on 07/06/19.
//  Copyright © 2019 Enzo Maruffa Moreira. All rights reserved.
//

import UIKit
import ARKit


class ARPhotoCollectionViewController: UIViewController, ARSCNViewDelegate {
    
    var photoCollection: PhotoCollection!
    
    @IBOutlet weak var sceneView: ARSCNView!
    @IBOutlet var rightSwipe: UISwipeGestureRecognizer!
    
    var photoNodes: [SCNNode] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Create a new scene
        let scene = SCNScene()
        
        // Set the scene to the view
        sceneView.scene = scene
    }
    
    override func viewDidAppear(_ animated: Bool) {
        for (index, photo) in photoCollection.photos.enumerated() {
            
            let imageWidth = photo.photo.size.width
            let imageHeight = photo.photo.size.height
            
            let node = SCNNode.init(geometry: SCNBox(width: imageWidth/4500, height: imageHeight/4500, length: 0.01, chamferRadius: 0.01))
            
            if photoCollection.photos.count < 30 {
                node.position = calculateNodePositionCircle(currentIndex: index, max: photoCollection.photos.count)
            } else {
                node.position = calculateNodePositionSphere(currentIndex: index, max: photoCollection.photos.count)
            }
            node.geometry?.firstMaterial?.diffuse.contents = photo.photo
            
            print(node.position)
            
            node.look(at: SCNVector3(0, 0, 0))
            
            photoNodes.append(node)
            sceneView.scene.rootNode.addChildNode(node)
        }
    }
    
    func calculateNodePositionCircle(currentIndex: Int, max: Int) -> SCNVector3 {
        let radius = 0.7 + (max > 8 ? Double(max) * 0.03 : 0)
        
        let angle = (Double(360) / Double(max) * Double(currentIndex)).degreesToRadians
        
        let x = radius * sin(angle);
        let z = radius * cos(angle);
        
        return SCNVector3(x: Float(x), y: 0, z: Float(z))
    }
    
    func calculateNodePositionSphere(currentIndex: Int, max: Int) -> SCNVector3 {
        let radius = 1 + (max > 40 ? Double(max) * 0.07 : 0)
        
        let currentCircle: Int
        let ringMax: Int
        let currentRingIndex: Int
        
        let middleCircleSize = (max - 10) / 2
        //minsize is 30
        if currentIndex == 0 {
            currentCircle = -3
            ringMax = 1
        } else if currentIndex >= 1 && currentIndex < 5 {
            currentCircle = -2
            ringMax = 4
        } else if currentIndex >= 5 && currentIndex < 5 + middleCircleSize / 2 {
            currentCircle = -1
            ringMax = middleCircleSize / 2
        } else if currentIndex >= 5 + (middleCircleSize / 2) && currentIndex < 5 + (middleCircleSize / 2) + middleCircleSize {
            currentCircle = 0
            ringMax = middleCircleSize
        } else if currentIndex >= 5 + (middleCircleSize / 2) + middleCircleSize && currentIndex < 5 + (middleCircleSize) + middleCircleSize {
            currentCircle = 1
            ringMax = middleCircleSize / 2
        } else if currentIndex >= max - 5 && currentIndex < max - 1 {
            currentCircle = 2
            ringMax = 4
        } else {
            currentCircle = 3
            ringMax = 1
        }
        
        print(currentIndex, currentCircle)
        
        currentRingIndex = currentIndex % ringMax
        
        let y = 0 + (radius/3 * Double(currentCircle))
        
        let angle = (Double(360) / Double(ringMax) * Double(currentRingIndex)).degreesToRadians
        
        let x = (radius - abs(y)) * sin(angle);
        let z = (radius - abs(y)) * cos(angle);
        
        return SCNVector3(x: Float(x), y: Float(y), z: Float(z))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    public func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        guard let frame = self.sceneView.session.currentFrame else {
            return
        }
        let mat = SCNMatrix4(frame.camera.transform) // 4x4 transform matrix describing camera in world space
        let pos = SCNVector3(mat.m41, mat.m42, mat.m43) // location of camera in world space
        
        for node in sceneView.scene.rootNode.childNodes {
            node.look(at: pos)
        }
    }
    
    @IBAction func leftSwipeDone(_ sender: UISwipeGestureRecognizer) {
        
        let hitResults = sceneView.hitTest(sender.location(in: sceneView), options: nil)
        
        print("rotating left!")
        
        if let result = hitResults.first {
            rotateNodesLeft()
        }
        
    }
    
    func rotateNodesLeft() {
        var actions: [SCNAction] = []
        for index in 0 ..< photoNodes.count {
            let action = SCNAction.move(to: photoNodes[(index + photoNodes.count + 1) % photoNodes.count].position, duration: 0.5)
            actions.append(action)
        }
        
        for (index, node) in photoNodes.enumerated() {
            node.runAction(actions[index])
        }
    }
    
    @IBAction func rightSwipeDone(_ sender: UISwipeGestureRecognizer) {
        
        let hitResults = sceneView.hitTest(sender.location(in: sceneView), options: nil)
        
        if let result = hitResults.first {
            rotateNodesRight()
        }
        
    }
    
    func rotateNodesRight() {
        var actions: [SCNAction] = []
        for index in 0 ..< photoNodes.count {
            let action = SCNAction.move(to: photoNodes[(index + photoNodes.count - 1) % photoNodes.count].position, duration: 0.5)
            actions.append(action)
        }
        
        for (index, node) in photoNodes.enumerated() {
            node.runAction(actions[index])
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension FloatingPoint {
    var degreesToRadians: Self { return self * .pi / 180 }
    var radiansToDegrees: Self { return self * 180 / .pi }
}
