import Foundation
import ScreenSaver
//import CSV

class Main: ScreenSaverView {
    
    var latestTime: String = ""
    var quotes: [Quote] = []
    
    override init?(frame: NSRect, isPreview: Bool) {
        super.init(frame: frame, isPreview: isPreview)
        
        // Only update the frame every 5 seconds.
        animationTimeInterval = 5
        
        // Read in the quotes CSV.
//        self.quotes = readCSVToQuoteArray(filePath: "./litclock_annotated.csv")
    }
    
    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
    }
    
    /**
     Retrieves the quote associated with the provided time. If one does not exists,
     a default quote is returned.
     
     - Parameter time: The time to retrieve the quote for, as a string formatted in HH:mm
     
     - Returns: the Quote struct associated with the given time, or a default one if
                a quote does not exist.
     */
    func getQuoteFor(time: String) -> Quote {
        let quotesForTime = self.quotes.filter { $0.time == time }
        
        if quotesForTime.count > 0 {
            return quotesForTime[0]
        } else {
            return Quote(time: "00:00",
                         subquote: "Default Quote",
                         quote: "This is the Default Quote",
                         title: "Default Title",
                         author: "Default Author")
        }
    }
    
    /**
     Reads a CSV file at a specified file path into an array of Quote structs.
     
     - Parameter filePath: The path of the CSV file to read.
     
     - Returns: an array of Quote structs
     */
//    func readCSVToQuoteArray(filePath: String) -> [Quote]! {
//        var items: [Quote] = []
//
//        let stream = InputStream(fileAtPath: filePath)!
//        let csv = try! CSVReader(stream: stream, delimiter: "|")
//
//        while let row = csv.next() {
//            items.append(Quote(time: row[0], subquote: row[1], quote: row[2], title: row[3], author: row[4]))
//        }
//
//        return items
//    }
    
    /**
     animateOneFrame is called every time the screen saver frame is to be updated, and
     is used to re-draw the time/quote if required.
     */
    override func animateOneFrame() {
        let time = getTime()
        
//        let quote = getQuoteFor(time: time)
        
        if time != self.latestTime {
            clearStage()
            drawText(time)
        } else {
            self.latestTime = time
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
     drawText draws a provided string to the bottom-left of the stage.
     
     - Parameter text: The text to draw onto the stage.
     */
    func drawText(_ text: String) {
        NSColor.black.set()
        text.draw(at: NSPoint(x: 100.0, y: 200.0), withAttributes: nil)
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
        drawText(time)
    }
}
