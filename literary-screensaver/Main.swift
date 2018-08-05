import ScreenSaver

class Main: ScreenSaverView {
    
    var latestTime: String = ""
    
    override init?(frame: NSRect, isPreview: Bool) {
        super.init(frame: frame, isPreview: isPreview)
    }
    
    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
    }
    
    /**
     animateOneFrame is called every time the screen saver frame is to be updated, and
     is used to re-draw the time/quote if required.
     */
    override func animateOneFrame() {
        let time = getTime()
        
        if time != latestTime {
            clearStage()
            drawTime(time)
        } else {
            latestTime = time
        }
    }
    
    /**
     getTime returns the current time as a formatted string.
     
     - Returns: A new string showing the current time, formatted as HH:mm
     */
    func getTime() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        
        return formatter.string(from: date)
    }
    
    /**
     drawTime draws the current time as a formatted string onto the screen saver
     stage.
     
     - Parameter time: The current time formatted as HH:mm
     */
    func drawTime(_ time: String) {
        let time = getTime()
        NSColor.black.set()
        time.draw(at: NSPoint(x: 100.0, y: 200.0), withAttributes: nil)
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
        
        let time = getTime()
        
        clearStage()
        drawTime(time)
    }
}
