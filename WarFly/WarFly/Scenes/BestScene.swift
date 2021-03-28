//
//  BestScene.swift
//  WarFly
//
//  Created by Sergei Kast on 28.03.21.
//

import SpriteKit

class BestScene: ParentScene {
    
    var places = [100, 10, 1000]

    override func didMove(to view: SKView) {
        
        setHeader(with: "best", andBackground: "header_background")
        
        let titles = [ "back"]
        
        for (index, title) in titles.enumerated() {
            let button = ButtonNode(title: title, backgroundName: "button_background")
            button.position = CGPoint(x: self.frame.midX, y: self.frame.midY - 200 + CGFloat(100 * index))
            button.name = title
            button.label.name = title
            self.addChild(button)
        }
        
        let topPlaces = places.sorted { $0 < $1 }.prefix(3)
        for (index, place) in topPlaces.enumerated() {
            let label = SKLabelNode(text: place.description)
            label.fontColor = UIColor(red: 219 / 255, green: 226 / 225, blue: 215 / 255, alpha: 1.0)
            label.fontName = "AmericanTypewriter-Bold"
            label.fontSize = 30
            label.position = CGPoint(x: self.frame.midX, y: self.frame.midY - CGFloat(index * 60))
            self.addChild(label)
        }

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let location = touches.first!.location(in: self)
        let node = self.atPoint(location)
        
        if node.name == "back" {
            let transition = SKTransition.crossFade(withDuration: 1.0)
            guard let backScene = backScene else { return }
            backScene.scaleMode = .aspectFill
            self.view?.presentScene(backScene, transition: transition)
        }
    }
}
