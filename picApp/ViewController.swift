//
//  ViewController.swift
//  picApp
//
//  Created by Jeferson Montanha on 01/05/16.
//  Copyright © 2016 Jeferson Montanha. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    var hasLastUpdate: NSDate?
    
    @IBOutlet var collectionView: UICollectionView!
    
    
    var urlSession : NSURLSession!
    
    let appleProducts = ["Zeus", "Prometheu", "Matheu", "Pompeu", "Bartolomeu", "Romeu", "Ateu", "Zeus", "Prometheu", "Matheu", "Pompeu", "Ateu", "Zeus", "Prometheu", "Matheu", "Pompeu"]
    
    let imageArray = [UIImage(named: "pug1"), UIImage(named: "pug4"), UIImage(named: "pug5"), UIImage(named: "pug6"), UIImage(named: "pug7"), UIImage(named: "pug8"), UIImage(named: "pug9"),  UIImage(named: "pug10"),  UIImage(named: "pug11"),  UIImage(named: "pug12"),  UIImage(named: "pug13"), UIImage(named: "pug14"), UIImage(named: "pug15"), UIImage(named: "pug16"), UIImage(named: "pug17"), UIImage(named: "pug18")]
    
    
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        self.urlSession = NSURLSession (configuration: configuration)
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillAppear(animated)
        self.urlSession.invalidateAndCancel()
        self.urlSession = nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //collectionView.reloadData()
        registerLastAccess()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = imageArray.count
        print(count)
        return count
        
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! CollectionViewCell
        
        cell.imageView?.image = self.imageArray[indexPath.row]
        cell.titleLabel?.text = self.appleProducts[indexPath.row]
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didEndDisplayingCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        if let cell = cell as? CollectionViewCell {
            cell.dataTask?.cancel()
        }
    }
    
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("showImage", sender: self)
    }
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showImage"{
            
            
            let indexPaths = self.collectionView.indexPathsForSelectedItems()!
            let indexPath = indexPaths[0] as NSIndexPath
            
            
            
            if segue.identifier == "showImage"{
                let collectVC = segue.destinationViewController as! NewViewController
                
                collectVC.label_text = appleProducts[indexPath.row]
                collectVC.image = imageArray[indexPath.row]!
                
            }
    
        }
    }
    
    func updateAccess(){
        
        var message: String?
        
        let lastUpdate = NSUserDefaults.standardUserDefaults().objectForKey("updated") as? NSDate
        
        if let hasLastUpdate = lastUpdate {
            message = "Your last Access was on" + (hasLastUpdate.description)
        }
        else{
            message = "Welcome, this is your first access"
        }
        let alert = UIAlertController(title: "Welcome", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let okayButton = UIAlertAction(title: "ok", style: UIAlertActionStyle.Cancel, handler: nil)
        alert.addAction(okayButton)
        
        presentViewController(alert, animated: true, completion: nil)
    }
    
    func registerLastAccess(){
        let now = NSDate()
        NSUserDefaults.standardUserDefaults().setObject(now, forKey: "updated")
        self.updateAccess()
    }
    
}