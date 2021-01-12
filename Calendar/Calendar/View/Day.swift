//
//  Day.swift
//  Calendar
//
//  Created by Matheus Valbert on 11/01/21.
//

import SwiftUI
import CoreData

struct Day: View {
    
    @ObservedObject var homeData : HomeViewModel
    @State var newEventView = false
    @State var event = false
    @State var eventText: String = ""
    @Environment(\.colorScheme) var colorScheme
    var year: Int
    var month: Int
    var day: Int
    var currentDay: Bool
    var fetchRequest: FetchRequest<Event>
    
    init(homeData: HomeViewModel, year: Int, month: Int, day: Int, currentDay: Bool) {
        
        self.homeData = homeData
        self.year = year
        self.month = month
        self.day = day
        self.currentDay = currentDay
        fetchRequest = FetchRequest<Event>(entity: Event.entity(), sortDescriptors: [], predicate: NSPredicate(format: "year == %@ && month == %@ && day == %@", String(year), String(month), String(day)))
    }
    
    var body: some View {
        
        VStack {
        
            Button(action: {

                newEventView.toggle()
                
            }, label: {
                
                Text(String(day))
                    .bold()
                
            })
            .frame(width: 35, height: 35)
            .background(currentDay == true ? Color.blue : nil)
            .cornerRadius(10)
            .clipShape(Circle())
            .padding(.top, 15)
            .foregroundColor(currentDay == true ? Color.white : colorScheme == .light ? Color.black : Color.white)
            .sheet(isPresented: $newEventView, content: { NewEvent(homeData: homeData, newEventView: $newEventView, event: self.$event, eventText: self.$eventText, year: year, month: month, day: day, fetchRequest: fetchRequest) })
            
            Circle()
                .fill(event == true ? Color.gray : colorScheme == .dark ? Color.black : Color.white)
                .frame(width: 10, height: 10)
                .onAppear(perform: {
                    for event in fetchRequest.wrappedValue {
                        eventText = event.wrappedContent
                        self.event = true
                    }
                })
        }
    }
}
