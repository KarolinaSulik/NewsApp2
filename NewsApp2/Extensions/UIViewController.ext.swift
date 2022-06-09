//
//  UIViewController.ext.swift
//  NewsApp2
//
//  Created by Karolina Sulik on 08.06.22.
//

import Foundation
import UIKit

extension UIViewController {
    func presentWarningAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
                        
        //Alle UI Sachen machen wir auf main thread
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }
}
