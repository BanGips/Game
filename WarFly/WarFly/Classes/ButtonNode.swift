//
//  ButtonNode.swift
//  WarFly
//
//  Created by Sergei Kast on 25.03.21.
//

import SpriteKit

class ButtonNode: SKSpriteNode {

    let label: SKLabelNode = {
       let label = SKLabelNode(text: "")
        label.fontColor = UIColor(red: 219 / 255, green: 226 / 225, blue: 215 / 255, alpha: 1.0)
        label.fontName = "AmericanTypewriter-Bold"
        label.fontSize = 30
        label.horizontalAlignmentMode = .center
        label.verticalAlignmentMode = .center
        label.zPosition = 2
        return label
    }()
    
    init(title: String?, backgroundName: String) {
        let texture = SKTexture(imageNamed: backgroundName)
        super.init(texture: texture, color: .clear , size: texture.size())
        if let title = title {
            label.text = title.uppercased()
        }
        self.addChild(label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
