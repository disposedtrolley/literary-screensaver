import Foundation
import ScreenSaver

class Main: ScreenSaverView {
    
    var latestTime: String = ""
    var quotes: [Quote] = []
    
    let THEME_MODE = "DARK"
    
    let COLOUR = [
        "LIGHT": [
            "BACKGROUND": NSColor(red:1.00,green:0.97,blue:0.89,alpha:1.00),
            "QUOTE": NSColor(red:0.58,green:0.59,blue:0.62,alpha:1.00),
            "TIME": NSColor(red:1.00,green:0.55,blue:0.65,alpha:1.00),
            "METADATA": NSColor(red:0.31,green:0.31,blue:0.33,alpha:1.00)
        ],
        "DARK": [
            "BACKGROUND": NSColor(red:0.31,green:0.31,blue:0.33,alpha:1.00),
            "QUOTE": NSColor(red:0.94,green:0.95,blue:0.94,alpha:1.00),
            "TIME": NSColor(red:1.00,green:0.55,blue:0.65,alpha:1.00),
            "METADATA": NSColor(red:1.00,green:1.00,blue:1.00,alpha:1.00)
        ]
    ]
    
    let FONT_QUOTE = NSFont(name: "Baskerville", size: 48)
    let FONT_METADATA = NSFont(name: "Baskerville-BoldItalic", size: 24)
    
    override init?(frame: NSRect, isPreview: Bool) {
        super.init(frame: frame, isPreview: isPreview)
        
        // Only update the frame every 5 seconds.
        animationTimeInterval = 5
        
        // Read in the quotes CSV.
        self.quotes = readCSVToQuoteArray(fileName: "litclock_annotated")
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
            return self.quotes[0]
        }
    }
    
    /**
     Reads a CSV file at a specified file path into an array of Quote structs.
     
     - Parameter fileName: The name of the CSV file to read.
     
     - Returns: an array of Quote structs
     */
    func readCSVToQuoteArray(fileName: String) -> [Quote]! {
        let path = Bundle(for: type(of: self)).path(forResource: fileName, ofType: "csv")
        let contents = try? String(contentsOfFile: path!, encoding: .utf8)
        
        // Parse the CSV file into a 2D array, separating the rows by the newline character, and each
        // column by the pipe symbol.
        let parsedCSV: [[String]] = contents!.components(separatedBy: "\n").map{ $0.components(separatedBy: "|") }
        
        // Map each record to a new instance of Quote struct, returning the resulting array.
        return parsedCSV.map {Quote(time: $0[0], subquote: $0[1], quote: $0[2], title: $0[3], author: $0[4])}
    }
    
    /**
     animateOneFrame is called every time the screen saver frame is to be updated, and
     is used to re-draw the time/quote if required.
     */
    override func animateOneFrame() {
        let time = getTime()
        
        let quote = getQuoteFor(time: time)
        
        if time != self.latestTime {
            clearStage()
            drawQuote(quote.quote, subquote: quote.subquote)
            drawMetadata(title: quote.title, author: quote.author)
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
     drawQuote draws the provided quote to the stage.
     
     - Parameter quote: The quote to draw onto the stage.
     - Parameter subquote: The subquote to highlight.
     */
    func drawQuote(_ quote: String, subquote: String) {
        let timeRange = (quote as NSString).range(of: subquote)
        
        let styledQuote = NSMutableAttributedString(string: quote)
        styledQuote.addAttribute(NSForegroundColorAttributeName, value: COLOUR[self.THEME_MODE]!["QUOTE"]!, range: NSMakeRange(0, styledQuote.length))
        styledQuote.addAttribute(NSForegroundColorAttributeName, value: COLOUR[self.THEME_MODE]!["TIME"]!, range: timeRange)
        styledQuote.addAttribute(NSFontAttributeName, value: FONT_QUOTE, range: NSMakeRange(0, quote.count))
        
        let QUOTE_PADDING_LEFT = 100;
        let QUOTE_PADDING_RIGHT = 100;
        let QUOTE_PADDING_TOP = 100;
        
        // Where frame.size is the resolution of the current screen (works for multi-monitor display)
        let QUOTE_BOX_WIDTH = Int(frame.size.width) - (QUOTE_PADDING_LEFT + QUOTE_PADDING_RIGHT);
        let QUOTE_BOX_HEIGHT = Int(frame.size.height) - QUOTE_PADDING_TOP;
        
        styledQuote.draw(in: CGRect(x: QUOTE_PADDING_LEFT, y: 0, width: QUOTE_BOX_WIDTH, height: QUOTE_BOX_HEIGHT))
    }
    
    /**
     drawMetadata draws the provided title and author onto the stage.
     
     - Parameter title: The title of the book.
     - Parameter author: The author of the book.
     */
    func drawMetadata(title: String, author: String) {
        let styledMetadata = NSMutableAttributedString(string: "— \(title), \(author)")
        styledMetadata.addAttribute(NSForegroundColorAttributeName, value: COLOUR[self.THEME_MODE]!["METADATA"]!, range: NSMakeRange(0, styledMetadata.length))
        styledMetadata.addAttribute(NSFontAttributeName, value: FONT_METADATA, range: NSMakeRange(0, styledMetadata.length))
        
        styledMetadata.draw(in: CGRect(x: 100.0, y: 50, width: 1400, height: 50))
    }
    
    /**
     clearStage clears the stage, by filling it with a solid colour.
     */
    func clearStage() {
        COLOUR[self.THEME_MODE]!["BACKGROUND"]!.setFill()
        NSRectFill(self.bounds)
    }
    
    /**
     draw is called to initialise the stage of the screen saver.
     */
    override func draw(_ rect: NSRect) {
        super.draw(rect)
        
        let quote = self.quotes[0]
        
        clearStage()
        drawQuote(quote.quote, subquote: quote.subquote)
    }
}
