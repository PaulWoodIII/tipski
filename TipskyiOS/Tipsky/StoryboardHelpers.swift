//
//  Segues.swift
//  Tipski
//
//  Created by Paul Wood on 10/27/16.
//  Copyright © 2016 Paul Wood. All rights reserved.
//

import Foundation
import UIKit

enum Segues : String {
    case settings = "showSettings"
}

enum ViewControllerIdentifiers : String {
    case fullTabBarController = "FullTabBarController"
    case partialTabBarController = "PartialTabBarController"
}

protocol StoryBoardViewController {
    static var storyBoardIdentifier : String {get}
}

extension StoryBoardViewController where Self : UIViewController {
    static func viewControllerFromStoryBoard() -> Self {
        let viewController: Self = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: Self.storyBoardIdentifier)
            as! Self
        return viewController
    }
}
