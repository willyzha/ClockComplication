//
//  ComplicationController.swift
//  ClockComplication WatchKit Extension
//
//  Created by Willy Zhang on 2017-06-04.
//  Copyright © 2017 Willy Zhang. All rights reserved.
//

import ClockKit


class ComplicationController: NSObject, CLKComplicationDataSource {
    
    // MARK: - Timeline Configuration
    
    func getSupportedTimeTravelDirections(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimeTravelDirections) -> Void) {
        handler([.forward, .backward])
    }
    
    func getTimelineStartDate(for complication: CLKComplication, withHandler handler: @escaping (Date?) -> Void) {
        let currentDate = Date.init()
        handler(currentDate)
    }
    
    func getTimelineEndDate(for complication: CLKComplication, withHandler handler: @escaping (Date?) -> Void) {
        let currentDate = Date.init()
        let endDate =
            currentDate.addingTimeInterval(TimeInterval(4 * 60 * 60)) // Temp refresh every 4 hours
        
        handler(endDate)
    }
    
    func getPrivacyBehavior(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationPrivacyBehavior) -> Void) {
        handler(.showOnLockScreen)
    }
    
    // MARK: - Timeline Population
    
    func getCurrentTimelineEntry(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimelineEntry?) -> Void) {
        // Call the handler with the current timeline entry
        
        if (complication.family == .utilitarianSmall) {
            print("SMALL FLAT TIMELINE")

            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "h:mm"
            
            let date = Date.init()
            
            let timeString = dateFormatter.string(from: date)
            
            let template = CLKComplicationTemplateUtilitarianSmallFlat()
            template.textProvider = CLKSimpleTextProvider(text: timeString)
            
            let entry = CLKComplicationTimelineEntry(date: date, complicationTemplate: template)
            
            handler(entry)
        } else {
            handler(nil)
        }
    }
    
    func getTimelineEntries(for complication: CLKComplication, before date: Date, limit: Int, withHandler handler: @escaping ([CLKComplicationTimelineEntry]?) -> Void) {
        // Call the handler with the timeline entries prior to the given date
        if (complication.family == .utilitarianSmall) {
            print("SMALL FLAT TIMELINE")
            
            var timeLineEntryArray = [CLKComplicationTimelineEntry]()
            let startTime = Date.init()
            let calendar = Calendar.current
            
            let seconds = calendar.component(.second, from: date)
            
            var nextTime = Date.init(timeInterval: Double(60-seconds), since: startTime)
            
            for _ in 0...240 {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "h:mm"
                
                let timeString = dateFormatter.string(from: nextTime)
                
                let template = CLKComplicationTemplateUtilitarianSmallFlat()
                template.textProvider = CLKSimpleTextProvider(text: timeString)
                
                let entry = CLKComplicationTimelineEntry(date: date, complicationTemplate: template)
                
                timeLineEntryArray.append(entry)
                
                nextTime = nextTime.addingTimeInterval(60)
            }
            
            handler(timeLineEntryArray)
        } else {
            handler(nil)
        }
    }
    
    func getTimelineEntries(for complication: CLKComplication, after date: Date, limit: Int, withHandler handler: @escaping ([CLKComplicationTimelineEntry]?) -> Void) {
        
        print(complication.family)
        
        // Call the handler with the timeline entries after to the given date
        if (complication.family == .utilitarianSmall) {
            print("SMALL FLAT TIMELINE")
            
            var timeLineEntryArray = [CLKComplicationTimelineEntry]()
            
            let calendar = Calendar.current
            
            let startTime = Date.init()
            let seconds = calendar.component(.second, from: startTime)
            var nextTime = Date.init(timeInterval: Double(60-seconds), since: startTime)
            
            for _ in 1...240 {
                
                print(nextTime)
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "h:mm"
                
                let timeString = dateFormatter.string(from: nextTime)
                
                let template = CLKComplicationTemplateUtilitarianSmallFlat()
                template.textProvider = CLKSimpleTextProvider(text: timeString)
                
                let entry = CLKComplicationTimelineEntry(date: nextTime.addingTimeInterval(-2), complicationTemplate: template)
                
                timeLineEntryArray.append(entry)
                
                nextTime = nextTime.addingTimeInterval(60)
            }
            
            handler(timeLineEntryArray)
        } else {
            handler(nil)
        }
    }
    
    // MARK: - Placeholder Templates
    
    func getLocalizableSampleTemplate(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTemplate?) -> Void) {
        // This method will be called once per supported complication, and the results will be cached
        
        print(complication.family.rawValue)
        
        if (complication.family == CLKComplicationFamily.utilitarianSmall) {
            print("Small Flat")
        
            let template = CLKComplicationTemplateUtilitarianSmallFlat()
        
            let textProvider = CLKTimeTextProvider(date: NSDate() as Date, timeZone: NSTimeZone.system)
        
            template.textProvider = textProvider
            
            handler(template)
        } else {
            handler(nil)
        }
        
        
        
    }
    
}
