//
//  LKMainViewController.swift
//  Countr
//
//  Created by Lukas Kollmer on 2/1/15.
//  Copyright (c) 2015 Lukas Kollmer. All rights reserved.
//

import Foundation
import UIKit
import iAd

class LKMainViewController: UIViewController, ADBannerViewDelegate {
    
    @IBOutlet weak var addButton: UIBarButtonItem!
    @IBOutlet weak var adBannerView: ADBannerView!
    
    var collectionViewController: LKMainCollectionViewController?
    
    override func loadView() {
        super.loadView()
        
        self.adBannerView.delegate = self
        self.adBannerView.hidden = true
        
        if LKPurchaseManager.didPurchase {
            self.adBannerView.removeFromSuperview()
            self.adBannerView.delegate = nil
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "embedCollectionView" {
            self.collectionViewController = segue.destinationViewController as LKMainCollectionViewController
            DDLogVerbose("self.bounds: \(self.view.bounds)")
            self.collectionViewController?.collectionView?.bounds = self.view.bounds
            DDLogVerbose("collectionView.bounds: \(self.collectionViewController?.collectionView?.bounds)")
        }
    }
    
    func adjustViewForAdBannerVisible(visible: Bool) {
        if visible {
            self.adBannerView.hidden = false
            let top = self.collectionViewController?.collectionView?.contentInset.top
            self.collectionViewController?.collectionView?.contentInset = UIEdgeInsetsMake(top!, 0, 55, 0)
            self.collectionViewController?.collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(top!, 0, 55, 0)
        } else {
            self.adBannerView.hidden = true
            let top = self.collectionViewController?.collectionView?.contentInset.top
            self.collectionViewController?.collectionView?.contentInset = UIEdgeInsetsMake(top!, 0, 0, 0)
            self.collectionViewController?.collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(top!, 0, 0, 0)
        }
    }
    
    
    // MARK: ADBannerView delegate
    func bannerViewWillLoadAd(banner: ADBannerView!) {
        DDLogVerbose("bannerViewWillLoadAd")
    }
    
    func bannerViewDidLoadAd(banner: ADBannerView!) {
        DDLogVerbose("bannerViewDidLoadAd")
        adjustViewForAdBannerVisible(true)
    }
    
    func bannerViewActionShouldBegin(banner: ADBannerView!, willLeaveApplication willLeave: Bool) -> Bool {
        DDLogVerbose("bannerViewActionShouldBegin")
        return true
    }
    
    func bannerViewActionDidFinish(banner: ADBannerView!) {
        DDLogVerbose("bannerViewActionDidFinish")
    }
    
    func bannerView(banner: ADBannerView!, didFailToReceiveAdWithError error: NSError!) {
        DDLogVerbose("bannerViewDidFailToReceiveAdWithError")
        DDLogVerbose("error: \(error.debugDescription)")
        adjustViewForAdBannerVisible(false)
    }
}