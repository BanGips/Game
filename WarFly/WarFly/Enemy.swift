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
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
