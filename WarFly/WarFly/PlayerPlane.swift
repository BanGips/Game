//
//  PlayerPlane.swift
//  WarFly
//
//  Created by Sergei Kast on 21.03.21.
//

import SpriteKit
import CoreMotion

class PlayerPlane: SKSpriteNode {
    
    let motionManager = CMMotionManager()
    var xAcceleration: CGFloat = 0
    let screenSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    
    var leftTextureArrayAnimation = [SKTexture]()
    var rightTextureArrayAnimation = [SKTexture]()
    var forwardTextureArrayAnimation = [SKTexture]()
    var moveDirection: TurnDirection = .none
    var stillTurning = false
    let animationSpriteStrides = [(13, 1, -1), (13, 26, 1), (13, 13, 1)]
    

    static func populate(at point: CGPoint) -> PlayerPlane {
        let playerPlaneTexture = SKTexture(imageNamed: "airplane_3ver2_13")
        let playerPlane = PlayerPlane(texture: playerPlaneTexture)
        playerPlane.setScale(0.5)
        playerPlane.position = point
        playerPlane.zPosition = 40
        
        return playerPlane
    }
    
    func checkPosition() {
        self.position.x += xAcceleration * 10
        
        if self.position.x < -70 {
            self.position.x = screenSize.width + 70
        } else if self.position.x > screenSize.width + 70 {
            self.position.x = -70
        }
    }
    
    func performFly() {
        preloadTextureArrays()
        motionManager.accelerometerUpdateInterval = 0.2
        motionManager.startAccelerometerUpdates(to: OperationQueue.current!) { [unowned self ] (data, error) in
            if let data = data {
                let acceleration = data.acceleration
                self.xAcceleration = CGFloat(acceleration.x) * 0.7 + self.xAcceleration * 0.3
            }
        }
        
        let planeWaitAction = SKAction.wait(forDuration: 1.0)
        let planeDirectionCheckAction = SKAction.run {
            self.movementDirectionCheck()
        }
        
        let planeSequence = SKAction.sequence([ planeWaitAction, planeDirectionCheckAction ])
        let planeSequnceForever = SKAction.repeatForever(planeSequence)
        self.run(planeSequnceForever)
    }
    
    private func preloadArray(_stride: (Int, Int, Int), completion: @escaping (_ array: [SKTexture]) -> Void) {
        var array = [SKTexture]()
        
        for i in stride(from: _stride.0, through: _stride.1, by: _stride.2) {
            let number = String(format: "%02d", i)
            let texture = SKTexture(imageNamed: "airplane_3ver2_\(number)")
            array.append(texture)
        }
        
        SKTexture.preload(array) {
            completion(array)
        }
    }
    
    private func preloadTextureArrays() {
        for i in 0...2 {
            self.preloadArray(_stride: animationSpriteStrides[i]) { [unowned self] (array) in
                switch i {
                case 0: self.leftTextureArrayAnimation = array
                case 1: self.rightTextureArrayAnimation = array
                case 2: self.forwardTextureArrayAnimation = array
                default: break
                }
            }
        }
    }
    
    private func movementDirectionCheck() {
        
        if xAcceleration > 0.03, moveDirection != .right, stillTurning == false {
            stillTurning = true
            moveDirection = .right
            turnPlane(direction: moveDirection)
        } else if xAcceleration < -0.03, moveDirection != .left, stillTurning == false {
            stillTurning = true
            moveDirection = .left
            turnPlane(direction: moveDirection)
        } else if stillTurning == false {
            turnPlane(direction: .none)
        }
    }
    
    private func turnPlane(direction: TurnDirection) {
        var array = [SKTexture]()
        
        switch direction {
        case .left:
            array = leftTextureArrayAnimation
        case .right:
            array = rightTextureArrayAnimation
        case .none:
            array = forwardTextureArrayAnimation
        }
        
        let forwardAction = SKAction.animate(with: array, timePerFrame: 0.05, resize: true, restore: false)
        let backwardAction = SKAction.animate(with: array.reversed(), timePerFrame: 0.05, resize: true, restore: false)
        let sequenceAction = SKAction.sequence([ forwardAction, backwardAction ])
        self.run(sequenceAction) { [ unowned self ] in
            self.stillTurning = false
        }
    }
}

enum TurnDirection {
    case left
    case right
    case none
}
