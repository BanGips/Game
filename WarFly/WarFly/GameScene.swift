//
//  GameScene.swift
//  WarFly
//
//  Created by Sergei Kast on 20.03.21.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    override func didMove(to view: SKView) {

        let centerPoint = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        let background = Background.populateBackground(at: centerPoint)
        self.addChild(background)
      
    }
}
