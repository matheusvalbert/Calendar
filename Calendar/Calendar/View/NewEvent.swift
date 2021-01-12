//
//  NewEvent.swift
//  Calendar
//
//  Created by Matheus Valbert on 03/01/21.
//

import SwiftUI
import CoreData

struct NewEvent: View {
    
    @ObservedObject var homeData : HomeViewModel
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @State var flag = false
    @Binding var newEventView: Bool
    @Binding var event : Bool
    @Binding var eventText: String
    var year: Int
    var month: Int
    var day: Int
    var fetchRequest: FetchRequest<Event>
    
    init(homeData: HomeViewModel, newEventView: Binding<Bool>, event: Binding<Bool>, eventText: Binding<String>, year: Int, month: Int, day: Int, fetchRequest: FetchRequest<Event>) {
        
        self.homeData = homeData
        self._newEventView = newEventView
        self._event = event
        self._eventText = eventText
        self.year = year
        self.month = month
        self.day = day
        self.fetchRequest = fetchRequest
    }
    
    var body: some View {
        
        NavigationView {
        
            VStack {
                
                MultiLineTF(txt: self.$eventText)
            }.navigationBarTitle("Eventos", displayMode: .inline)
            .toolbar {
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("OK", action:{
                        
                        if eventText != "" {
                            event = true
                            
                            for event in fetchRequest.wrappedValue {
                                event.content = eventText
                                flag = true
                            }
                            
                            if flag == false {
                                let newEvent = Event(context: viewContext)
                                newEvent.year = String(year)
                                newEvent.month = String(month)
                                newEvent.day = String(day)
                                newEvent.content = eventText
                            }
                            
                            flag = false
                        }
                        else {
                            event = false
                            for event in fetchRequest.wrappedValue {
                                viewContext.delete(event)
                            }
                        }
                        try! viewContext.save()
                        newEventView.toggle()
                    })
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                                    
                    Button("Cancelar", action: {
                        
                        newEventView.toggle()
                    })
                }
            }
        }
    }
}

struct MultiLineTF : UIViewRepresentable {
      
      
      func makeCoordinator() -> MultiLineTF.Coordinator {
          
          return MultiLineTF.Coordinator(parent1: self)
      }
      
      @Binding var txt : String
      
      func makeUIView(context: UIViewRepresentableContext<MultiLineTF>) -> UITextView {
          
          let view = UITextView()
          
          if self.txt != ""{
              
              view.text = self.txt
          }
          else{
              
              view.text = "Digite os eventos do dia..."
          }
          
          view.font = .systemFont(ofSize: 18)
          view.isEditable = true
          view.backgroundColor = .clear
          view.delegate = context.coordinator
          return view
      }
      
      func updateUIView(_ uiView: UITextView, context: UIViewRepresentableContext<MultiLineTF>) {
          
      }
      
      class Coordinator : NSObject,UITextViewDelegate{
          
          var parent : MultiLineTF
          
          init(parent1 : MultiLineTF) {
              
              parent = parent1
          }
          
          func textViewDidBeginEditing(_ textView: UITextView) {
              
              if self.parent.txt == ""{
                  
                  textView.text = ""
              }
          }
          
          func textViewDidChange(_ textView: UITextView) {
              
              self.parent.txt = textView.text
          }
      }
  }
