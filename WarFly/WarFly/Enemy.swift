//
//  Enemy.swift
//  WarFly
//
//  Created by Sergei Kast on 23.03.21.
//

import SpriteKit

class Enemy: SKSpriteNode {

    static var textureAtlast: SKTextureAtlas?
    
    init() {
        let texture = Enemy.textureAtlast?.textureNamed("airplane_4ver2_13")
        super.init(texture: texture, color: .clear, size: CGSize(width: 221, height: 204))
        self.xScale = 0.5
        self.yScale = -0.5
        self.zPosition = 20
        self.name = "sprite"
    }
    
    func flySpiral() {
        let screenSize = UIScreen.main.bounds
        
        let time: Double = 3
        let timeVertical: Double = 10
        let moveLeft = SKAction.moveTo(x: 50, duration: time)
        let moveRight = SKAction.moveTo(x: screenSize.width - 50, duration: time)
        moveLeft.timingMode = .easeInEaseOut
        moveRight.timingMode = .easeInEaseOut
        let asideMovementSequence = SKAction.sequence([moveLeft, moveRight])
        let foreverAsideMovement = SKAction.repeatForever(asideMovementSequence)
        
        let forwardMovement = SKAction.moveTo(y: -105, duration: timeVertical)
        
        let groupMovement = SKAction.group([foreverAsideMovement, forwardMovement])
        self.run(groupMovement)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
