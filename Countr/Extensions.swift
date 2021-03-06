//
//  Extensions.swift
//  Countr
//
//  Created by Lukas Kollmer on 1/30/15.
//  Copyright (c) 2015 Lukas Kollmer. All rights reserved.
//

import Foundation
import UIKit


//
// Cell identification
//

var countdown_cell_tag = 0

let purchase_cell_tag = 1


//
// WatchKit Host App integration
//

let wk_action_key = "wk_action"
let wk_item_id_key = "wk_item_id"
let wk_action_addNewItem_key = "wk_action_addNewItem"
let wk_action_deleteItem_key = "wk_action_deleteItem"


//
// Google Analytics strings
//

// UI
let ui_action_key = "ui_action"
let select_collection_view_cell_short_press_key = "select_collection_view_cell_short_press"
let select_collection_view_cell_long_press_key = "select_collection_view_cell_long_press"
let button_press_key = "button_press"
let add_new_item_button_key = "add_new_item_button"
let cancel_button_key = "cancel_save_item_button"
let done_button_key = "done_info_view_button"
let show_website_key = "show_website"
let write_email_key = "write_email"
let delete_all_data_button_key = "delete_all_data_button"

//iAd
let did_display_ad_key = "did_display_ad"
let did_fail_to_display_ad_key = "did_fail_to_display_ad"
let did_tap_on_ad_key = "did_tap_on_ad"

// CountdownManager
let ad_key = "ad"
let countdown_manager_key = "countdown_manager"
let did_add_new_item_key = "did_add_new_item"
let did_delete_item_key = "did_delete_item"
let did_delete_item_from_detail_view_controller_key = "did_delete_item_from_detail_view_controller"

// Purchase Manager
let purchase_manager_key = "purchase_manager"
let purchase_manager_load_products_key = "purchase_manager_load_products"
let purchase_Manager_did_finish_purchase_key = "purchase_Manager_did_finish_purchase"
let purchase_manager_did_purchase_key = "purchase_manager_did_purchase"
let purchase_manager_did_restore_key = "purchase_manager_did_restore"
let purchase_manager_did_cancel_key = "purchase_manager_did_cancel"


// Notifications
let notification_userInfo_item_id_key = "notification_userInfo_item_id"
let notification_userInfo_item_name_key = "notification_userInfo_item_name"


// MARK: Appearance


extension UINavigationBar {
    func setDarkAttributes() {



        // Bar Style
        self.barStyle = .Black

        // Title Text Attributes
        let font = UIFont.systemFontOfSize(17)
        let _titleTextAttributes: [String : AnyObject] = [NSFontAttributeName: font, NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.titleTextAttributes = _titleTextAttributes

        // Tint Color
        self.tintColor = UIColor.whiteColor()
    }
}

// MARK: Getting class names

//public func nameOfClass(_class: AnyObject) -> String {
//    return _stdlib_getDemangledTypeName(_class)
//}

// MARK: Int, Double, Float: Positive Value

extension Int {
    var positive: Int {
        return abs(self)
    }
}

extension Double {
    var positive: Double {
        return abs(self)
    }
}

extension Float {
    var positive: Float {
        return abs(self)
    }
}

/**
Add multiple actions at once to UIAlertController
*/
extension UIAlertController {
    func addActions(actions: [UIAlertAction]) {
        for action in actions {
            self.addAction(action)
        }
    }
    
    func showCancelButtonOniPhone(value: Bool) {
        if value == true {
            let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) -> Void in
                self.dismissViewControllerAnimated(true, completion: nil)
            }
            self.addAction(cancelAction)
        }
    }
    
    class func alert(title: String) {
        let viewController = UIViewController.topmost()
        let alertController = UIAlertController(title: title, message: nil, preferredStyle: .Alert)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: { (action) -> Void in
            alertController.dismissViewControllerAnimated(true, completion: nil)
        }))
        
        viewController.presentViewController(alertController, animated: true, completion: nil)
    }
}


/**
Extends Int to support getting strings with a certain number of leading integer digits
*/
extension Int {

    /**
    Convert the Int to a String with a specified number of leading integer digits

    Example: ``5.toStringWithNumberOfLeadingDigits(2)`` would be 05

    - parameter leadingDigits: An Int representing the number of leading integers you wish to be added
    */
    func toStringWithNumberOfLeadingDigits(leadingDigits: Int) -> String? {
        let numberFormatter = NSNumberFormatter()

        numberFormatter.minimumIntegerDigits = leadingDigits

        let number = NSNumber(integer: self)

        return numberFormatter.stringFromNumber(number)

    }

}

// MARK: NSAttributedString

extension NSAttributedString {
    class func attributedStringWithString(string: String, font: UIFont) -> NSAttributedString {
        return NSAttributedString(string: string, attributes: [NSFontAttributeName : font])
    }
}

// MARK: UIColor

extension UIColor {
    class func backgroundColor() -> UIColor {
        return UIColor(rgba: "#232323")
    }

    class func foregroundColor() -> UIColor {
        return UIColor(rgba: "#252525") // alternative: #1C1C1C (much darker!😱)
    }

    class func borderColor() -> UIColor {
        return UIColor(rgba: "#292929")
    }

    convenience init(rgba: String) {
        var red:   CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue:  CGFloat = 0.0
        var alpha: CGFloat = 1.0

        if rgba.hasPrefix("#") {
            let index   = rgba.startIndex.advancedBy(1)
            let hex     = rgba.substringFromIndex(index)
            let scanner = NSScanner(string: hex)
            var hexValue: CUnsignedLongLong = 0
            if scanner.scanHexLongLong(&hexValue) {
                switch (hex.characters.count) {
                case 3:
                    red   = CGFloat((hexValue & 0xF00) >> 8)       / 15.0
                    green = CGFloat((hexValue & 0x0F0) >> 4)       / 15.0
                    blue  = CGFloat(hexValue & 0x00F)              / 15.0
                case 4:
                    red   = CGFloat((hexValue & 0xF000) >> 12)     / 15.0
                    green = CGFloat((hexValue & 0x0F00) >> 8)      / 15.0
                    blue  = CGFloat((hexValue & 0x00F0) >> 4)      / 15.0
                    alpha = CGFloat(hexValue & 0x000F)             / 15.0
                case 6:
                    red   = CGFloat((hexValue & 0xFF0000) >> 16)   / 255.0
                    green = CGFloat((hexValue & 0x00FF00) >> 8)    / 255.0
                    blue  = CGFloat(hexValue & 0x0000FF)           / 255.0
                case 8:
                    red   = CGFloat((hexValue & 0xFF000000) >> 24) / 255.0
                    green = CGFloat((hexValue & 0x00FF0000) >> 16) / 255.0
                    blue  = CGFloat((hexValue & 0x0000FF00) >> 8)  / 255.0
                    alpha = CGFloat(hexValue & 0x000000FF)         / 255.0
                default:
                    print("Invalid RGB string, number of characters after '#' should be either 3, 4, 6 or 8", terminator: "")
                }
            } else {
                print("Scan hex error")
            }
        } else {
            print("Invalid RGB string, missing '#' as prefix", terminator: "")
        }
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
}

// MARK: UIApplication

extension UIDevice {
    var is12HourFormat: Bool { // This shit works
        get {
            let formatStringForHours: NSString = NSDateFormatter.dateFormatFromTemplate("j", options: 0, locale: NSLocale.currentLocale())!
            let formatStringForHoursAsNSString: NSString = NSString(string: formatStringForHours)
            let containsA: NSRange = formatStringForHoursAsNSString.rangeOfString("a")
            let has12HourFormat = containsA.location != NSNotFound
            return has12HourFormat
        }
    }
}

// MARK: Array
extension Array {
    func subarrayToIndex(index: Int) -> Array {
        if index > self.count {
            return self
        }
        return Array(self[0...index-1])
    }
}

// MARK: NSDate

extension NSDate {

    class func dateFromDatePicker(datePicker: UIDatePicker) -> NSDate {
        let dateComponents = NSDateComponents()

        dateComponents.year = datePicker.date.year
        dateComponents.month = datePicker.date.month
        dateComponents.day = datePicker.date.day
        dateComponents.hour = datePicker.date.hour
        dateComponents.minute = datePicker.date.minute
        dateComponents.second = 0
        dateComponents.nanosecond = 0

        if datePicker.datePickerMode == .Date {

            // Reset all values for datePickerMode .Date (hour, minute, second, nanosecond)
            dateComponents.hour = 0
            dateComponents.minute = 0
            dateComponents.second = 0
            dateComponents.nanosecond = 0

        }

        return NSCalendar.currentCalendar().dateFromComponents(dateComponents)!

    }

    func dateByAddingMinutes(minutes: Int) -> NSDate {
        let seconds: NSTimeInterval = Double(minutes) * 60
        return self.dateByAddingTimeInterval(seconds)
    }

    var isToday: Bool {
        let calendar = NSCalendar.currentCalendar()
        let unitFlags: NSCalendarUnit =  [.Era, .Year, .Month, .Day]
        var dateComponents = calendar.components(unitFlags, fromDate: NSDate())
        let today = calendar.dateFromComponents(dateComponents)!
        dateComponents = calendar.components(unitFlags, fromDate: self)
        let referenceDate = calendar.dateFromComponents(dateComponents)!

        return today.isEqualToDate(referenceDate)
    }

    var isPast: Bool {
        return self.timeIntervalSinceNow < 0.0
    }

    var descriptiveString: String {
        return NSDateFormatter.localizedStringFromDate(self, dateStyle: NSDateFormatterStyle.ShortStyle, timeStyle: NSDateFormatterStyle.ShortStyle)
    }

    var descriptiveStringForDatePicker: String {
        get {
            var fullDateString :String
            var dayString: String
            var monthString: String
            var dayNumberString: String
            let formatter = NSDateFormatter()


            formatter.dateFormat = "EE" // "Fri"
            dayString = formatter.stringFromDate(self)

            formatter.dateFormat = "MMM" // "Jan"
            monthString = formatter.stringFromDate(self)

            formatter.dateFormat = "d"
            dayNumberString = formatter.stringFromDate(self)

            fullDateString = "\(dayString) \(monthString) \(dayNumberString)"
            return fullDateString
        }
    }

    var dayInYear: Int {
        get {
            return NSCalendar.currentCalendar().ordinalityOfUnit(NSCalendarUnit.Day, inUnit: NSCalendarUnit.Year, forDate: self)
        }
    }

    var year: Int {
        return self.dateComponents.year
    }
    var month: Int {
        return self.dateComponents.month
    }

    var day: Int {
        return self.dateComponents.day
    }

    var hour: Int {
        return self.dateComponents.hour
    }

    var minute: Int {
        return self.dateComponents.minute
    }

    var second: Int {
        return self.dateComponents.second
    }

    var nanosecond: Int {
        return self.dateComponents.nanosecond
    }



    private var dateComponents: NSDateComponents {
        get {
            let calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
            let calendarUnits: NSCalendarUnit = ([NSCalendarUnit.Year, .Month, .Day, .Hour, .Minute, .Second])


            let dateComponents = calendar?.components( calendarUnits, fromDate: self)

            return dateComponents!
        }
    }


}
