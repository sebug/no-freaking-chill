//
//  NFCReader.swift
//  NoFreakingChill
//
//  Created by Sebastian Gfeller on 18.11.21.
//

import Foundation
import SwiftUI
import CoreNFC

class NFCReader : NSObject, NFCNDEFReaderSessionDelegate, ObservableObject {
    func scan() -> String? {
        guard NFCNDEFReaderSession.readingAvailable else {
            return "Scanning not supported"
        }
        let session = NFCNDEFReaderSession(delegate: self, queue: DispatchQueue.main,
        invalidateAfterFirstRead: false)
        session.alertMessage = "Scan your card, will ya?";
        session.begin()
        return nil
    }
    
    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
        // Error handling
        NSLog("Nope, that did not work")
    }
    
    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
        // Handle received messages
        NSLog("Messages received")
    }
    
    func readerSessionDidBecomeActive(_ session: NFCNDEFReaderSession) {
        NSLog("Reader session did become active")
    }
}
