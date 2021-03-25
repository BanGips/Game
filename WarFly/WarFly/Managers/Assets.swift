//
//  Assest.swift
//  WarFly
//
//  Created by Sergei Kast on 24.03.21.
//

import SpriteKit

class Assets {

    static let shared = Assets()
    var isLoaded = false
    
    let yellowShotAtlas = SKTextureAtlas(named: "YellowShot")
    let enemy_1Atlas = SKTextureAtlas(named: "Enemy_1")
    let enemy_2Atlas = SKTextureAtlas(named: "Enemy_2")
    let greenPowerUpAtlas = SKTextureAtlas(named: "GreenPowerUp")
    let bluePowerUpAtlas = SKTextureAtlas(named: "BluePowerUp")
    let playerPlaneAtlas = SKTextureAtlas(named: "PlayerPlane")
    
    func preloadAssest() {
        yellowShotAtlas.preload { print("YellowShot preload") }
        enemy_1Atlas.preload { print("Enemy_1 preload") }
        enemy_2Atlas.preload { print("Enemy_2 preload") }
        greenPowerUpAtlas.preload { print("GreenPowerUp preload") }
        bluePowerUpAtlas.preload { print("BluePowerUp preload") }
        playerPlaneAtlas.preload { print("PlayerPlane preload") }
    }
}
