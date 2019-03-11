//
//  GameScene.swift
//  CrazyGraphics
//
//  Created by Eric Reese on 3/8/19.
//  Copyright © 2019 ReeseGames. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    private var scoreNode: SKLabelNode?
    
    private var spinnyNode : SKShapeNode?
    private var circleSpinnyNode: SKShapeNode?
    private var sideSpinnyNode: SKShapeNode?
    private var middleCircleSpinnyNode: SKShapeNode?
    
    private var nodesProducedCount: Int?
    private var w: CGFloat?
    
    override func didMove(to view: SKView) {
        
        // Create shape node to use during mouse interaction
        w = (self.size.width + self.size.height) * 0.05
        self.spinnyNode = SKShapeNode.init(rectOf: CGSize.init(width: w!, height: w!), cornerRadius: w! * 0.3)
        self.circleSpinnyNode = SKShapeNode.init(rectOf: CGSize.init(width: w!/2, height: w!/2), cornerRadius: w! * 0.75)
        self.sideSpinnyNode = SKShapeNode.init(ellipseOf: CGSize.init(width: w!/3, height: w!/3))
        self.middleCircleSpinnyNode = SKShapeNode.init(ellipseOf: CGSize.init(width: w!/5, height: w!/5))
        self.scoreNode = self.childNode(withName: "scoreLabel") as? SKLabelNode
        nodesProducedCount = 0
        
        
        if let spinnyNode = self.spinnyNode {
            spinnyNode.lineWidth = 2.5
            
            spinnyNode.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 1)))
            spinnyNode.run(SKAction.sequence([SKAction.run({ self.scoreNode?.text = "Score: " + "\(self.nodesProducedCount!)" }), SKAction.wait(forDuration: 0.5),
                                              SKAction.fadeOut(withDuration: 0.5),
                                              SKAction.removeFromParent()]))
        }
        
        if let squareSpinnyNode = self.circleSpinnyNode {
            squareSpinnyNode.lineWidth = 5.0
            
            squareSpinnyNode.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 0.5)))
            squareSpinnyNode.run(SKAction.sequence([SKAction.run({ self.scoreNode?.text = "Score: " + "\(self.nodesProducedCount!)" }), SKAction.wait(forDuration: 0.5),
                                                    SKAction.fadeOut(withDuration: 0.5),
                                                    SKAction.removeFromParent()]))
        }
        
        if let sideSpinnyNode = self.sideSpinnyNode {
            sideSpinnyNode.lineWidth = 5.0
            
            sideSpinnyNode.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 0.5)))
            sideSpinnyNode.run(SKAction.sequence([SKAction.run({ self.scoreNode?.text = "Score: " + "\(self.nodesProducedCount!)" }), SKAction.wait(forDuration: 0.5),
                                                    SKAction.fadeOut(withDuration: 0.5),
                                                    SKAction.removeFromParent()]))
        }
        
        if let middleCircleSpinnyNode = self.middleCircleSpinnyNode {
            middleCircleSpinnyNode.lineWidth = 5.0
            middleCircleSpinnyNode.run(SKAction.sequence([SKAction.run({ self.scoreNode?.text = "Score: " + "\(self.nodesProducedCount!)" }), SKAction.wait(forDuration: 0.5),
                                                  SKAction.fadeOut(withDuration: 0.5),
                                                  SKAction.removeFromParent()]))
        }
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        nodesProducedCount! += 1
        
        if (nodesProducedCount! < 1500) {
            if let n = self.spinnyNode?.copy() as! SKShapeNode? {
                n.position = pos
                n.strokeColor = SKColor.green
                self.addChild(n)
            }
        }
        
        if (nodesProducedCount! < 1000) {
            if let n = self.circleSpinnyNode?.copy() as! SKShapeNode? {
                n.position = pos
                n.strokeColor = SKColor.blue
                
                self.addChild(n)
            }
        }
        
        //Side Spinny Node
        if (nodesProducedCount! > 500 && nodesProducedCount! < 1650) {
            if let n = self.sideSpinnyNode?.copy() as! SKShapeNode? {
                n.position = CGPoint(x: pos.x - w!/2, y: pos.y - w!/2)
                n.strokeColor = SKColor.cyan
                
                self.addChild(n)
            }
        
            if let n = self.sideSpinnyNode?.copy() as! SKShapeNode? {
                n.position = CGPoint(x: pos.x - w!/2, y: pos.y + w!/2)
                n.strokeColor = SKColor.cyan
                
                self.addChild(n)
            }
        
            if let n = self.sideSpinnyNode?.copy() as! SKShapeNode? {
                n.position = CGPoint(x: pos.x + w!/2, y: pos.y - w!/2)
                n.strokeColor = SKColor.cyan
                
                self.addChild(n)
            }
        
            if let n = self.sideSpinnyNode?.copy() as! SKShapeNode? {
                n.position = CGPoint(x: pos.x + w!/2, y: pos.y + w!/2)
                n.strokeColor = SKColor.cyan
                
                self.addChild(n)
            }
        }
        
        //MiddleSpinnyNode
        if (nodesProducedCount! > 1250) {
            if let n = self.middleCircleSpinnyNode?.copy() as! SKShapeNode? {
                n.position = CGPoint(x: pos.x - w!/3, y: pos.y - w!/3)
                n.strokeColor = SKColor.orange
                
                self.addChild(n)
            }
            
            if let n = self.middleCircleSpinnyNode?.copy() as! SKShapeNode? {
                n.position = CGPoint(x: pos.x - w!/3, y: pos.y + w!/3)
                n.strokeColor = SKColor.orange
                
                self.addChild(n)
            }
            
            if let n = self.middleCircleSpinnyNode?.copy() as! SKShapeNode? {
                n.position = CGPoint(x: pos.x + w!/3, y: pos.y - w!/3)
                n.strokeColor = SKColor.orange
                
                self.addChild(n)
            }
            
            if let n = self.middleCircleSpinnyNode?.copy() as! SKShapeNode? {
                n.position = CGPoint(x: pos.x + w!/3, y: pos.y + w!/3)
                n.strokeColor = SKColor.orange
                
                self.addChild(n)
            }
        }
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        nodesProducedCount! += 1
        
        if (nodesProducedCount! < 1500) {
            if let n = self.spinnyNode?.copy() as! SKShapeNode? {
                n.position = pos
                n.strokeColor = SKColor.blue
                self.addChild(n)
            }
        }
        
        if (nodesProducedCount! < 1000) {
            if let n = self.circleSpinnyNode?.copy() as! SKShapeNode? {
                n.position = pos
                n.strokeColor = SKColor.red
                
                self.addChild(n)
            }
        }
        
        //Side Spinny Node
        if (nodesProducedCount! > 500 && nodesProducedCount! < 1650) {
            if let n = self.sideSpinnyNode?.copy() as! SKShapeNode? {
                n.position = CGPoint(x: pos.x - w!/2, y: pos.y - w!/2)
                n.strokeColor = SKColor.green
                
                self.addChild(n)
            }
        
            if let n = self.sideSpinnyNode?.copy() as! SKShapeNode? {
                n.position = CGPoint(x: pos.x - w!/2, y: pos.y + w!/2)
                n.strokeColor = SKColor.green
                
                self.addChild(n)
            }
        
            if let n = self.sideSpinnyNode?.copy() as! SKShapeNode? {
                n.position = CGPoint(x: pos.x + w!/2, y: pos.y - w!/2)
                n.strokeColor = SKColor.green
                
                self.addChild(n)
            }
        
            if let n = self.sideSpinnyNode?.copy() as! SKShapeNode? {
                n.position = CGPoint(x: pos.x + w!/2, y: pos.y + w!/2)
                n.strokeColor = SKColor.green
                
                self.addChild(n)
            }
        }
        
        //Middle Spinny Node
        if (nodesProducedCount! > 1250) {
            if let n = self.middleCircleSpinnyNode?.copy() as! SKShapeNode? {
                n.position = CGPoint(x: pos.x - w!/3, y: pos.y - w!/3)
                n.strokeColor = SKColor.lightGray
                
                self.addChild(n)
            }
            
            if let n = self.middleCircleSpinnyNode?.copy() as! SKShapeNode? {
                n.position = CGPoint(x: pos.x - w!/3, y: pos.y + w!/3)
                n.strokeColor = SKColor.lightGray
                
                self.addChild(n)
            }
            
            if let n = self.middleCircleSpinnyNode?.copy() as! SKShapeNode? {
                n.position = CGPoint(x: pos.x + w!/3, y: pos.y - w!/3)
                n.strokeColor = SKColor.lightGray
                
                self.addChild(n)
            }
            
            if let n = self.middleCircleSpinnyNode?.copy() as! SKShapeNode? {
                n.position = CGPoint(x: pos.x + w!/3, y: pos.y + w!/3)
                n.strokeColor = SKColor.lightGray
                
                self.addChild(n)
            }
        }
    }
    
    func touchUp(atPoint pos : CGPoint) {
        if (nodesProducedCount! < 1500) {
            if let n = self.spinnyNode?.copy() as! SKShapeNode? {
                n.position = pos
                n.strokeColor = SKColor.green
                self.addChild(n)
            }
        }
        
        if (nodesProducedCount! < 1000) {
            if let n = self.circleSpinnyNode?.copy() as! SKShapeNode? {
                n.position = pos
                n.strokeColor = SKColor.red
                self.addChild(n)
            }
        }
        
        //Side Spinny Node
        if (nodesProducedCount! > 500 && nodesProducedCount! < 1650) {
            if let n = self.sideSpinnyNode?.copy() as! SKShapeNode? {
                n.position = CGPoint(x: pos.x - w!/2, y: pos.y - w!/2)
                n.strokeColor = SKColor.blue
                self.addChild(n)
            }
        
            if let n = self.sideSpinnyNode?.copy() as! SKShapeNode? {
                n.position = CGPoint(x: pos.x + w!/2, y: pos.y - w!/2)
                n.strokeColor = SKColor.blue
                self.addChild(n)
            }
        
            if let n = self.sideSpinnyNode?.copy() as! SKShapeNode? {
                n.position = CGPoint(x: pos.x - w!/2, y: pos.y + w!/2)
                n.strokeColor = SKColor.blue
                self.addChild(n)
            }
        
            if let n = self.sideSpinnyNode?.copy() as! SKShapeNode? {
                n.position = CGPoint(x: pos.x + w!/2, y: pos.y + w!/2)
                n.strokeColor = SKColor.blue
                self.addChild(n)
            }
        }
        
        //Middle Spinny Node
        if (nodesProducedCount! > 1250) {
            if let n = self.middleCircleSpinnyNode?.copy() as! SKShapeNode? {
                n.position = CGPoint(x: pos.x - w!/3, y: pos.y - w!/3)
                n.strokeColor = SKColor.black
                self.addChild(n)
            }
            
            if let n = self.middleCircleSpinnyNode?.copy() as! SKShapeNode? {
                n.position = CGPoint(x: pos.x + w!/3, y: pos.y - w!/3)
                n.strokeColor = SKColor.black
                self.addChild(n)
            }
            
            if let n = self.middleCircleSpinnyNode?.copy() as! SKShapeNode? {
                n.position = CGPoint(x: pos.x - w!/3, y: pos.y + w!/3)
                n.strokeColor = SKColor.black
                self.addChild(n)
            }
            
            if let n = self.middleCircleSpinnyNode?.copy() as! SKShapeNode? {
                n.position = CGPoint(x: pos.x + w!/3, y: pos.y + w!/3)
                n.strokeColor = SKColor.black
                self.addChild(n)
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        nodesProducedCount! = 0
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
