//
//  ShooterScene(CCT).swift
//  GameSpriteKitExample
//
//  Created by Rainy Day on 6/9/15.
//  Copyright (c) 2015 Rainy Day. All rights reserved.
//

import UIKit
import SpriteKit

class ShooterScene_CCT_: SKScene {
    
    var score = 0
    var enemyCount = 10;
    //list of images
    var shooterAnimation = [SKTexture]()
    //view Load
    override func didMoveToView(view: SKView) {
        self.physicsWorld.gravity = CGVectorMake(0, -1.2)
        self.initShooterScene()
    }
    //set up level
    func initShooterScene(){
        let shooterAtlas = SKTextureAtlas(named : "character")
        
        for index in 1...shooterAtlas.textureNames.count {
            let imgName = String(format: "ezreal%01d", index)
            shooterAnimation += [shooterAtlas.textureNamed(imgName)]
        }
        //drop Teemo from top in every ... secs
        let dropTeemos = SKAction.sequence([SKAction.runBlock({
            self.createTeemo()}),
            SKAction.waitForDuration(2.0)])
        self.runAction(SKAction.repeatAction(dropTeemos, count: enemyCount), completion : nil)
    
    }
    //play the animation/ Animate the shooter
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        let shooterNode = self.childNodeWithName("ezrealShooter")
        
        if( shooterNode != nil){
            //create action
            let animation = SKAction.animateWithTextures(shooterAnimation, timePerFrame: 0.1)
            //shooting the bullet
            let shootBullet = SKAction.runBlock({
                let bulletNode = self.createBulletNode()
                self.addChild(bulletNode)
                //make bullet move
                bulletNode.physicsBody?.applyImpulse(CGVectorMake(40.0, 0))
            })
            //apply action
            let sequence = SKAction.sequence ( [animation, shootBullet ] )
            //shooterNode?.runAction(animation)
            shooterNode?.runAction(sequence)
        }
    }
    
    //create bullet node
    func createBulletNode() -> SKSpriteNode {
        let shooterNode = self.childNodeWithName("ezrealShooter")
        let shooterPosition = shooterNode?.position
        let shooterWidth = shooterNode?.frame.size.width
        //set up the bullet
        let bullet  = SKSpriteNode(imageNamed: "kamehameha.png")
        bullet.position = CGPointMake(shooterPosition!.x + shooterWidth!/2, shooterPosition!.y)
        bullet.name = "bulletNode"
        bullet.physicsBody = SKPhysicsBody(rectangleOfSize: bullet.frame.size)
        bullet.physicsBody?.usesPreciseCollisionDetection = true
        
        return bullet
    }
    
    //create Teemo !!!!!!!
    func createTeemo(){
        let teemo = SKSpriteNode(imageNamed: "teemo.png")
        teemo.position = CGPointMake(randomNumber(self.size.width), self.size.height)
        teemo.name  = "teemoNode"
        teemo.physicsBody = SKPhysicsBody(circleOfRadius: teemo.size.width/2)
        teemo.physicsBody?.usesPreciseCollisionDetection = true
        self.addChild(teemo)
    }
    //random method between 0 and width
    func randomNumber(maximum: CGFloat) -> CGFloat {
        let maxInt = UInt32(maximum)
        let result  = arc4random_uniform(maxInt)
        return CGFloat(result)
    }
    
}
