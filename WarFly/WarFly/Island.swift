//
//  Island.swift
//  WarFly
//
//  Created by Sergei Kast on 21.03.21.
//

import SpriteKit
import GameplayKit

class Island: SKSpriteNode {
    static var randomScaleFactor: CGFloat {
        let distribution = GKRandomDistribution(lowestValue: 1, highestValue: 10)
        let randomNumber = CGFloat(distribution.nextInt()) / 10
        
        return randomNumber
    }
    
    static func popularIsland(at point: CGPoint) -> Island {
        let islandName = configIsLandName()
        let island = Island(imageNamed: islandName)
        island.setScale(randomScaleFactor)
        island.position = point
        island.zPosition = 1
        island.run(rotateForRandomAngle())
        
        return island
    }
    
    static func configIsLandName() -> String {
        let distribution = GKRandomDistribution(lowestValue: 1, highestValue: 4)
        let randomNumber = distribution.nextInt()
        let imageName = "is" + String(randomNumber)
        
        return imageName
    }
    
    static func rotateForRandomAngle() -> SKAction {
        let distribution = GKRandomDistribution(lowestValue: 1, highestValue: 360)
        let randomNumber = CGFloat(distribution.nextInt())
        
        return SKAction.rotate(toAngle: randomNumber * CGFloat(Double.pi / 180), duration: 0)
    }
}
