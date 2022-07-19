//
//  MovieButton.swift
//  MyMovies
//
//  Created by Adnan Joraid on 2022-07-19.
//

import UIKit

class MovieButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        
    }
    
    init(backgroundColor: UIColor, title: String){
        super.init(frame: .zero)
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
        configure()
    }
    

    required init?(coder: NSCoder){
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        layer.cornerRadius = 10
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func set(backgroundColor: UIColor, title:String) {
        self.backgroundColor = backgroundColor
        setTitle(title, for: .normal)
    }
    
}
