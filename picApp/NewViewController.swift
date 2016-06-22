//
//  NewViewController.swift
//  picApp
//
//  Created by Jeferson Montanha on 01/05/16.
//  Copyright © 2016 Jeferson Montanha. All rights reserved.
//

import UIKit

class NewViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet var label: UILabel!
    @IBOutlet var imageView: UIImageView!
    
    @IBOutlet var scrollView: UIScrollView!
    var image = UIImage()
    var label_text = String()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imageView.image = self.image
        self.label.text = label_text
        
        self.scrollView.minimumZoomScale = 1.0
        self.scrollView.maximumZoomScale = 6.0
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "editPicture"){
            
            let navVC = segue.destinationViewController as! EditPicture
            
            
            
            navVC.originalImage = self.image
        }
    }
    

   }
