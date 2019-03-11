//
//  GameScene.swift
//  Rock the Boat
//
//  Created by Eric Reese on 12/22/18.
//  Copyright © 2018 ReeseGames. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    //General declarations
    public var screenSize: CGRect?
    public var boatNode: SKSpriteNode?
    
    //Texture arrays:
    private var boat_Character_Animation: [SKTexture] = []
    private var reverse_Boat_Character_Animation: [SKTexture] = []
    private var holding_Pole_Nervous: [SKTexture] = []
    private var reverse_holding_Pole_Nervous: [SKTexture] = []
    private var falling_To_Right: [SKTexture] = []
    
    //Action Keys
    private let actionKeys: [String] = ["Calm_Water", "Aggressive_Water", "Character_Death"]
    
    //Get string value
    func getAnimationNumber(i: Int, name: String) -> String {
        var value: String
        if (i < 10) {
            value = name + "000" + "\(i)"
        } else if (i < 100) {
            value = name + "00" + "\(i)"
        } else if (i < 1000) {
            value = name + "0" + "\(i)"
        } else {
            value = name + "\(i)"
        }
        
        return value
    }
    
    //Boat_Character_Animation
    func fillBoatCharacterAnimation() {
        let name = "Boat_Character_Animation"
        for i in 1...15 {
            boat_Character_Animation.append(SKTexture(imageNamed: getAnimationNumber(i: i, name: name)))
        }
        
        //Reverse_Boat_Character_Animation
        for i in stride(from: 15, to: 1, by: 1) {
            boat_Character_Animation.append(SKTexture(imageNamed: getAnimationNumber(i: i, name: name)))
        }
    }
    
    //Holding_Pole_Nervous
    func fillHoldingPoleNervous() {
        let name = "Holding_Pole_Nervous"
        for i in 1...15 {
            holding_Pole_Nervous.append(SKTexture(imageNamed: getAnimationNumber(i: i, name: name)))
        }
        
        //Reverse_Holding_Pole_Nervous
        for i in stride(from: 15, to: 1, by: 1) {
            reverse_holding_Pole_Nervous.append(SKTexture(imageNamed: getAnimationNumber(i: i, name: name)))
        }
    }
    
    //Falling_To_Right
    func fillFallingToRight() {
        let name = "Falling_To_Right"
        for i in 1...20 {
            falling_To_Right.append(SKTexture(imageNamed: getAnimationNumber(i: i, name: name)))
        }
    }
    
    //Fill all animations
    func fillImages() {
        fillBoatCharacterAnimation()
        fillHoldingPoleNervous()
        fillFallingToRight()
    }
    
    //Once moved to view, initialize frames
    override func didMove(to view: SKView) {
        
        //Initialize screen size
        screenSize = UIScreen.main.bounds
        
        fillImages()
        boatNode = SKSpriteNode(texture: boat_Character_Animation[0])
        boatNode!.size.width = boatNode!.size.width / 4
        boatNode!.size.height = boatNode!.size.height / 4
        
        boatNode!.run(SKAction.repeatForever(SKAction.animate(with: boat_Character_Animation, timePerFrame: 0.075, resize: false, restore: true)), withKey: actionKeys[0])
        
        self.addChild(boatNode!)
    }
    
    //Handling screen touch
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        boatNode!.run(SKAction.animate(with: falling_To_Right, timePerFrame: 0.050, resize: false, restore: true), withKey: actionKeys[2])
    }
}
