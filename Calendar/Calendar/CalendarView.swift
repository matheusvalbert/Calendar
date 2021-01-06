//
//  CalendarView.swift
//  Calendar
//
//  Created by Matheus Valbert on 01/01/21.
//

import SwiftUI

struct YearView: View {
    
    var year: Int
    
    var body: some View {
        
        HStack {
            Text(String(year))
                .font(.largeTitle)
            Spacer()
        }.padding()
    }
}

struct MonthView: View {
    
    var year: Int
    var month: Int
    var columns: [GridItem]
    
    let currentYear = Calendar.current.component(.year, from: Date())
    let currentMonth = Calendar.current.component(.month, from: Date())
    let currentDay = Calendar.current.component(.day, from: Date())
    
    var body: some View {
        
        LazyVGrid(
            columns: columns,
            alignment: .center,
            spacing: 30)
        {
            
            Section(header: Text(getMonth(month: month))
                        .bold()
                        .font(.title)
                        .padding(.bottom, -20))
            {
                
                ForEach(1...getNumDays(year: year, month: month), id: \.self) { day in
                    
                    if day == 1 {
                        
                        ForEach(1...getWeekDay(year: year, month: month, day: day), id: \.self) { weekDay in
                                
                            if weekDay != 1 {
                                Text("")
                            }
                        }
                    }
                    
                    if currentYear == year && currentMonth == month && currentDay == day {
                            
                        DayView(year: year, month: month, day: day, currentDay: true)
                    }
                    
                    else {
                        
                        DayView(year: year, month: month, day: day, currentDay: false)
                    }
                }
                .overlay(Rectangle().frame(width: 50, height: 1, alignment: .top)
                .foregroundColor(Color.gray), alignment: .top)
                .padding(.bottom, -5)
            }
        }.padding(.bottom, 30)
    }
}

struct DayView: View {
    
    @State var newEventView = false
    @State var event = false
    @State var eventText: String = ""
    @Environment(\.colorScheme) var colorScheme
    var year: Int
    var month: Int
    var day: Int
    var currentDay: Bool
    
    var body: some View {
        
        VStack {
        
            Button(action: {

                self.newEventView.toggle()
                print("Tapped Button Tag: \(year) \(month) \(day)")
                
            }, label: {
                
                Text(String(day))
                    .bold()
                
            })
            .frame(width: 35, height: 35)
            .background(currentDay == true ? Color.blue : nil)
            .cornerRadius(10)
            .clipShape(Circle())
            .padding(.top, 15)
            .foregroundColor(colorScheme == .light ? Color.black : Color.white)
            .sheet(isPresented: $newEventView, content: { NewEvent(showView: self.$newEventView, event: self.$event, eventText: self.$eventText) })
            
            Circle()
                .fill(event == true ? Color.gray : colorScheme == .dark ? Color.black : Color.white)
                .frame(width: 10, height: 10)
        }
    }
}

struct CalendarView: View {
    
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
    
    var body: some View {
        
        VStack {
            
            VStack {
            
                Text("Calendário")
                    .font(.largeTitle)
                    .foregroundColor(.blue)

            
                HStack {
                    
                    Text("S").padding()
                    Text("T").padding()
                    Text("Q").padding()
                    Text("Q").padding()
                    Text("S").padding()
                    Text("S").padding()
                    Text("D").padding()
                }
            }
        
            ScrollView {
            
                ForEach(currentYear...(currentYear + 1), id: \.self) { year in
                    
                    if currentYear == year {
                        YearView(year: year).foregroundColor(.blue)
                    }
                    else {
                        YearView(year: year)
                    }
                
                    ForEach(1...12, id: \.self) { month in
                        
                        if currentYear == year && currentMonth == month {
                            MonthView(year: year, month: month, columns: columns).foregroundColor(.blue)
                        }
                        else {
                            MonthView(year: year, month: month, columns: columns)
                        }
                    }
                }
            }
            
            HStack {}.padding(.bottom, 5)
        }
    }
}
