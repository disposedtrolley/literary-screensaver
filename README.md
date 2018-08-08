# Literary Screensaver

A macOS screensaver that displays the time in the form of literary quotes. Inspired by the [Literary Clock Made from E-Reader](https://www.instructables.com/id/Literary-Clock-Made-From-E-reader/) project. Quote-to-time mapping data are sourced from this project.

![Preview](http://jamesliu.io/static/styled_screensaver_2-8de95def426e48665edbb8277d857555-214d1.jpg)

This is still a heavy work in progress 🚧 but expect some regular updates over the coming days. The initial hurdles of setting up a screensaver plugin project and getting it to play nicely with Swift have been passed, along with reading and parsing the CSV file with the quote data, and having the correct record displayed according to the time.

The challenges going forward are:

- [x] styling the text, especially around differentiating the portion of the quote which represents the time (this would be easy on the web, but I don't think one can simply bold text in the middle of a string drawn to an `NSView` 🧐).
- [x] resizing the text based on the amount, and wrapping text to a new line where it makes sense.
- [ ] reworking the data structure used to store the quotes (thinking a dictionary 📖 would be good, where the keys are the time and the values are the array of associated quotes; this would give us O(1) access times and an easy way to randomise a quote if we have multiple to choose from.
- [ ] accounting for different screen sizes (currently works on a 15" Retina display or up, set to a 1650x1080 resolution equivalent).
- [ ] adding more themes and customisable styling.

~~I've only been at it for a day, but it's been a super fun learning exercise and a great excuse to get back into Swift 😃~~

**Update**

~~An [early release](https://github.com/disposedtrolley/literary-screensaver/releases/tag/0.1) is now available! Check it out if you're brave enough.~~

A [beta](https://github.com/disposedtrolley/literary-screensaver/releases/tag/0.2-beta) is now out! The major change from 0.1 is the addition of different styling for the time portion of the quote.
