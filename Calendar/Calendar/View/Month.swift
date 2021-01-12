//
//  Month.swift
//  Calendar
//
//  Created by Matheus Valbert on 11/01/21.
//

import SwiftUI

struct Month: View {
    
    @ObservedObject var homeData : HomeViewModel
    
    var year: Int
    var month: Int
    
    var body: some View {
        
        LazyVGrid(columns: homeData.columns, alignment: .center, spacing: 30) {
            
            Section(header: Text(homeData.getMonth(month: month))
                        .bold()
                        .font(.title)
                        .padding(.bottom, -20))
            {
                
                ForEach(1...homeData.getNumDays(year: year, month: month), id: \.self) { day in
                    
                    if day == 1 {
                        
                        ForEach(1...homeData.getWeekDay(year: year, month: month, day: day), id: \.self) { weekDay in
                                
                            if weekDay != 1 {
                                Text("")
                            }
                        }
                    }
                    
                    if homeData.currentYear == year && homeData.currentMonth == month && homeData.currentDay == day {
                        
                        Day(homeData: homeData, year: year, month: month, day: day, currentDay: true)
                    }
                    
                    else {
                        
                        Day(homeData: homeData, year: year, month: month, day: day, currentDay: false)
                    }
                }
                .overlay(Rectangle().frame(width: 50, height: 1, alignment: .top)
                .foregroundColor(Color.gray), alignment: .top)
                .padding(.bottom, -5)
            }
        }.padding(.bottom, 30)
    }
}
