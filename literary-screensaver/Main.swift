import ScreenSaver

class Main: ScreenSaverView {
    
    var timer = Timer()
    var currentTime: String = ""
    
    /**
     startAnimation is called after the display has faded into the screen saver, and
     kicks off the timer which updates the current time every second.
     */
    override func startAnimation() {
        super.startAnimation()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateTime), userInfo: nil, repeats: true)
    }
    
    /**
     animateOneFrame is called every time the screen saver frame is to be updated, and
     is used to re-draw the time/quote if required.
     
     @TODO implement logic to determine if a re-draw is required.
     */
    override func animateOneFrame() {
        clearStage()
        drawTime()
    }
    
    /**
     updateTime updates the "currentTime" instance variable with the current time
     as a formatted string.
     */
    func updateTime() {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        
        currentTime = formatter.string(from: date)
    }
    
    /**
     drawTime draws the current time as a formatted string onto the screen saver
     stage.
     */
    func drawTime() {
        NSColor.black.set()
        currentTime.draw(at: NSPoint(x: 100.0, y: 200.0), withAttributes: nil)
    }
    
    /**
     clearStage clears the stage, by filling it with a solid colour.
     */
    func clearStage() {
        NSColor.red.setFill()
        NSRectFill(self.bounds)
    }
    
    /**
     draw is called to initialise the stage of the screen saver.
     */
    override func draw(_ rect: NSRect) {
        super.draw(rect)
        
        clearStage()
        drawTime()
    }
}
