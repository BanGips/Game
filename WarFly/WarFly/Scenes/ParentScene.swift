//
//  ParentScene.swift
//  WarFly
//
//  Created by Sergei Kast on 26.03.21.
//

import SpriteKit

class ParentScene: SKScene {
    
    let sceneManager = SceneManager.shared
    var backScene: SKScene?

    
    func setHeader(with name: String?, andBackground backgroundName: String) {
        let header = ButtonNode(title: name, backgroundName: backgroundName)
        header.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 150)
        self.addChild(header)
    }
}
