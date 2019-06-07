//
//  ARPhotoCollectionViewController.swift
//  Photosphere
//
//  Created by Enzo Maruffa Moreira on 07/06/19.
//  Copyright © 2019 Enzo Maruffa Moreira. All rights reserved.
//

import UIKit
import ARKit


class ARPhotoCollectionViewController: UIViewController, ARSKViewDelegate {
    
    var photoCollection: PhotoCollection!
    
    @IBOutlet weak var sceneView: ARSKView!
    
    var photoTextures: [SKTexture]!
    var photoNodes: [SKSpriteNode] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and node count
        sceneView.showsFPS = true
        sceneView.showsNodeCount = true
        
        // Load the SKScene from 'Scene.sks'
        if let scene = SKScene(fileNamed: "Scene") as? GameScene {
            photoTextures = photoCollection.photos.map( { SKTexture(image: $0) } )
            sceneView.presentScene(scene)
        }

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    func view(_ view: ARSKView, nodeFor anchor: ARAnchor) -> SKNode? {
        // Create and configure a node for the anchor added to the view's session.
        for texture in photoTextures {
            let node = SKSpriteNode(texture: texture)
            node.size = CGSize(width: 100, height: 100)
            photoNodes.append(node)
        }
        
        for (i, node) in photoNodes.enumerated() {
            if node != photoNodes.first {
                photoNodes.first?.addChild(node)
                node.position = CGPoint(x: 110 * i, y: 0)
            }
        }
        
        return photoNodes.first
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
