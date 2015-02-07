//
//  TodayViewController.swift
//  TodayExtension
//
//  Created by Lukas Kollmer on 1/17/15.
//  Copyright (c) 2015 Lukas Kollmer. All rights reserved.
//

import UIKit
import CoreData
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
    
    let countdownManager = LKCountdownManager.sharedInstance
    
    var timer: NSTimer?
    
    var itemsCached: [LKCountdownItem] = []
    
    @IBOutlet var gestureRecognizer: [UITapGestureRecognizer]!
    @IBOutlet var backgroundViews: [UIView]!
    @IBOutlet var allLabels: [UILabel]!
    @IBOutlet var countdownRemainingLabels: [UILabel]!
    @IBOutlet var countdownTitleLabels: [UILabel]!
    
    @IBOutlet var itemOneLabels: [UILabel]!
    @IBOutlet var itemTwoLabels: [UILabel]!
    @IBOutlet var itemThreeLabels: [UILabel]!
    
    @IBOutlet weak var messageLabel: UILabel!
    
    override func loadView() {
        super.loadView()
        //println("loadView")
        
        for view in self.backgroundViews {
            view.hidden = true
            view.frame = CGRectZero
            view.removeFromSuperview()
        }
        
        
        self.preferredContentSize = CGSizeMake(320, 246)
        
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.
        
        
        /*
        for label in self.countdownTitleLabels {
            let index = find(self.countdownTitleLabels, label)!
            self.countdownTitleLabels[index].text = self.countdownManager.items()[index].name
        }
        
        // TODO: [MAYBE] Create a second timer which checks for new/deletd content every 10-20 seconds
*/
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.countdownManager.reload()
        
        //println("data loaded in extension: \(self.countdownManager.items())")
        //println("number of items loaded in teh \(self.countdownManager.items().count)")
        
        configureViewForCountdownItems()
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        stopTimer()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)!) {
        // Perform any setup necessary in order to update the view.

        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData

        completionHandler(NCUpdateResult.NewData)
    }
    
    func configureViewForCountdownItems() {
        //println("data loaded in extension: \(self.countdownManager.items())")
        //println("number of items loaded in teh \(self.countdownManager.items().count)")
        
        //for view in self.backgroundViews {
        //    view.alpha = 0.00000001
        //}
        
        for label in self.countdownRemainingLabels {
            label.font = UIFont(name: "Avenir-Book", size: 20)
        }
        
        for label in self.countdownTitleLabels {
            label.font = UIFont(name: "Avenir-Book", size: 17)
        }
        self.messageLabel.hidden = true
        
        switch self.countdownManager.numberOfItems {
        case 0:
            //println("0 items")
            for label in self.allLabels {
                label.hidden = true
                label.text = nil
                label.frame = CGRectZero
                self.preferredContentSize = CGSizeMake(0, 40)
            }
            
            for view in self.backgroundViews {
                view.hidden = true
                view.frame = CGRectZero
                view.removeFromSuperview()
            }
            self.messageLabel.hidden = false
            break
        case 1:
            //println("1 items")
            
            let allItems = self.countdownManager.items()
            self.itemsCached.append(allItems[0])
            
            /*
            self.backgroundViews[1].hidden = true
            self.backgroundViews[1].frame = CGRectZero
            self.backgroundViews[1].removeFromSuperview()
            
            self.backgroundViews[2].hidden = true
            self.backgroundViews[2].frame = CGRectZero
            self.backgroundViews[2].removeFromSuperview()
            */
            
            

            
            for label in self.itemTwoLabels {
                label.hidden = true
                label.text = nil
                label.frame = CGRectZero
            }
            
            for label in self.itemThreeLabels {
                label.hidden = true
                label.text = nil
                label.frame = CGRectZero
            }
            
            self.preferredContentSize = CGSizeMake(0, 70)
            startTimer()
            break
        case 2:
            
            //println("2 items")
            
            let allItems = self.countdownManager.items()
            self.itemsCached.append(allItems[0])
            self.itemsCached.append(allItems[1])
            
            for label in self.itemThreeLabels {
                label.hidden = true
                label.text = nil
                label.frame = CGRectZero
            }
            
            /*
            self.backgroundViews[2].hidden = true
            self.backgroundViews[2].frame = CGRectZero
            self.backgroundViews[2].removeFromSuperview()
            */
            
            self.preferredContentSize = CGSizeMake(0, 135)
            startTimer()
            break
        case 3:
            
            let allItems = self.countdownManager.items()
            self.itemsCached.append(allItems[0])
            self.itemsCached.append(allItems[1])
            self.itemsCached.append(allItems[2])
            startTimer()
            break
        default:
            // More than 3 items
            break
            
        }
        
        // Set the titles
        for item in self.itemsCached {
            let index = find(self.itemsCached, item)!
            self.countdownTitleLabels[index].text = item.name
        }

    }
    
    
    
    func startTimer() {
        self.timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "update", userInfo: nil, repeats: true)
    }
    
    
    func stopTimer() {
        self.timer?.invalidate()
        self.timer = nil
    }
    
    func update() {
        for item in self.itemsCached {
            //println("in the loop")
            item.updateTimeRemaining()
            let index = find(self.itemsCached, item)!
            self.countdownRemainingLabels[index].text = item.remaining.asString
        }
        

        
    }
    
    /*
    // MARK: UI Interaction
    @IBAction func didTapGestureRecognizer(sender: UITapGestureRecognizer) {
        switch sender {
        case self.gestureRecognizer[0]:
            //println("did tap the first view")
            break
        case self.gestureRecognizer[1]:
            //println("did tap the second view")
            break
        case self.gestureRecognizer[2]:
            //println("did tap the third view")
            break
        default:
            break
        }
    }
*/
    
    
}
