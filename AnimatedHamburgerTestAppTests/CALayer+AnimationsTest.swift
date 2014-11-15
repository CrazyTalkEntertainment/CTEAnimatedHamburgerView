//
//  CALayer+AnimationsTest.swift
//  AnimatedHamburgerTestApp
//
//  Created by CrazyTalk Entertainment on 2014-11-14.
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


class CALayerAnimationsTests: XCTestCase {

    let sut = CALayer()
    
    func testAddRotationalAnimation()
    {
        sut.addRotationalAnimation(CGFloat(M_PI), calculationMode: nil, keyTimes: nil)
        XCTAssertNotNil(sut.animationForKey("transform"), "animation was not added to layer")
    }
    
    func testAddPositionAnimation()
    {
        sut.addPositionAnimation(CGPoint(x: 0, y: 0), toPoint: CGPoint(x: 0, y: 100), controlPoint: CGPoint(x: 50, y: 50))
        XCTAssertNotNil(sut.animationForKey("position"), "animation was not added to layer")
    }
    
    func testRotationValuesFromTransform()
    {
        let keyFrames = sut.rotationValuesFromTransform(CGFloat(M_PI), frames: 4)
        XCTAssert(keyFrames.count == 4, "incorrect number of key frames were created")
    }
    
    //MARK: performance tests
    
    func testPerformanceAddRotationalAnimation()
    {
        self.measureBlock() {
            
            self.sut.addRotationalAnimation(CGFloat(M_PI), calculationMode: nil, keyTimes: nil)
        }
    }
    
    func testPerformanceAddPositionAnimation()
    {
        self.measureBlock() {
            
            self.sut.addPositionAnimation(CGPoint(x: 0, y: 0), toPoint: CGPoint(x: 0, y: 100), controlPoint: CGPoint(x: 50, y: 50))
        }
    }
    
    func testPerformanceRotationValuesFromTransform()
    {
        self.measureBlock() {
            
            let keyFrames = self.sut.rotationValuesFromTransform(CGFloat(M_PI), frames: 4)
        }
    }
}







