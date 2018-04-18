//
//  GameViewController.swift
//  Helgeson-Jerdon_HW12_SceneKitShapeGame
//
//  Created by Jerdon Helgeson on 4/17/18.
//  Copyright © 2018 Jerdon Helgeson. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit
import AVFoundation
import AudioToolbox.AudioServices

/*
class GameSound {
    private static let turkey = SCNAudioSource(fileNamed: "Turkey.mp3")
    private static let cluck = SCNAudioSource(fileNamed: "cluck.mp3")
    private static let squak = SCNAudioSource(fileNamed: "cockatiel.mp3")
    
    static func vibrate() {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
    }
    private static func play(_ name: String, source: SCNAudioSource, node: SCNNode) {
        let _ = SCNAudioPlayer() //(name: name, source: source, node: node)
    }
    static func turkey(_ node: SCNNode) {
        guard turkey != nil else { return }
        GameSound.play("turkey", source: GameSound.turkey!, node: node)
        GameSound.vibrate()
    }
    static func squak(_ node: SCNNode) {
        guard squak != nil else { return }
        GameSound.play("squak", source: GameSound.squak!, node: node)
        GameSound.vibrate()
    }
    static func cluck(_ node: SCNNode) {
        guard cluck != nil else { return }
        GameSound.play("cluck", source: GameSound.cluck!, node: node)
    }
}
 */




class GameViewController: UIViewController {
    
    
    var player: AVAudioPlayer?
    var scnView: SCNView!
    var sceneView: SCNView!
    var scnScene: SCNScene!
    var cameraNode: SCNNode!
    var turkeyAction: SCNAction!
    var cluckAction: SCNAction!
    var cockAction: SCNAction!
    var onOffSwitch = false;
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //pStartSound()
        setupView()
        setupScene()
        setupCamera()
        
        //spawnShape()
        let audioSource = SCNAudioSource(named: "Turkey.mp3")
        turkeyAction = SCNAction.playAudio(audioSource!,waitForCompletion: false)
        let nodeA = self.cameraNode
        nodeA?.runAction(turkeyAction)
        
        
        // configure the view
        scnView.backgroundColor = UIColor.red
        
        // add a tap gesture recognizer
        //let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        //scnView.addGestureRecognizer(tapGesture)
    }
    
    @objc
    func handleTap(_ gestureRecognize: UIGestureRecognizer) {
        
        //spawnShape()
        
    }
    
    func pStartSound()
    {
        var turkeyAction: SCNAction!
        let audioSource = SCNAudioSource(named: "Turkey.mp3")
        turkeyAction = SCNAction.playAudio(audioSource!,waitForCompletion: false)
        let nodeA = SCNNode()
        nodeA.runAction(turkeyAction)
    }
    
    func playStartSound() {
        var audioPlayer: AVAudioPlayer!
        let musicURL = Bundle.main.url(forResource: "Turkey.mp3",
                                       withExtension: nil)
        guard let url = Bundle.main.url(forResource: "Turkey", withExtension: "mp3") else { return }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: musicURL!)
        } catch {
            print("error accessing music")
        }
        audioPlayer.volume = 0.25
        audioPlayer.numberOfLoops = -1 // loop forever
        audioPlayer.play() // In startGame()
        
    }
    
    
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func setupView() {
        scnView = self.view as! SCNView
        
        scnView.showsStatistics = true
        // 2
        scnView.allowsCameraControl = false
        // 3
        scnView.autoenablesDefaultLighting = true
    }
    
    func setupScene() {
        scnScene = SCNScene()
        scnView.scene = scnScene
    }
    
    func setupCamera() {
        // 1
        cameraNode = SCNNode()
        // 2
        cameraNode.camera = SCNCamera()
        // 3
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 10)
        // 4
        scnScene.rootNode.addChildNode(cameraNode)
    }
    
    func spawnShape() {
        // 1
        var geometry:SCNGeometry
        // 2
        let tempShape = Shapes.random()
        switch tempShape {
        case .Box:
            geometry = SCNBox(width: 1.0, height: 1.0, length: 1.0, chamferRadius: 0.0)
        //print(geometry)
        case .Sphere:
            geometry = SCNSphere()
        //print(geometry)
        case .Pyramid:
            geometry = SCNPyramid()
        //print(geometry)
        case .Torus:
            geometry = SCNTorus()
        //print(geometry)
        case .Capsule:
            geometry = SCNCapsule()
        //print(geometry)
        case .Cylinder:
            geometry = SCNCylinder()
        //print(geometry)
        case .Cone:
            geometry = SCNCone()
        //print(geometry)
        case .Tube:
            geometry = SCNTube()
            //print(geometry)
        }
        // 4
        let geometryNode = SCNNode(geometry: geometry)
        geometryNode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
        
        let randomX = Float.random(min: -2, max: 2)
        
        let randomY = Float.random(min: 10, max: 18)
        // 2
        let force = SCNVector3(x: randomX, y: randomY , z: 0)
        // 3
        let position = SCNVector3(x: 0.05, y: 0.05, z: 0.05)
        // 4
        geometryNode.physicsBody?.applyForce(force, at: position, asImpulse: true)
        // 5
        scnScene.rootNode.addChildNode(geometryNode)
    }
    
    func spawnShape2(loc :CGPoint) {
        // 1
        var geometry:SCNGeometry
        let xLoc = Float(loc.x)
        let yLoc = Float(loc.y)
        
        // 2
        let tempShape = Shapes.random()
        switch tempShape {
        case .Box:
            geometry = SCNBox(width: 3.0, height: 3.0, length: 3.0, chamferRadius: 0.0)
            //print(geometry)
        case .Sphere:
            geometry = SCNSphere(radius: 3.0)
            //print(geometry)
        case .Pyramid:
            geometry = SCNPyramid()
            //print(geometry)
        case .Torus:
            geometry = SCNTorus()
            //print(geometry)
        case .Capsule:
            geometry = SCNCapsule()
            //print(geometry)
        case .Cylinder:
            geometry = SCNCylinder()
            //print(geometry)
        case .Cone:
            geometry = SCNCone()
            //print(geometry)
        case .Tube:
            geometry = SCNTube()
            //print(geometry)
        }
        
        //pStartSound()
        if(onOffSwitch == false)
        {
            let audioSource = SCNAudioSource(named: "cluck.mp3")
            cluckAction = SCNAction.playAudio(audioSource!,waitForCompletion: false)
            let nodeA = self.cameraNode
            nodeA?.runAction(cluckAction)
            //onOffSwitch = true
        }
        else
        {
            let audioSource = SCNAudioSource(named: "cockatiel.mp3")
            cockAction = SCNAction.playAudio(audioSource!,waitForCompletion: false)
            let nodeA = self.cameraNode
            nodeA?.runAction(cockAction)
            onOffSwitch = false
        }
        
        //geometry.setValue(SCNVector3(x: xLoc, y: yLoc, z: 1.05), forKeyPath: "Position")
        
        let geometryNode = SCNNode(geometry: geometry)
        
        geometryNode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
        
        
        let randomX = Float.random(min: -2, max: 2)
        let forceX = (200 - Float(loc.x))
        let remX = -forceX.truncatingRemainder(dividingBy: 10)
        let randomY = Float.random(min: 10, max: 18)
        let forceY = Float(loc.y)
        let remY = forceY.truncatingRemainder(dividingBy: 30)
        // 2
        let force = SCNVector3(x: remX, y: remY , z: -50)
        // 3
        
        let position = SCNVector3(x: 0.05, y: 0, z: 1.05)
        // 4
        geometryNode.physicsBody?.applyForce(force, at: position, asImpulse: true)
        // 5
        
        scnScene.rootNode.addChildNode(geometryNode)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let clickLocation = touch.location(in: scnView)
        let position = touch.location(in: view)
        print(position)
        //spawnShape()
        spawnShape2(loc: position)
    }
    
    
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    

}
