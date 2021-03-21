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
    var player: SKSpriteNode!
    
    let motionManager = CMMotionManager()
    var xAcceleration: CGFloat = 0
    
    override func didMove(to view: SKView) {

        configStartScene()
        spawnClouds()
        spawnIsland()
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
        
        motionManager.accelerometerUpdateInterval = 0.2
        motionManager.startAccelerometerUpdates(to: OperationQueue.current!) { (data, error) in
            if let data = data {
                let acceleration = data.acceleration
                self.xAcceleration = CGFloat(acceleration.x) * 0.7 + self.xAcceleration * 0.3
            }
        }
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
        
        player.position.x += xAcceleration * 50
        
        if player.position.x < -70 {
            player.position.x = self.size.width + 70
        } else if player.position.x > self.size.width + 70 {
            player.position.x = -70
        }
    }
}
