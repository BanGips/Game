//
//  Background.swift
//  WarFly
//
//  Created by Sergei Kast on 20.03.21.
//

import SpriteKit

class Background: SKSpriteNode {

    static func populateBackground(at point: CGPoint) -> SKSpriteNode {
        let background = SKSpriteNode(imageNamed: "background")
        background.position = point
        background.zPosition = 0
        
        return background
    }
    
}
