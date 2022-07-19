//
//  UIViewController+Ext.swift
//  MyMovies
//
//  Created by Adnan Joraid on 2022-07-18.
//

import Foundation
import UIKit

extension UIViewController {
    
    func presentAlertOnMainThread(title:String, message:String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alertVC = AlertVC(title: title, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
}
