//
//  CalendarDay.swift
//  Calendar
//
//  Created by Matheus Valbert on 04/01/21.
//

import SwiftUI

class HomeViewModel : ObservableObject{
    
    var columns: [GridItem] = [
    
        GridItem(.fixed(40), spacing: 10),
        GridItem(.fixed(40), spacing: 10),
        GridItem(.fixed(40), spacing: 10),
        GridItem(.fixed(40), spacing: 10),
        GridItem(.fixed(40), spacing: 10),
        GridItem(.fixed(40), spacing: 10),
        GridItem(.fixed(40), spacing: 10)
    ]
    
    let currentYear = Calendar.current.component(.year, from: Date())
    let currentMonth = Calendar.current.component(.month, from: Date())
    let currentDay = Calendar.current.component(.day, from: Date())

    func getNumDays(year: Int, month: Int) -> Int {
        
        let dateComponents = DateComponents(year: year, month: month)
        let calendar = Calendar.current
        let date = calendar.date(from: dateComponents)!

        let range = calendar.range(of: .day, in: .month, for: date)!
        let numDays = range.count
        return numDays
    }

    func getMonth(month: Int) -> String {
        
        switch month {
            
            case 1:
                return "Janeiro"
            case 2:
                return "Fevereiro"
            case 3:
                return "Março"
            case 4:
                return "Abril"
            case 5:
                return "Maio"
            case 6:
                return "Junho"
            case 7:
                return "Julho"
            case 8:
                return "Agosto"
            case 9:
                return "Setembro"
            case 10:
                return "Outubro"
            case 11:
                return "Novembro"
            case 12:
                return "Dezembro"
            default:
                return "Este mês está errado!"
        }
    }

    func getWeekDay(year: Int, month: Int, day: Int) -> Int {
        
        let date = String(year) + "-" + String(month) + "-" + String(day)
        
        let formatter  = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        guard let todayDate = formatter.date(from: date) else { return 0 }
        let myCalendar = Calendar(identifier: .gregorian)
        let weekDay = myCalendar.component(.weekday, from: todayDate)
        if weekDay == 1 {
            return 7
        }
        else {
            return weekDay - 1
        }
    }

    func getFetch(year: Int, month: Int, day: Int) -> FetchRequest<Event> {
        
        print(year)
        var fetchRequest: FetchRequest<Event>
        
        fetchRequest = FetchRequest<Event>(entity: Event.entity(), sortDescriptors: [], predicate: NSPredicate(format: "year == %@", "2021"))
        
        print(fetchRequest)
        
        return fetchRequest
    }
}
