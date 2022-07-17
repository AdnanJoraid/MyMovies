//
//  MovieTitleLabel.swift
//  MyMovies
//
//  Created by Adnan Joraid on 2022-07-17.
//

import UIKit

class MovieTitleLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(textAlignment: NSTextAlignment, fontSize: CGFloat) {
        super.init(frame: .zero)
        self.textAlignment = textAlignment
        self.font = UIFont.systemFont(ofSize: fontSize, weight: .bold)
        configure()
    }
    
    private func configure(){
        textColor = .label
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.70
        lineBreakMode = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints = false 
    }

}
