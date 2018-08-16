//
//  Box.swift
//  EODAssignment
//
//  Created by Harish Pathak on 16/08/18.
//  Copyright © 2018 CRMNEXT. All rights reserved.
//

import Foundation

class Box<T>{
    
    typealias Listener = (T) -> Void
    
    var listener: Listener?
    
    var value: T {
        
        didSet{
            listener?(value)
        }
    }
    
    init(v: T){
        value = v
    }
    
    func bindAndFire(listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
    
    
}
