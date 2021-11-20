//
//  NFCReader.swift
//  NoFreakingChill
//
//  Created by Sebastian Gfeller on 18.11.21.
//

import Foundation
import CoreNFC

class NFCReader : NSObject, NFCNDEFReaderSessionDelegate, ObservableObject {
    func scan() {
        let session = NFCNDEFReaderSession(delegate: self, queue: DispatchQueue.main,
        invalidateAfterFirstRead: false)
        session.alertMessage = "Scan your card, will ya?";
        session.begin()
    }
    
    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
        // Error handling
    }
    
    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
        // Handle received messages
    }
}
