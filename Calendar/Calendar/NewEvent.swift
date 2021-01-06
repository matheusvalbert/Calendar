//
//  NewEvent.swift
//  Calendar
//
//  Created by Matheus Valbert on 03/01/21.
//

import SwiftUI

struct NewEvent: View {
    
    @Binding var showView : Bool
    @Binding var event : Bool
    @Binding var eventText: String
    @State var txt : String = ""
    
    var body: some View {
        
        NavigationView {
        
            VStack {
                
                MultiLineTF(txt: self.$eventText)
            }
            .navigationBarItems(trailing: Button("OK", action:{
                
                if eventText != "" {
                    
                    event = true
                }
                else {
                    event = false
                }
                self.showView.toggle()
            }))
            .navigationBarTitle("Eventos", displayMode: .inline)
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
