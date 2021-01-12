//
//  ContentView.swift
//  Calendar
//
//  Created by Matheus Valbert on 10/01/21.
//

import SwiftUI

struct Home: View {
    
    @StateObject var homeData = HomeViewModel()
    
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
            
                ForEach(homeData.currentYear...(homeData.currentYear + 1), id: \.self) { year in
                    
                    if homeData.currentYear == year {
                        Year(year: year).foregroundColor(.blue)
                    }
                    else {
                        Year(year: year)
                    }
                
                    ForEach(1...12, id: \.self) { month in
                        
                        if homeData.currentYear == year && homeData.currentMonth == month {
                            Month(homeData: homeData, year: year, month: month).foregroundColor(.blue)
                        }
                        else {
                            Month(homeData: homeData, year: year, month: month)
                        }
                    }
                }
            }
        }
    }
}
