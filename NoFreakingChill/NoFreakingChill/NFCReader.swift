//
//  NFCReader.swift
//  NoFreakingChill
//
//  Created by Sebastian Gfeller on 18.11.21.
//

import Foundation
import SwiftUI
import CoreNFC

class NFCReader : NSObject, NFCTagReaderSessionDelegate, ObservableObject {
    private var nfcSession: NFCTagReaderSession?
    
    func tagReaderSessionDidBecomeActive(_ session: NFCTagReaderSession) {
        NSLog("Session did become active")
    }
    
    func tagReaderSession(_ session: NFCTagReaderSession, didInvalidateWithError error: Error) {
        NSLog("Did invalidate with error")
    }
    
    func tagReaderSession(_ session: NFCTagReaderSession, didDetect tags: [NFCTag]) {
        NSLog("Did detect tags")
    }
    
    func scan() -> String? {
        guard NFCTagReaderSession.readingAvailable else {
            return "Scanning not supported"
        }
        nfcSession = NFCTagReaderSession(pollingOption: NFCTagReaderSession.PollingOption.iso15693, delegate: self, queue: DispatchQueue.main)
        nfcSession?.alertMessage = "Scan your card, will ya?";
        nfcSession?.begin()
        return nil
    }
    
    func stopScan() {
        nfcSession?.invalidate()
    }
}
