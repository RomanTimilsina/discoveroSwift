//
//  CustomTimer.swift
//  Discovero
//
//  Created by Mac on 01/10/2023.
//

import Foundation

class CountdownTimer {
    private var timer: Timer?
    private var remainingSeconds: Int
    private var tickHandler: ((Int) -> Void)?
    private var completionHandler: (() -> Void)?
    
    init(initialSeconds: Int = 60) {
        self.remainingSeconds = initialSeconds
    }
    
    func start( tickHandler: ((Int) -> Void)? = nil,
                completionHandler: (() -> Void)? = nil ) {
        // Invalidate any existing timer
        timer?.invalidate()
        
        self.tickHandler = tickHandler
        self.completionHandler = completionHandler
        
        timer = Timer.scheduledTimer( timeInterval: 1.0,
                                      target: self,
                                      selector: #selector(updateTimer),
                                      userInfo: nil,
                                      repeats: true )
    }
    
    func stop() {
        timer?.invalidate()
        timer = nil
    }
    
    @objc private func updateTimer() {
        remainingSeconds -= 1
        tickHandler?(remainingSeconds)
        
        if remainingSeconds <= 0 {
            stop()
            completionHandler?()
        }
    }
}

