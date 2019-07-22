//
//  GameScene.swift
//  The Blob
//
//  Created by Eric Reese on 7/7/19.
//  Copyright © 2019 ReeseGames. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    private var blobNode: SKShapeNode?
    private var shapeArray: [SKShapeNode] = []
    
    private var shapesLevels: [Level] = []
    private var currentLevelArr: Int?
    
    private var currentShapeQuantity: Int?
    private var halfScreenSize: CGSize?
    
    private var shapeColors: [UIColor] = [UIColor.red, UIColor.blue, UIColor.black, UIColor.gray, UIColor.yellow, UIColor.green, UIColor.orange, UIColor.purple, UIColor.white]

    override func didMove(to view: SKView) {
        blobNode = SKShapeNode(ellipseIn: CGRect(x: 50, y: 50, width: 100, height: 100))
        blobNode?.fillColor = UIColor.blue
        blobNode?.strokeColor = UIColor.red
        self.addChild(blobNode!)
        
        for i in 1...100 {
            shapesLevels.append(Level(level: i))
        }
        
        currentLevelArr = 0
        currentShapeQuantity = 0
        
        halfScreenSize = CGSize(width: UIScreen.main.bounds.width / 2, height: UIScreen.main.bounds.height / 2)
        detectBlobShapeCollision()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first?.location(in: self) {
            blobNode?.position = CGPoint(x: touch.x - 50, y: touch.y - 50)
            detectBlobShapeCollision()
        }
        
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first?.location(in: self) {
            blobNode?.position = CGPoint(x: touch.x - 50, y: touch.y - 50)
            detectBlobShapeCollision()
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        if self.currentShapeQuantity! < shapesLevels[self.currentLevelArr!].shapeQuantityTotal! {
            let newShape = SKShapeNode(circleOfRadius: 10)
            newShape.fillColor = self.shapeColors[Int.random(in: 0..<self.shapeColors.count)]
            
            let x = CGFloat.random(in: -self.halfScreenSize!.width...self.halfScreenSize!.width)
            let y = CGFloat.random(in: -self.halfScreenSize!.height...self.halfScreenSize!.height)
            
            newShape.position = CGPoint(x: x, y: y)
            newShape.setScale(0.5)
            //newShape.fillColor = UIColor.black
            
            self.shapeArray.append(newShape)
            self.addChild(newShape)
            
            /*
             Replace the code below with an algorithm that
             will have the ability to detect how close the game
             is to the total quantity of shapes and calculates
             the size/quantity of the next shapes using the
             results
            */
            self.currentShapeQuantity! += 1
        }
    }
    
    func detectBlobShapeCollision() {
        
        var removeIndexes: [Int] = []
        var currentIndex = 0
        for shape in self.shapeArray {
            if self.blobNode!.intersects(shape) {
                removeIndexes.append(currentIndex)
                self.removeChildren(in: [shape])
                self.currentShapeQuantity! -= 1
            }
            
            currentIndex += 1
        }
        
        for index in removeIndexes.reversed() {
            self.shapeArray.remove(at: index)
        }
    }
}

//Holds information about the current level
class Level {
    
    var level: Int?
    var numberOfEnemies: Int?
    
    //Background
    var levelBackgroundColor: UIColor?
    
    //Amount of available points required on screen at any time
    var shapeQuantityTotal: Int?
    
    init(level: Int) {
        self.level = level
        runAll()
    }
    
    func numberOfEnemiesAlgorithm() {
        self.numberOfEnemies = self.level! * 10
    }
    
    func backgroundColorAlgorithm() {
        self.levelBackgroundColor = UIColor(hue: CGFloat(1 / level!), saturation: CGFloat(1 / level!), brightness: CGFloat(1 / level!), alpha: 1.0)
    }
    
    func shapeQuantityTotalAlgorithm() {
        self.shapeQuantityTotal = self.level! * 100
    }
    
    func runAll() {
        numberOfEnemiesAlgorithm()
        backgroundColorAlgorithm()
        shapeQuantityTotalAlgorithm()
    }
}


extension SKShapeNode {
    @IBInspectable var shapeQuantity: CGFloat {
        set {
            self.shapeQuantity = 0
        }
        
        get {
            return self.shapeQuantity
        }
    }
    
    /*
    func calculateShapeQuantity(interval: Interval) -> Int {
        let random = CGFloat.random(in: 0...1)
        
        //Different shapes will be made in the switch below
        switch interval {
        case .SMALL:
            return Int(random * 50)
        case .MEDIUM:
            return Int(random * 100)
        case .LARGE:
            return Int(random * 200)
        }
    }*/
}

/*
enum Interval {
    case SMALL
    case MEDIUM
    case LARGE
}*/

