//
//  Appearance.swift
//  Tipsky
//
//  Created by Paul Wood on 10/14/16.
//  Copyright © 2016 Paul Wood. All rights reserved.
//

import UIKit

class Appearance {
    
    private struct Cache {
        static let Label30Font = UIFont(name: "OpenSans", size:30)
    }
    
    class func setAppearance () {
        
        UIView.appearance().tintColor = TipskiIcons.orangeHighlight
        
        UINavigationBar.appearance().barStyle = .black
        UINavigationBar.appearance().barTintColor = TipskiIcons.orangeHighlight
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
        
        UISlider.appearance().minimumTrackTintColor = TipskiIcons.orange
        UISlider.appearance().maximumTrackTintColor = TipskiIcons.foreground3
        
        UIButton.appearance(whenContainedInInstancesOf: [UINavigationBar.self])
            .tintColor = UIColor.white
        
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UINavigationBar.self])
            .tintColor = UIColor.white
           
    }
    
    class func reloadViewsFrom(windows : [UIWindow]){
        for window in windows {
            for view in window.subviews {
                view.removeFromSuperview()
                window.addSubview(view)
            }
        }
    }
    
    class func createWellFromView(view : UIView){
        view.backgroundColor = TipskiIcons.foreground4
        view.layer.cornerRadius = 10.0
        view.layer.masksToBounds = true
        view.layer.borderWidth = 1
        view.layer.borderColor = TipskiIcons.foreground2.cgColor
    }
    
    class func createInput(textField : UITextField){
        textField.backgroundColor = TipskiIcons.foreground3
        textField.layer.cornerRadius = 3.0
        textField.layer.masksToBounds = true
        textField.layer.borderWidth = 1
        textField.layer.borderColor = TipskiIcons.foreground1.cgColor
    }
    
    class func createSubmitButton(button : UIButton){
        button.backgroundColor = TipskiIcons.greenHighlight
        button.layer.cornerRadius = 22.0
        button.layer.masksToBounds = true
        button.layer.borderWidth = 1
        button.layer.borderColor = TipskiIcons.green.cgColor
    }
}
