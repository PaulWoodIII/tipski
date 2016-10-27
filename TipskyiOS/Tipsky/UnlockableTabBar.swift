//
//  UnlockableTabBar.swift
//  Tipski
//
//  Created by Paul Wood on 10/19/16.
//  Copyright © 2016 Paul Wood. All rights reserved.
//

import Foundation
import UIKit

class UnlockableTabBar : UITabBarController {
    
    var allViewControllers : [UIViewController]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        allViewControllers = self.viewControllers
        NotificationCenter.default.addObserver(self, selector: #selector(fullUnlockChanged), name: FullUnlockChangedNotification, object: nil)
        self.updateViewControllerList()
    }

    func updateViewControllerList(){
        
        //Helper Functions
        func topOrNavTop(vc :UIViewController ) -> UIViewController {
            if let nav = vc as? UINavigationController,
                let top = nav.topViewController {
                return top
            }
            return vc
        }
        
        func freeVC(_ inc :UIViewController ) -> Bool {
            let vc : UIViewController = topOrNavTop(vc: inc)
            return vc.isKind(of: WaitstaffViewController.self) ||
                vc.isKind(of: AboutViewController.self)
        }
        
        print("viewControllers count: \(viewControllers!.count), /n view controllers:  \(viewControllers!)" )
        print ("Defaults for FullUnlock: \(UserDefaults.standard.bool(forKey: FullUnlock)) ")
        // If not unlocked remove the paid view controllers
        if !UserDefaults.standard.bool(forKey: FullUnlock) {
            //Build the free VCs
            viewControllers = (allViewControllers?.filter({ (inc) -> Bool in
                return freeVC(inc)
            }))!
        }
        else {
            viewControllers = allViewControllers
        }
        print("viewControllers count: \(viewControllers!.count), /n view controllers:  \(viewControllers!)" )
    }

    func fullUnlockChanged(note : Notification){
        print(note.name.rawValue)
        updateViewControllerList()
    }
    
}
