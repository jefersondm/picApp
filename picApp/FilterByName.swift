import Foundation
import UIKit

//Interface created in regards to the last review criteria
//this protocol is used only in the filters class
protocol filterByName {
    func applyFilter(name:String) -> UIImage
}
