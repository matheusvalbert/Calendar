//
//  year.swift
//  Calendar
//
//  Created by Matheus Valbert on 11/01/21.
//

import SwiftUI

struct Year: View {
    
    var year: Int
    
    var body: some View {
        
        HStack {
            Text(String(year))
                .font(.largeTitle)
            Spacer()
        }.padding()
    }
}
