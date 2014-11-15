//
//  ViewController.swift
//  AnimatedHamburgerTestApp
//
//  Created by CrazyTalk Entertainment on 2014-11-03.
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

class ViewController: UIViewController, CTEAnimatedHamburgerDelegate {

    lazy var testView:CTEAnimatedHamburgerView = {CTEAnimatedHamburgerView(frame: CGRectMake((self.view.frame.width * 0.5) - 55, 80, 100, 100))}()
    @IBOutlet var slider: UISlider?
    @IBOutlet var testView2: CTEAnimatedHamburgerView?
    var previousSliderValue: CGFloat = 0.0
    var forwardDirection: Bool = true
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.view.addSubview(testView);
        testView.lineThickness = 15.0
        testView.backgroundColor = UIColor.blackColor()
        testView.color = UIColor.whiteColor()
        testView.delegate = self
        testView.lineCapType = kCALineCapSquare
        testView.buttonType = .CTEAnimatedHamburgerTypeBack
        
        if (testView2 != nil) {
           
            testView2?.color = UIColor.whiteColor()
            testView2?.delegate = self
            testView2?.lineCapType = kCALineCapRound
            testView2?.lineThickness = 15.0
        }
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }
    
    func completeAnimation()
    {
        var percent: CGFloat = 0.0;
        let transition = testView.isTransitionComplete()
        
        if !transition.isComplete {
            
            if forwardDirection {
                
                percent = 1.0
            }
        }
        else {
            
            if transition.percent >= 1.0 {
                
                percent = 0.0
            }
            else {
                
                percent = 1.0
            }
        }
        
        
        testView.setPercentComplete(percent, animated: true)
        testView2?.setPercentComplete(percent, animated:true)
        slider!.setValue(Float(percent), animated: true)
    }
    
    //MARK: IBActions

    @IBAction func didPressAnimate(sender: UIButton)
    {
        self.completeAnimation()
    }
    
    @IBAction func didchangeSliderValue(sender: UISlider)
    {
        let sliderValue: CGFloat = CGFloat(sender.value);
        
        if (sliderValue > previousSliderValue) {
            
            forwardDirection = true
        }
        else if (sliderValue < previousSliderValue) {
            
            forwardDirection = false
        }
        
        testView.setPercentComplete(CGFloat(sender.value))
        testView2?.setPercentComplete(CGFloat(sender.value))
        previousSliderValue = CGFloat(sender.value)
    }
    
    
    //MARK: CTEAnimatedHamburgerDelegate
    
    func didTapHamburgerView(view: CTEAnimatedHamburgerView, gesture: UITapGestureRecognizer)
    {
        self.completeAnimation()
    }

}







