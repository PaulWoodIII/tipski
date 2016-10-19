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

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createViewContollerList()
        
    }
    

    func createViewContollerList(){
        
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
        
        
        // If not unlocked remove the paid view controllers
        if (true){
            //Build the free VCs
            viewControllers = (self.viewControllers?.filter({ (inc) -> Bool in
                return freeVC(inc)
            }))!
        }
        
    }
    
}
