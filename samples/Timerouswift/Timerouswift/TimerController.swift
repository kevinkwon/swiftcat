//
//  TimerController.swift
//  Timerouswift
//
//  Created by WooKyoung Noh on 7/24/14.
//  Copyright (c) 2014 factorcat. All rights reserved.
//

import Cocoa

class TimerController: NSWindowController, TimerDelegate {
    @IBOutlet var sevenMinutesButton: NSButton
    @IBOutlet var fiveMinutesButton: NSButton
    @IBOutlet var oneMinutesMoreButton : NSButton
    @IBOutlet var oneSecondsMoreButton : NSButton
    @IBOutlet var startButton: NSButton
    @IBOutlet var stopButton: NSButton
    @IBOutlet var pauseButton : NSButton
    @IBOutlet var display: NSTextField

    var timer : Timer = Timer()
    
    func TimerUpdateTicks()  {
        updateDisplay()
    }
    
    func TimerStopped() {
        startButton.enabled = true
        pauseButton.enabled = false
        stopButton.enabled = false
    }
    
    func TimerBeep() {
        display.backgroundColor = NSColor.redColor()
    }
    
    func displayInit() {
        display.backgroundColor = NSColor.blackColor()
    }
    
    func defaultAction() {
        fiveMinutesButtonClicked(0)
    }
    
    func updateDisplay() {
        let ti : Int = Int(timer.remain)
        let seconds : Int = ti % 60
        let minutes : Int = (ti / 60) % 60
        display.stringValue = NSString(format:"%u:%02u", minutes, seconds)
    }
    
    override func windowDidLoad() {
        timer.delegate = self
        pauseButton.enabled = false
        stopButton.enabled = false
        defaultAction()
    }
    
    @IBAction func sevenMinutesButtonClicked(sender : AnyObject) {
        timer.remain = 60 * 7
        updateDisplay()
        displayInit()
    }

    @IBAction func fiveMinutesButtonClicked(sender : AnyObject) {
        timer.remain = 60 * 5
        updateDisplay()
        displayInit()
    }

    @IBAction func oneMinutesMoreButtonClicked(sender : AnyObject) {
        timer.remain += 60
        updateDisplay()
        displayInit()
    }
    
    @IBAction func oneSecondsMoreButtonClicked(sender : AnyObject) {
        timer.remain += 1
        updateDisplay()
        displayInit()
    }


    @IBAction func start(sender : AnyObject) {
        if timer.start() {
            startButton.enabled = false
            pauseButton.enabled = true
            stopButton.enabled = true
        } else {
            if 0 == timer.remain {
                defaultAction()
                start(0)
            }
        }
        displayInit()
    }

    @IBAction func stop(sender : AnyObject) {
        timer.stop()
        TimerStopped()
    }

    @IBAction func pause(sender : AnyObject) {
        if timer.tick {
            pauseButton.title = "계속"
        } else {
            pauseButton.title = "일시정지"
        }
        timer.pause()
    }
}