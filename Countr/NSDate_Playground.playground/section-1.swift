// Playground - noun: a place where people can play

import UIKit

// UIFonts
let fontFamilies: [String] = UIFont.familyNames() as! [String]

var fontNamesForFamilyName: [String: AnyObject] = Dictionary()

for familyName: String in fontFamilies {
    fontNamesForFamilyName[familyName] = UIFont.fontNamesForFamilyName(familyName)
}


// App version
//UIApplication.sharedApplication().version

// Day in year
NSCalendar.currentCalendar().ordinalityOfUnit(NSCalendarUnit.DayCalendarUnit, inUnit: NSCalendarUnit.YearCalendarUnit, forDate: NSDate())

var formattedDate: String




let dateFormatter = NSDateFormatter()

dateFormatter.dateFormat = "EE"

formattedDate = dateFormatter.stringFromDate(NSDate())

dateFormatter.dateFormat = "MMM"

formattedDate = dateFormatter.stringFromDate(NSDate())

dateFormatter.dateFormat = "d"

formattedDate = dateFormatter.stringFromDate(NSDate())

dateFormatter.dateFormat = "a"

formattedDate = dateFormatter.stringFromDate(NSDate())




let date = NSDate()
var fullDateString :String
var dayString: String
var monthString: String
var dayNumberString: String
let formatter = NSDateFormatter()


formatter.dateFormat = "EE" // "Fri"
dayString = formatter.stringFromDate(date)

formatter.dateFormat = "MMM" // "Jan"
monthString = formatter.stringFromDate(date)

formatter.dateFormat = "d"
dayNumberString = formatter.stringFromDate(date)

fullDateString = "\(dayString) \(monthString) \(dayNumberString)"


var dates: [NSDate] = []

let testDate = NSDate()
let dateComponents = NSDateComponents()
let calendar = NSCalendar.currentCalendar()
dateComponents.day = 1

for index in 1...10 {
    let _date = calendar.dateByAddingUnit(.CalendarUnitDay, value: -index, toDate: NSDate(), options: nil)!
    dates.append(_date)
}


let _dateComponents = NSCalendar.currentCalendar().components(NSCalendarUnit.CalendarUnitHour|NSCalendarUnit.CalendarUnitMinute|NSCalendarUnit.CalendarUnitDay|NSCalendarUnit.CalendarUnitMonth|NSCalendarUnit.CalendarUnitYear, fromDate: NSDate())

////println("\(dateComponents.hour)
