//
//  GameScene.swift
//  HW11AirPlane
//
//  Created by Jerdon Helgeson on 4/10/18.
//  Copyright © 2018 Jerdon Helgeson. All rights reserved.
//

import SpriteKit
import GameplayKit
import AVFoundation

class GameScene: SKScene {
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    let gameOverLabel = SKLabelNode(text: "Game Over")
    let titleLabel = SKLabelNode(text: "Flight Simulator")
    let startGameLabel = SKLabelNode(text: "Tap To Start")
    let airplaneSprite = SKSpriteNode(imageNamed: "airplane.png")
    let border = SKRegion(size: CGSize(width: 668, height: 375))
    
    let tapRec = UITapGestureRecognizer()
    var endGame = false
    var startGame = false
    var audioPlayer: AVAudioPlayer!
    let musicURL = Bundle.main.url(forResource: "MiiSong.mp3",
                                   withExtension: nil)
    
    let moveUp = SKAction.moveBy(x: 0, y:100, duration: 1.0)
    
    
    
    override func didMove(to view: SKView) {
        
       
        
        
        //self.label = self.childNode(withName: "GameOverLabel") as? SKLabelNode
        
        //titleLabel.horizontalAlignmentMode = .center
        //titleLabel.verticalAlignmentMode = .top
        self.physicsWorld.gravity = CGVector(dx: 0, dy: -1)
        titleLabel.position = CGPoint(x: frame.midX, y: frame.maxY - titleLabel.frame.height)
        airplaneSprite.size = CGSize(width: 150, height: 150)
        airplaneSprite.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 150, height: 150))
        airplaneSprite.name = "airplane"
        airplaneSprite.physicsBody?.affectedByGravity = false;
        startGameLabel.position = CGPoint(x: frame.midX, y: frame.minY + startGameLabel.frame.height)
        startGameLabel.name = "Start Game"
        addChild(titleLabel)
        addChild(airplaneSprite)
        addChild(startGameLabel)
        
        
            
        tapRec.addTarget(self, action:#selector(GameScene.tappedView(_:) ))
        tapRec.numberOfTouchesRequired = 1
        tapRec.numberOfTapsRequired = 1
        self.view!.addGestureRecognizer(tapRec)
        
       //airplaneSprite.run(moveUp)
        
    }
    
    func checkCollisions()
    {
        //let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        enumerateChildNodes(withName: "airplane")
        {node ,_ in
            let plane = node as! SKSpriteNode
            
            
            if (!self.intersects(plane) && self.endGame == false) {
                print("PLANE HIT THE WALL")
                self.endGame = true
            }

            
        }
        
    }
    
    
    @objc func tappedView(_ sender:UITapGestureRecognizer) {
        
        let point:CGPoint = sender.location(in: self.view)
        
        print("Single tap")
        
        print(point)
        if(endGame == false && startGame == true)
        {
            airplaneSprite.physicsBody?.affectedByGravity = false;
            airplaneSprite.run(moveUp)
            //airplaneSprite.run()
            airplaneSprite.physicsBody?.affectedByGravity = true;
        }
        
    }
    
    func handleTap(sender: UITapGestureRecognizer? = nil) {
        // handling code
    }
    
    func gameOver()
    {
        print("GAME OVER")
        airplaneSprite.isHidden = true
        
        gameOverLabel.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(gameOverLabel)
        airplaneSprite.physicsBody?.affectedByGravity = false;
        tapRec.isEnabled = false
        
        
        airplaneSprite.position = CGPoint(x: frame.midX, y: frame.midY)
        endGame = false
        startGame = false
        tapRec.isEnabled = true
        
        airplaneSprite.physicsBody?.velocity = CGVector(dx:0,dy:0)
        
    }
    
   
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch:UITouch = touches.first! //as! UITouch
        let positionInScene = touch.location(in: self)
        let touchedNode = self.atPoint(positionInScene)
        
        if let name = touchedNode.name
        {
            if (name == "Start Game" && startGame == false)
            {
                if(airplaneSprite.isHidden == true)
                {
                    airplaneSprite.physicsBody?.affectedByGravity = false
                    airplaneSprite.isHidden = false
                    gameOverLabel.removeFromParent()
                    airplaneSprite.position = CGPoint(x: frame.midX, y: frame.midY)
                }
                startGame = true
                print("Start Game Touched")
                //here is where i do start game code
                
                airplaneSprite.physicsBody?.affectedByGravity = true;
                
                do {
                    audioPlayer = try AVAudioPlayer(contentsOf: musicURL!)
                } catch {
                    print("error accessing music")
                }
                audioPlayer.volume = 0.25
                audioPlayer.numberOfLoops = -1 // loop forever
                audioPlayer.play() // In startGame()
                
            }
        }
    }
    
    /*
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    */
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        //if()
        //{
        if(self.endGame == false && self.startGame == true)
        {
            checkCollisions()
        }
        if(self.endGame == true)
        {
            gameOver()
        }
            
        //}
    }
}
