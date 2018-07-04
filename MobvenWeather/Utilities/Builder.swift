//
//  Builder.swift
//  MobvenWeather
//
//  Created by Bilgehan IŞIKLI on 4.07.2018.
//  Copyright © 2018 by. All rights reserved.
//

import UIKit

class Builder {
    
    static func createTitledRow(with title: String, content label: UILabel) -> UIStackView {
        
        let titleLabel  = UILabel()
        titleLabel.text = title
        
        let stack = UIStackView(arrangedSubviews: [titleLabel,label])
        stack.distribution  = .fillEqually
        stack.axis          = .horizontal
        
        return stack
        
    }
    
    static func createVerticalStack(with elements:[UIView]) -> UIStackView {
        
        let stack = UIStackView(arrangedSubviews: elements)
        stack.distribution = .fillEqually
        stack.axis         = .vertical
        
        return stack
    }
    
}
