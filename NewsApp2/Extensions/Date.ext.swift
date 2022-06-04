//
//  Date.ext.swift
//  NewsApp2
//
//  Created by Karolina Sulik on 03.06.22.
//

import Foundation

extension Date {
    func getStringRepresentation() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd. MMM yyyy - HH:mm "
        
        return dateFormatter.string(from: self)
    }
    
}
