//
//  CollectionViewCell.swift
//  picApp
//
//  Created by Jeferson Montanha on 01/05/16.
//  Copyright © 2016 Jeferson Montanha. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    
    weak var dataTask: NSURLSessionDataTask?
}
