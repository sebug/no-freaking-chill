//
//  ContentView.swift
//  NoFreakingChill
//
//  Created by Sebastian Gfeller on 18.11.21.
//

import SwiftUI
import CoreNFC

struct ContentView: View {
    @ObservedObject var reader = NFCReader()
    
    var body: some View {
        VStack {
            Text("To scan your NFC tag, " +
            "push the button.")
                .padding()
            Button("Scan", action: scanAction)
        }
    }
    
    func scanAction() {
        reader.scan()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
