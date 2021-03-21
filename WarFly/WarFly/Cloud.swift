//
//  Cloud.swift
//  WarFly
//
//  Created by Sergei Kast on 21.03.21.
//

import SpriteKit
import GameplayKit

protocol GameBackgroundSpriteable{
    static func popularSprite(at point: CGPoint) -> Self
}

final class Cloud: SKSpriteNode, GameBackgroundSpriteable {
    
    static func popularSprite(at point: CGPoint) -> Cloud {
        let cloudName = configName()
        let cloud = Cloud(imageNamed: cloudName)
        cloud.setScale(randomScaleFactor)
        cloud.position = point
        cloud.zPosition = 10
        
        return cloud
    }
    
    private static var randomScaleFactor: CGFloat {
        let distribution = GKRandomDistribution(lowestValue: 10, highestValue: 20)
        let randomNumber = CGFloat(distribution.nextInt()) / 10
        
        return randomNumber
    }
    
    
    private static func configName() -> String {
        let distribution = GKRandomDistribution(lowestValue: 1, highestValue: 3)
        let randomNumber = distribution.nextInt()
        let imageName = "cl" + String(randomNumber)
        
        return imageName
    }
    
}

