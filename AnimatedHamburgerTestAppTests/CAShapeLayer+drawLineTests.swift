//
//  CAShapeLayer+drawLineTests.swift
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


class CAShaperLayerDrawLineTests: XCTestCase {

    let sut = CAShapeLayer()
    
    func testBezierPathForLine()
    {
        let path = CAShapeLayer.bezierPathForLine(CGPoint(x: 0, y: 0), toPoint: CGPoint(x: 0, y: 100), controlPoint: CGPoint(x: 50, y: 50))
        XCTAssertNotNil(path, "Bezier path was not created")
    }
    
    func testPointAlongQuadBezierPath()
    {
        let point = CAShapeLayer.pointAlongQuadBezierPath(CGPoint(x: 0, y: 0), toPoint: CGPoint(x: 0, y: 100), controlPoint: CGPoint(x: 50, y: 50), percent: 0.5)
        XCTAssert(point.x == 25, "point.x was not calculated correctly")
        XCTAssert(point.y == 50, "point.y was not calculated correctly")
    }
    
    func testCalculateCoordinateAlongPath()
    {
        let coord = CAShapeLayer.calculateCoordinateAlongPath(0, coord1: 50, coord2: 100, t: 0.5)
        XCTAssert(coord == 50, "coord was not calculated correctly")
    }
    
    func testPointAlongLine()
    {
        let point = CAShapeLayer.pointAlongLine(CGPoint(x:0, y:0), endPoint: CGPoint(x: 100, y: 100), t: 0.5)
        XCTAssert(point.x == 50, "point.x was not calculated correctly")
        XCTAssert(point.y == 50, "point.y was not calculated correctly")
    }
    
    func testDrawLine()
    {
        sut.drawLine(CGPoint(x: 0, y: 0), toPoint: CGPoint(x: 100, y: 0), thickness: 10.0, color: UIColor.blueColor(), alpha: 1.0)
        XCTAssertNotNil(sut.path, "path was not created")
        XCTAssert(CGColorEqualToColor(sut.strokeColor, UIColor.blueColor().CGColor), "stroke color was not set correctly")
        XCTAssert(sut.lineWidth == 10.0, "line thickness was not set correctly")
        XCTAssert(sut.opacity == 1.0, "opacity was not set correctly")
    }
    
    func testAngleDelta()
    {
        let rotation = CATransform3DRotate(sut.transform, CGFloat(M_PI), 0, 0, 1)
        let angle = sut.angleDelta(CGFloat(M_PI_2))
        XCTAssert(angle == CGFloat(M_PI_2), "angle delta was not calculated correctly")
    }
    
    //MARK: performance tests
    
    func testPerformanceBezierPathForLine()
    {
        self.measureBlock() {
            
            let path = CAShapeLayer.bezierPathForLine(CGPoint(x: 0, y: 0), toPoint: CGPoint(x: 0, y: 100), controlPoint: CGPoint(x: 50, y: 50))
        }
    }
    
    func testPerformancePointAlongQuadBezierPath()
    {
        self.measureBlock() {
          
            let point = CAShapeLayer.pointAlongQuadBezierPath(CGPoint(x: 0, y: 0), toPoint: CGPoint(x: 0, y: 100), controlPoint: CGPoint(x: 50, y: 50), percent: 0.5)
        }
    }
    
    func testPerformanceCalculateCoordinateAlongPath()
    {
        self.measureBlock() {
            
            let coord = CAShapeLayer.calculateCoordinateAlongPath(0, coord1: 50, coord2: 100, t: 0.5)
        }
    }
    
    func testPerformancePointAlongLine()
    {
        self.measureBlock() {
            
            let point = CAShapeLayer.pointAlongLine(CGPoint(x:0, y:0), endPoint: CGPoint(x: 100, y: 100), t: 0.5)
        }
    }
    
    func testPerformanceDrawLine()
    {
        self.measureBlock() {
            
           self.sut.drawLine(CGPoint(x: 0, y: 0), toPoint: CGPoint(x: 100, y: 0), thickness: 10.0, color: UIColor.blueColor(), alpha: 1.0)
        }
    }
    
    func testPerformanceAngleDelta()
    {
        self.measureBlock() {
            
            let angle = self.sut.angleDelta(CGFloat(M_PI))
        }
    }
}






