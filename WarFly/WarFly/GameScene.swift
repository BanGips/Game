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
        
        let screen = UIScreen.main.bounds
        for _ in 1...5 {
            let x = CGFloat(GKRandomSource.sharedRandom().nextInt(upperBound: Int(screen.size.width)))
            let y = CGFloat(GKRandomSource.sharedRandom().nextInt(upperBound: Int(screen.size.height)))
            
            let island = Island.popularIsland(at: CGPoint(x: x, y: y))
            self.addChild(island)
        }
      
    }
}
