//
//  GameScene.swift
//  GameSpriteKitExample
//
//  Created by Rainy Day on 6/9/15.
//  Copyright (c) 2015 Rainy Day. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    /* Setup your scene here */

    override func didMoveToView(view: SKView) {
        
    }
    
    /* Called when a touch begins */
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        let lbIntro = childNodeWithName("lbIntro")
        
        if (lbIntro != nil){
            //make the scene fade out to the next scene
            let fadeOut = SKAction.fadeInWithDuration(1.0)
            
            lbIntro?.runAction(fadeOut, completion: {
                let doors  = SKTransition.doorwayWithDuration(2.0)
                
                let shooterScene = ShooterScene_CCT_(fileNamed:  "ShooterScene")
                
                self.view?.presentScene(shooterScene, transition:doors)
            })
        }
    }
    
   /* Called before each frame is rendered */
    override func update(currentTime: CFTimeInterval) {
        
    }
}
