//
//  NewsLabel.swift
//  NewsApp2
//
//  Created by Karolina Sulik on 03.06.22.
//

import UIKit

class NewsLabel: UILabel {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    init(fontStyle: UIFont.TextStyle, numberOfLines: Int = 0) {
        super.init(frame: .zero)
        
        self.font = UIFont.preferredFont(forTextStyle: fontStyle)
        self.numberOfLines = numberOfLines
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    //StoryBoard initializer
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
