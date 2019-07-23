//
//  GameScene.swift
//  The Blob
//
//  Created by Eric Reese on 7/7/19.
//  Copyright © 2019 ReeseGames. All rights reserved.
//

import SpriteKit
import GameplayKit

enum ShapeTypes {
    case CIRCLE
    case RECTANGLE
    case SQUARE
    case ELLIPSE
}

class GameScene: SKScene {
    
    private var blobNode: SKShapeNode?
    private var shapeArray: [SKShapeNode] = []
    
    private var shapesLevels: [Level] = []
    private var currentLevelArr: Int?
    
    private var currentShapeQuantity: CGFloat?
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
            let quantity = CGFloat.random(in: 1..<2.5)
            let newShape = createRandomShape(quantity: quantity)
            
            self.shapeArray.append(newShape)
            self.addChild(newShape)
            
            self.currentShapeQuantity! += quantity
            newShape.shapeQuantity = quantity
        }
    }
    
    func createRandomShape(quantity: CGFloat) -> (SKShapeNode) {
        let randomShape = Int.random(in: 0..<4)
        var newShape: SKShapeNode?
        
        var modifiableQuantity = quantity
        
        let randomSizeDistribution = CGFloat.random(in: 0..<1)
        switch (randomShape) {
        case 0:
            newShape = SKShapeNode(circleOfRadius: 10)
        case 1:
            let ellipseSize = CGSize(width: 30 * (1 - randomSizeDistribution), height: 30 * randomSizeDistribution)
            newShape = SKShapeNode(ellipseOf: ellipseSize)
        case 2:
            let rectangleSize = CGSize(width: 30 * randomSizeDistribution, height: 30 * (1 - randomSizeDistribution))
            newShape = SKShapeNode(rectOf: rectangleSize)
        case 3:
            newShape = SKShapeNode(rectOf: CGSize(width: 20, height: 20))
        default:
            print("Something went wrong")
        }
        
        newShape!.fillColor = self.shapeColors[Int.random(in: 0..<self.shapeColors.count)]
        
        var shapePos = CGPoint(x: CGFloat.random(in: -self.halfScreenSize!.width...self.halfScreenSize!.width), y: CGFloat.random(in: -self.halfScreenSize!.height...self.halfScreenSize!.height))
        
        newShape!.position = shapePos
        newShape!.setScale(modifiableQuantity)
        
        while (blobNode!.intersects(newShape!)) {
            shapePos = CGPoint(x: CGFloat.random(in: -self.halfScreenSize!.width...self.halfScreenSize!.width), y: CGFloat.random(in: -self.halfScreenSize!.height...self.halfScreenSize!.height))
            
            modifiableQuantity = CGFloat.random(in: 1..<2.5)
            newShape!.position = shapePos
            newShape!.setScale(modifiableQuantity)
        }
        
        return newShape!
    }
    
    func detectBlobShapeCollision() {
        
        var removeIndexes: [Int] = []
        var currentIndex = 0
        for shape in self.shapeArray {
            if self.blobNode!.intersects(shape) {
                removeIndexes.append(currentIndex)
                self.removeChildren(in: [shape])

                self.currentShapeQuantity! -= shape.shapeQuantity
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
    var shapeQuantityTotal: CGFloat?
    
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
        self.shapeQuantityTotal = CGFloat(self.level!) * 100
    }
    
    func runAll() {
        numberOfEnemiesAlgorithm()
        backgroundColorAlgorithm()
        shapeQuantityTotalAlgorithm()
    }
}


extension SKShapeNode {
    struct Holder {
        static var shapeQuantity: CGFloat = 0.0
    }
    
    var shapeQuantity: CGFloat {
        get {
            return Holder.shapeQuantity
        }
        set(newValue) {
            Holder.shapeQuantity = newValue
        }
    }
}

