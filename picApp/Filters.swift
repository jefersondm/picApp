//
//  Filters.swift
//  picApp
//
//  Created by Jeferson Montanha on 12/05/16.
//  Copyright © 2016 Jeferson Montanha. All rights reserved.
//

import Foundation
import UIKit

//Filters Class implements the protocol filterByName in regard to the last Review Criteria
public class Filters : filterByName {
    
    private var originalPhoto:PixelInfo
    
    
    
    required public init (toBeChanged:PixelInfo){
        self.originalPhoto = toBeChanged
    }
    
    
    
    //Implementation of protocol assigned to the class
    public func applyFilter(filterName:String)->UIImage{
        var img:UIImage?
        
        switch(filterName){
        case "red":
            img = redFilter(0)
            break
        case "purple":
            img = purpleMe(0)
            break
        case "nightView":
            img = nightViewEffect(0)
        default:
            print("Filter not found")
        }
        
        return img!
        
    }
    
    //PRE DEFINED FILTERS
    
    //Aplies a red filter enhancing the red parts in the image
    
    public func redFilter (factor:Int) -> UIImage{
        let img = originalPhoto.getInRgb()
        let redAvg = originalPhoto.getAvarages().red
        for y in 0..<img.height{
            for x in 0..<img.width{
                let index = y * img.width + x
                var pixel = img.pixels[index]
                
                
                let redDif = Int(pixel.red) - redAvg
                
                if(redDif > 0){
                    pixel.red = UInt8( max(0, min(255, redAvg + redDif * 2 + factor)))
                    img.pixels[index] = pixel
                }
                
            }
        }
        return img.toUIImage()!
    }
    
    
    
    //makes it a bit purple
    
    public func purpleMe(factor:Int)-> UIImage{
        let img = originalPhoto.getInRgb()
        let redAvg = originalPhoto.getAvarages().red
        let blueAvg = originalPhoto.getAvarages().blue
        for y in 0..<img.height {
            for x in 0..<img.width {
                let index = y * img.width + x
                var pixel = img.pixels[index]
                
                let redDif = Int(pixel.red) - redAvg
                let bluDif = Int(pixel.blue) - blueAvg
                
                if(redDif > 0 && bluDif > 0){
                    pixel.red = UInt8( max(0, min(255, redAvg + redDif / 2 + 50)))
                    img.pixels[index] = pixel
                    
                    pixel.blue = UInt8( max(0, min(255, blueAvg + bluDif * 2 + 50 + factor)))
                    img.pixels[index] = pixel
                }
            }
        }
        
        return img.toUIImage()!
    }
    
    //Enhance the green filter giving the effect of night view.
    
    public func nightViewEffect(factor: Int)->UIImage{
        let img = originalPhoto.getInRgb()
        let redAvg = originalPhoto.getAvarages().red
        let blueAvg = originalPhoto.getAvarages().blue
        let greenAvg = originalPhoto.getAvarages().green
        for y in 0..<img.height {
            for x in 0..<img.width {
                let index = y * img.width + x
                var pixel = img.pixels[index]
                
                let redDif = Int(pixel.red) - redAvg
                let blueDif = Int(pixel.blue) - blueAvg
                let greenDif = Int(pixel.green) - greenAvg
                
                if(redDif > 0 && blueDif > 0 && greenDif > 0){
                    pixel.red = UInt8( max(0, min(255, redAvg + redDif / 2)))
                    img.pixels[index] = pixel
                    
                    pixel.blue = UInt8( max(0, min(255, blueAvg + blueDif * 2)))
                    img.pixels[index] = pixel
                    
                    pixel.green = UInt8( max(0, min(255, greenAvg + (greenDif * 2) + factor)))
                    img.pixels[index] = pixel
                }
            }
            
            
        }
        return img.toUIImage()!
    }
    
    
    
    
    //FILTER WITH FACTORS
    //Takes the argument and changes the brightness of the picture
    public func brightness(factor:Int) -> UIImage{
        let img = originalPhoto.getInRgb()
        let redAvg = originalPhoto.getAvarages().red
        let blueAvg = originalPhoto.getAvarages().blue
        let greenAvg = originalPhoto.getAvarages().green
        for y in 0..<img.height {
            for x in 0..<img.width {
                let index = y * img.width + x
                var pixel = img.pixels[index]
                
                let redDif = Int(pixel.red) - redAvg
                let blueDif = Int(pixel.blue) - blueAvg
                let greenDif = Int(pixel.green) - greenAvg
                
                pixel.red = UInt8( max(0, min(255, redAvg  + redDif + factor )))
                img.pixels[index] = pixel
                
                pixel.blue = UInt8( max(0, min(255, blueAvg + blueDif + factor)))
                img.pixels[index] = pixel
                
                pixel.green = UInt8( max(0, min(255, greenAvg + greenDif + factor)))
                img.pixels[index] = pixel
                
            }
        }
        
        return img.toUIImage()!
    }
    
    
    // changes the Alpha of the picture
    public func changeAlphaFactor(factor:Int) -> UIImage{
        let img = originalPhoto.getInRgb()
        for y in 0..<img.height{
            for x in 0..<img.width{
                let index = y * img.width + x
                var pixel = img.pixels[index]
                pixel.alpha = UInt8( max(0, min(255, factor)))
                img.pixels[index] = pixel
            }
        }
        return img.toUIImage()!
    }
    
    
    
    
    public func toImage() -> UIImage{
        let img = originalPhoto.getInRgb()
        return img.toUIImage()!
    }
    
    
    
    
    
    
    
}
