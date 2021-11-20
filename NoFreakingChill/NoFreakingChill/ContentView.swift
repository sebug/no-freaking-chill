//
//  ContentView.swift
//  NoFreakingChill
//
//  Created by Sebastian Gfeller on 18.11.21.
//

import SwiftUI
import CoreNFC

struct Message: Identifiable {
    let id = UUID()
    let text: String
}

struct ContentView: View {
    @ObservedObject var reader = NFCReader()
    
    @State private var message: Message? = nil;
    
    var body: some View {
        VStack {
            Text("To scan your NFC tag, " +
            "push the button.")
                .padding()
            Button("Scan", action: scanAction)
        }.alert(item: $message) { message in
            Alert(
                title: Text(message.text),
                dismissButton: .cancel())
        }
    }
    
    func scanAction() {
        let resultingString = reader.scan()
        
        if let errorMessage = resultingString {
            self.message = Message(text: errorMessage)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
