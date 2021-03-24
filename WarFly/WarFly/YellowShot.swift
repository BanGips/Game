//
//  YellowShot.swift
//  WarFly
//
//  Created by Sergei Kast on 24.03.21.
//

import SpriteKit

class YellowShot: Shot {

    init() {
        let textureAtlas = SKTextureAtlas(named: "YellowShot")
        super.init(textureAtlas: textureAtlas)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
