//
//  editPicture.swift
//  picApp
//
//  Created by Jeferson Montanha on 17/05/16.
//  Copyright © 2016 Jeferson Montanha. All rights reserved.
//

import UIKit

class EditPicture: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    var originalImage = UIImage()
    var filteredImage: UIImage?
    
    
    
    
    
    var currentlyFilter:FiltersMap = .blank
    
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var label: UILabel!
    @IBOutlet var sliderView: UIView!
    @IBOutlet var secondaryMenu: UIView!
    @IBOutlet var bottomMenu: UIView!
    @IBOutlet var menuBar: UIView!
    @IBOutlet var labelView: UIView!
    
    let longPressRec = UILongPressGestureRecognizer()
    
    //All the buttons
    
    @IBOutlet var filterButton: UIButton!
    @IBOutlet var compareButton: UIButton!
   
    @IBOutlet var editButton: UIButton!
    @IBOutlet var redFilterButton: UIButton!
    @IBOutlet var greenFilterButton: UIButton!
    @IBOutlet var blueFilterButton: UIButton!
    @IBOutlet var brightFilterButton: UIButton!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        editButton.enabled = false
        compareButton.enabled = false
        self.imageView.image = originalImage
        imageView.userInteractionEnabled = false
        
        
        longPressRec.addTarget(self, action: "longPressedView:")
        imageView.addGestureRecognizer(longPressRec)
        
        
        disableButtons()
        
        labelView.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.5)
        labelView.translatesAutoresizingMaskIntoConstraints = false
        
        
        secondaryMenu.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.5)
        secondaryMenu.translatesAutoresizingMaskIntoConstraints = false
        
        sliderView.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.5)
        sliderView.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    
    // MARK: Share
    @IBAction func onShare(sender: AnyObject) {
        let activityController = UIActivityViewController(activityItems: ["Check out our really cool app", imageView.image!], applicationActivities: nil)
        presentViewController(activityController, animated: true, completion: nil)
    }
    
    // MARK: New Photo
    @IBAction func onNewPhoto(sender: AnyObject) {
        let actionSheet = UIAlertController(title: "New Photo", message: nil, preferredStyle: .ActionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .Default, handler: { action in
            self.showCamera()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Album", style: .Default, handler: { action in
            self.showAlbum()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        
        self.presentViewController(actionSheet, animated: true, completion: nil)
    }
    
    func showCamera() {
        let cameraPicker = UIImagePickerController()
        cameraPicker.delegate = self
        cameraPicker.sourceType = .Camera
        
        presentViewController(cameraPicker, animated: true, completion: nil)
    }
    
    func showAlbum() {
        let cameraPicker = UIImagePickerController()
        cameraPicker.delegate = self
        cameraPicker.sourceType = .PhotoLibrary
        
        presentViewController(cameraPicker, animated: true, completion: nil)
    }
    
    // MARK: UIImagePickerControllerDelegate
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        dismissViewControllerAnimated(true, completion: nil)
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            originalImage = image
            imageView.image = originalImage
        }
        enableButtons()
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: Filter Menu
    @IBAction func onFilter(sender: UIButton) {
        
        if (sender.selected) {
            hideSecondaryMenu()
            sender.selected = false
        } else {
            
            showSecondaryMenu()
            sender.selected = true
            
        }
    }
    
    
    @IBAction func onEdit(sender: UIButton) {
        if sender.selected{
            print("desmarcado")
            sender.selected = false
            hideSliderOptions()
        }
        else
        {
            print("Mostra o menu")
            showSliderOptions()
            sender.selected = true
            hideSecondaryMenu()
        }
    }
    
    
    @IBAction func onSlider(sender: UISlider) {
        
        let value = Int (sender.value)
        
        switch (currentlyFilter){
        case FiltersMap.RedOne:
            let photo = PixelInfo(xImage: originalImage)
            let newImage = Filters(toBeChanged: photo)
            filteredImage = newImage.redFilter(value)
            imageView.image = filteredImage
            break
            
        case FiltersMap.GreenOne:
            let photo = PixelInfo(xImage: originalImage)
            let newImage = Filters(toBeChanged: photo)
            filteredImage = newImage.nightViewEffect(value)
            imageView.image = filteredImage
            break
            
        case FiltersMap.BlueOne:
            let photo = PixelInfo(xImage: originalImage)
            let newImage = Filters(toBeChanged: photo)
            filteredImage = newImage.purpleMe(value)
            imageView.image = filteredImage
            break
        case FiltersMap.brightness:
            let photo = PixelInfo(xImage: originalImage)
            let newImage = Filters(toBeChanged: photo)
            filteredImage = newImage.brightness(value)
            imageView.image = filteredImage
            break
        case FiltersMap.alpha:
            let photo = PixelInfo(xImage: originalImage)
            let newImage = Filters(toBeChanged: photo)
            filteredImage = newImage.changeAlphaFactor(value)
            imageView.image = filteredImage
            break
        default:
            //todo
            break
        }
        
    }
    
    
    func showLabel(){
        view.addSubview(labelView)
        let topConstraint = labelView.topAnchor.constraintEqualToAnchor(topLayoutGuide.bottomAnchor)
        let width = labelView.widthAnchor.constraintEqualToAnchor(imageView.widthAnchor)
        
        label.textAlignment = .Center
        
        NSLayoutConstraint.activateConstraints([topConstraint, width])
        view.layoutIfNeeded()
        
        
        self.labelView.alpha = 0
        UIView.animateWithDuration(0.4) {
            self.labelView.alpha = 1.0
        }
        
    }
    
    
    func hideLabel(){
        UIView.animateWithDuration(0.4, animations: {
            self.labelView.alpha = 0
            }) {
                completed in
                if completed == true {
                    self.labelView.removeFromSuperview()
                }
        }
    }
    
    
    
    func showSliderOptions(){
        view.addSubview(sliderView)
        
        let bottomConstraint = sliderView.bottomAnchor.constraintEqualToAnchor(bottomMenu.topAnchor)
        let leftConstraint = sliderView.leftAnchor.constraintEqualToAnchor(view.leftAnchor)
        let rightConstraint = sliderView.rightAnchor.constraintEqualToAnchor(view.rightAnchor)
        
        let heightConstraint = sliderView.heightAnchor.constraintEqualToConstant(44)
        
        
        NSLayoutConstraint.activateConstraints([bottomConstraint, leftConstraint, rightConstraint, heightConstraint ])
        
        view.layoutIfNeeded()
        
        
        self.sliderView.alpha = 0
        UIView.animateWithDuration(0.4) {
            self.sliderView.alpha = 1.0
        }
        
        
    }
    
    func hideSliderOptions(){
        UIView.animateWithDuration(0.4, animations: {
            self.sliderView.alpha = 0
            }) {completed in
                if completed == true {
                    self.sliderView.removeFromSuperview()
                }
        }
        editButton.selected = false
        
    }
    
    func showSecondaryMenu() {
        hideSliderOptions()
        view.addSubview(secondaryMenu)
        let bottomConstraint = secondaryMenu.bottomAnchor.constraintEqualToAnchor(bottomMenu.topAnchor)
        let leftConstraint = secondaryMenu.leftAnchor.constraintEqualToAnchor(view.leftAnchor)
        let rightConstraint = secondaryMenu.rightAnchor.constraintEqualToAnchor(view.rightAnchor)
        
        let heightConstraint = secondaryMenu.heightAnchor.constraintEqualToConstant(44)
        
        NSLayoutConstraint.activateConstraints([bottomConstraint, leftConstraint, rightConstraint, heightConstraint])
        
        view.layoutIfNeeded()
        
        self.secondaryMenu.alpha = 0
        UIView.animateWithDuration(0.4) {
            self.secondaryMenu.alpha = 1.0
        }
    }
    
    func hideSecondaryMenu() {
        UIView.animateWithDuration(0.4, animations: {
            self.secondaryMenu.alpha = 0
            }) { completed in
                if completed == true {
                    self.secondaryMenu.removeFromSuperview()
                }
        }
        filterButton.selected = false
    }
    
    
    func effectFadeIn(sender:UIView){
        sender.alpha = 0
        UIView.animateWithDuration(0.9){
            sender.alpha = 1.0
        }
    }
    
    //APPLYING FILTERS
    
    @IBAction func onApplyingFilter(sender: UIButton) {
        
        let selected: String = sender.titleLabel!.text!
        
        if imageView.image != nil {
            switch (selected){
            case "Red":
                let photo = PixelInfo(xImage: originalImage)
                let newImage = Filters(toBeChanged: photo)
                filteredImage = newImage.redFilter(0)
                imageView.image = filteredImage
                effectFadeIn(imageView)
                enableExtraButtons()
                currentlyFilter = FiltersMap.RedOne
                break
                
            case "Green":
                let photo = PixelInfo(xImage: originalImage)
                let newImage = Filters(toBeChanged: photo)
                filteredImage = newImage.nightViewEffect(0)
                imageView.image = filteredImage
                effectFadeIn(imageView)
                enableExtraButtons()
                currentlyFilter = FiltersMap.GreenOne
                break
                
            case "Blue":
                
                let photo = PixelInfo(xImage: originalImage)
                let newImage = Filters(toBeChanged: photo)
                filteredImage = newImage.purpleMe(0)
                imageView.image = filteredImage
                effectFadeIn(imageView)
                enableExtraButtons()
                currentlyFilter = FiltersMap.BlueOne
                break
                
                
            case "Bright" :
                let photo = PixelInfo(xImage: originalImage)
                let newImage = Filters(toBeChanged: photo)
                filteredImage = newImage.changeAlphaFactor(255)
                imageView.image = filteredImage
                effectFadeIn(imageView)
                enableExtraButtons()
                currentlyFilter = FiltersMap.alpha
                print("pressed")
                break
            default:
                print("Error")
                break
            }
            
            compareButton.enabled = true
            editButton.enabled = true
            imageView.userInteractionEnabled = true
        }
        else{
            disableButtons()
        }
        
    }
    
    @IBAction func comparePictures(sender: UIButton) {
        if sender.selected == false {
            sender.selected = true
            imageView.image = originalImage
            showLabel()
            effectFadeIn(imageView)
        }
        else{
            sender.selected = false
            imageView.image = filteredImage
            hideLabel()
            
            UIView.animateWithDuration(0.4, animations: {
                self.imageView.alpha = 0
                }) { completed in
                    if completed == true {
                        self.imageView.image = self.filteredImage
                        self.imageView.alpha = 1
                    }
            }
            
        }
    }
    
    func disableButtons(){
        if imageView.image == nil {
            compareButton.enabled = false
            editButton.enabled = false
        }
    }
    
    func enableButtons(){
        if imageView.image != nil {
            filterButton.enabled = true
        }
    }
    
    func enableExtraButtons(){
        if filteredImage != nil{
            compareButton.enabled = true
            editButton.enabled = true
        }
    }
    
    
    func tapGest(){
        let tg = UITapGestureRecognizer (target: self, action: "tapped")
        imageView.addGestureRecognizer(tg)
    }
    
    func tapped(){
        
            if imageView.image == originalImage{
                imageView.image = filteredImage
            }
            else{
                imageView.image = originalImage
            }
        
    }
    
    
    func longPressedView(longPressRec : UILongPressGestureRecognizer){
        
        
            
            if longPressRec.state == .Began{
                print("Começou")
                
                if imageView.image == originalImage{
                    imageView.image = filteredImage
                    effectFadeIn(imageView)
                    hideLabel()
                }
                else{
                    imageView.image = originalImage
                    effectFadeIn(imageView)
                    showLabel()
                }
            }
            
            
            if longPressRec.state == .Ended{
                print("terminou")
                if imageView.image == originalImage{
                    
                    
                    UIView.animateWithDuration(0.4, animations: {
                        self.imageView.alpha = 0
                        }) { completed in
                            if completed == true {
                                self.imageView.image = self.filteredImage
                                self.imageView.alpha = 1
                            }
                    }
                    
                    hideLabel()
                }
                else{
                    imageView.image = originalImage
                    showLabel()
                }
            }
        }
    


}
