//
//  GameScene.swift
//  WarFly
//
//  Created by Sergei Kast on 20.03.21.
//

import SpriteKit
import GameplayKit
import CoreMotion

class GameScene: SKScene {
    
    let screen = UIScreen.main.bounds
    var player: PlayerPlane!
    
    override func didMove(to view: SKView) {

        configStartScene()
        spawnClouds()
        spawnIsland()
        player.performFly()
        spawnPowerUp()
        spanwEnemies()
        
    }
    
    private func spawnSpiralOfEnemies() {
        let enemyTextureAtlas = SKTextureAtlas(named: "Enemy_1")
        let enemyTextureAtlas2 = SKTextureAtlas(named: "Enemy_2")
        SKTextureAtlas.preloadTextureAtlases([enemyTextureAtlas, enemyTextureAtlas2]) { [ unowned self] in
            
            let arrayOfAtlases = [enemyTextureAtlas, enemyTextureAtlas2]
            let textureAtlas = arrayOfAtlases.randomElement()
            
            let waitAction = SKAction.wait(forDuration: 1.0)
            let spawnEnemy = SKAction.run {
                let textureNames = textureAtlas?.textureNames.sorted()
                let textureName = textureNames![12]
                let texture = textureAtlas?.textureNamed(textureName)
                let enemy = Enemy(enemyTexture: texture!)
                enemy.position = CGPoint(x: self.size.width / 2, y: self.size.height + 110)
                self.addChild(enemy)
                enemy.flySpiral()
            }
            
            let spawnAction = SKAction.sequence([waitAction, spawnEnemy])
            self.run(spawnAction)
        }
    }
    
    private func spanwEnemies() {
        let waitAction = SKAction.wait(forDuration: 1.0)
        let spawnSpiralAction = SKAction.run { [unowned self] in
            self.spawnSpiralOfEnemies()
        }
        
        self.run(SKAction.repeatForever(SKAction.sequence([waitAction, spawnSpiralAction])))
    }
    
    private func spawnPowerUp() {
        let powerUp = GreenPowerUp()
        powerUp.performRotation()
        powerUp.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        self.addChild(powerUp)
    }
    
    private func configStartScene() {
        let centerPoint = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        let background = Background.populateBackground(at: centerPoint)
        self.addChild(background)
        
        let island = Island.populate()
        self.addChild(island)
        
        let cloud = Cloud.populate()
        self.addChild(cloud)
        
        player = PlayerPlane.populate(at: CGPoint(x: screen.size.width / 2, y: 100))
        self.addChild(player)
        
    }
    
    private func spawnClouds() {
        let spawnCloudWait = SKAction.wait(forDuration: 1)
        let spawnCloudAction = SKAction.run {
            let cloud = Cloud.populate()
            self.addChild(cloud)
        }


        let spawnCloudSequence = SKAction.sequence([ spawnCloudWait, spawnCloudAction])
        let spawnCloudForever = SKAction.repeatForever(spawnCloudSequence)
        self.run(spawnCloudForever)
       
    }
    
    private func spawnIsland() {
        let spawnIslandWait = SKAction.wait(forDuration: 2)
        let spawnIslandAction = SKAction.run {
            let island = Island.populate()
            self.addChild(island)
        }
        
        let spawnIslandSequence = SKAction.sequence([ spawnIslandWait, spawnIslandAction])
        let spawnIslandForever = SKAction.repeatForever(spawnIslandSequence)
        self.run(spawnIslandForever)
    }
    
    override func didSimulatePhysics() {
        super.didSimulatePhysics()
        
        player.checkPosition()
        
        enumerateChildNodes(withName: "sprite") { (node, _) in
            if node.position.y < -100 {
                node.removeFromParent()
            }
        }
    }
}
