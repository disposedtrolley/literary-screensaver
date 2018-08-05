//
//  SwiftSS.swift
//  literary-screensaver
//
//  Created by James Liu on 5/8/18.
//  Copyright © 2018 James Liu. All rights reserved.
//

import ScreenSaver

class SwiftSS: ScreenSaverView {
    
    var timer = Timer()
    var currentTime: String = ""
    
    override func startAnimation() {
        super.startAnimation()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateTime), userInfo: nil, repeats: true)
    }
    
    override func animateOneFrame() {
        clearStage()
        drawTime()
    }
    
    func updateTime() {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        
        currentTime = formatter.string(from: date)
    }
    
    func drawTime() {
        NSColor.black.set()
        currentTime.draw(at: NSPoint(x: 100.0, y: 200.0), withAttributes: nil)
    }
    
    func clearStage() {
        NSColor.red.setFill()
        NSRectFill(self.bounds)
    }
    
    override func draw(_ rect: NSRect) {
        super.draw(rect)
        
        clearStage()
        drawTime()
    }
}
