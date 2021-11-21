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
    
    @Published public var blockContent = ""
    
    func tagReaderSessionDidBecomeActive(_ session: NFCTagReaderSession) {
        NSLog("Session did become active")
    }
    
    func tagReaderSession(_ session: NFCTagReaderSession, didInvalidateWithError error: Error) {
        NSLog("Did invalidate with error")
    }
    
    func tagReaderSession(_ session: NFCTagReaderSession, didDetect tags: [NFCTag]) {
        NSLog("Did detect tags")
        if let firstTag = tags.first {
            if case let NFCTag.iso15693(tag) = firstTag {
                tag.readSingleBlock(requestFlags: [.highDataRate], blockNumber: 0, resultHandler: { result in
                    switch result {
                    case .success(let data):
                        print(data)
                        
                        let dataBytes = [UInt8](data)
                        
                        self.blockContent = dataBytes.map {
                            String(format: "%02hhx", $0)
                        }.joined()
                        
                        self.nfcSession?.invalidate()
                    case .failure(_):
                        NSLog("Somehow failed")
                    }
                })
            }
        }
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
