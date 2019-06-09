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
    
    var photoNodes: [SCNNode] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create a new scene
        let scene = SCNScene()
        
        // Set the scene to the view
        sceneView.scene = scene
    }
    
    override func viewDidAppear(_ animated: Bool) {
        for (index, photo) in photoCollection.photos.enumerated() {
            let node = SCNNode.init(geometry: SCNBox(width: 0.2125, height: 0.45, length: 0.01, chamferRadius: 0.2))
            
            node.position = calculateNodePositionCircle(currentIndex: index, max: photoCollection.photos.count)
            node.geometry?.firstMaterial?.diffuse.contents = photo.photo
            
            print(node.position)
            
            node.look(at: SCNVector3(0, 0, 0))
            
            photoNodes.append(node)
            sceneView.scene.rootNode.addChildNode(node)
        }
    }
    
    func calculateNodePositionCircle(currentIndex: Int, max: Int) -> SCNVector3 {
        let radius = 0.7 + (max > 8 ? Double(max) * 0.05 : 0)
        
        let angle = (Double(360) / Double(max) * Double(currentIndex)).degreesToRadians
        
        let x = radius * sin(angle);
        let z = radius * cos(angle);
        
        return SCNVector3(x: Float(x), y: 0, z: Float(z))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        
        // Run the view's session
        sceneView.session.run(configuration)
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
