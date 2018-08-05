//
//  AppDelegate.swift
//  literary-screensaver-test
//
//  Created by James Liu on 5/8/18.
//  Copyright © 2018 James Liu. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!
    
    lazy var screenSaverView = Main(frame: NSZeroRect, isPreview: false)

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        if let screenSaverView = screenSaverView {
            screenSaverView.frame = window.contentView!.bounds;
            window.contentView!.addSubview(screenSaverView);
        }
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

