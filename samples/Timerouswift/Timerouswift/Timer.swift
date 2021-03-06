//
//  Timer.swift
//  Timerouswift
//
//  Created by WooKyoung Noh on 7/24/14.
//  Copyright (c) 2014 factorcat. All rights reserved.
//

import Foundation

protocol TimerDelegate {
    func TimerUpdateTicks()
    func TimerStopped()
    func TimerBeep()
}

class Timer: NSObject {
    var beep : Bool = false
    var remain : NSTimeInterval = 0
    var tick : NSTimer? = nil
    var delegate : TimerDelegate? = nil
    let audioPlayer = AudioPlayer()
    
    func stop() {
        pause()
        remain = 0
        beep = false
        delegate?.TimerUpdateTicks()
    }

    func pause() {
        if tick {
            tick?.invalidate()
            tick = nil
        } else {
            resume()
        }
    }

    func resume() {
        start()
    }

    func start() -> Bool {
        if remain > 0 {
            println("start")
            beep = true
            if !tick {
                tick = NSTimer.scheduledTimerWithTimeInterval(1, target: self,
                    selector: Selector("updateTicks"),
                    userInfo: nil,
                    repeats: true)
            }
            return true
        }
        return false
    }
    
    func updateTicks() {
        print(".")
        if (1 < remain) {
            remain -= 1
        } else {
            println("---")
            if beep {
                beep = false
                audioPlayer.play()
                delegate?.TimerBeep()
            }
            stop()
            delegate?.TimerStopped()
        }
        delegate?.TimerUpdateTicks()
    }
}