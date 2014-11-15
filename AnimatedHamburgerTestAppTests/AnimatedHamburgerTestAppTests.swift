//
//  AnimatedHamburgerTestAppTests.swift
//  AnimatedHamburgerTestAppTests
//
//  Created by CrazyTalk Entertainment on 2014-11-03.
//  Copyright (c) 2014 CrazyTalk Entertainment. All rights reserved.
//
//  Created by CrazyTalk Entertainment on 2014-11-12.
//  Copyright (c) 2014 CrazyTalk Entertainment. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import UIKit
import XCTest

class AnimatedHamburgerTestAppTests: XCTestCase {
    
    let sut: CTEAnimatedHamburgerView = CTEAnimatedHamburgerView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    
    func testInit()
    {
        XCTAssertNotNil(sut, "view did not load correctly")
        XCTAssertNotNil(sut.layer.sublayers, "line setup was not successful")
        XCTAssertNotNil(sut.gestureRecognizers, "tap gesture was not created correctly")
        
    }
    
    func testCalulateLineLength_ButtLineCap()
    {
        sut.lineThickness = 15.0
        XCTAssert(sut.lineLength == 80, "line length was not calculated correctly")
    }
    
    func testCalulateLineLength_SquareLineCap()
    {
        sut.lineCapType = kCALineCapSquare
        sut.lineThickness = 15.0
        XCTAssert(sut.lineLength == 65, "line length was not calculated correctly")
    }
    
    func testIsTransitionComplete_ZeroPercent()
    {
        sut.setPercentComplete(0.0)
        let transition = sut.isTransitionComplete()
        XCTAssertTrue(transition.isComplete, "incorrect value was returned for isComplete")
        XCTAssert(transition.percent == 0.0, "incorrect value was returned for percent")
    }
    
    func testIsTransitionComplete_HundredPercent()
    {
        sut.setPercentComplete(1.0)
        let transition = sut.isTransitionComplete()
        XCTAssertTrue(transition.isComplete, "incorrect value was returned for isComplete")
        XCTAssert(transition.percent == 1.0, "incorrect value was returned for percent")
    }
    
    func testIsTransitionComplete_FiftyPercent()
    {
        sut.setPercentComplete(0.5)
        let transition = sut.isTransitionComplete()
        XCTAssertFalse(transition.isComplete, "incorrect value was returned for isComplete")
        XCTAssert(transition.percent == 0.5, "incorrect value was returned for percent")
    }
    
    func testCreateLineLayerWithPosition()
    {
        let position = CGPoint(x: 83, y: 54)
        let length: CGFloat = 80.0
        let shapeLayer = sut.createLineLayerWithPosition(position, length: length, lineColor: UIColor.blueColor())
        XCTAssert(shapeLayer.position.x == position.x, "x position was not set correctly")
        XCTAssert(shapeLayer.position.y == position.y, "y position was not set correctly")
        XCTAssertTrue(CGColorEqualToColor(shapeLayer.strokeColor, UIColor.blueColor().CGColor), "color was not set correctly")
        XCTAssert(shapeLayer.bounds.width == length, "length was not set correctly")
    }
    
    func testSetPercentComplete()
    {
        let percent: CGFloat = 0.83
        sut.setPercentComplete(percent)
        XCTAssert(sut.percentComplete == percent, "percent complete was not set correctly")
    }
    
    func testSetPercentCompleteOverload()
    {
        sut.setPercentComplete(1.5)
        XCTAssert(sut.percentComplete == 1.0, "percent compete did not cap at 100%")
        
        sut.setPercentComplete(-1.5)
        XCTAssert(sut.percentComplete == 0.0, "percent compete did not cap at 0%")
    }
    
    func testRotationalCircleRadius()
    {
        let radius = sut.rotationalCircleRadius()
        XCTAssert(radius == 27.223611075682079, "radius was not calculated correctly")
    }
    
    func testRemainingDuration()
    {
        //default duration is 0.8
        let duration = sut.remainingDuration(0.5)
        XCTAssert(duration == 0.4, "remaining duration was not calculated correctly")
    }
    
    
    
    //MARK: performance Tests
    
    func testPerformanceInit()
    {
        
        self.measureBlock() {
            
            let sut: CTEAnimatedHamburgerView = CTEAnimatedHamburgerView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        }
    }
    
    func testPerformanceCalulateLineLength()
    {
        self.measureBlock() {
            
            let lineLength: CGFloat = self.sut.calculateLineLength()
        }
    }
    
    func testPerformanceIsTransitionComplete()
    {
        sut.setPercentComplete(1.0)
        self.measureBlock() {
            
            let transition = self.sut.isTransitionComplete()
        }
    }
    
    func testPerformanceCreateLineLayerWithPosition()
    {
        let position = CGPoint(x: 83, y: 54)
        let length: CGFloat = 80.0
        self.measureBlock() {
            
            let shapeLayer = self.sut.createLineLayerWithPosition(position, length: length, lineColor: UIColor.blueColor())
        }
    }
    
    func testPerformanceSetPercentComplete()
    {
        self.measureBlock() {
            
            self.sut.setPercentComplete(0.83)
        }
    }
    
   func testPerformanceRotationalCircleRadius()
    {
        self.measureBlock() {
            
            let radius = self.sut.rotationalCircleRadius()
        }
    }
    
    func testPerformanceRemainingDuration()
    {
        self.measureBlock() {
            
            let duration = self.sut.remainingDuration(0.5)
        }
    }
    
    func testPerformanceUpdateForBackArrow()
    {
        self.measureBlock() {
            
            self.sut.updateLinesForBackArrow(1.0, animate: true)
        }
    }
    
    func testPerformanceUpdateForClose()
    {
        self.measureBlock() {
            
            self.sut.updateLinesForClose(1.0, animate: true)
        }
    }
}









