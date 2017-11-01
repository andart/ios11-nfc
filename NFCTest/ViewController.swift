//
//  ViewController.swift
//  NFCTest
//
//  Created by Andrey Artemenko on 01/11/2017.
//  Copyright © 2017 NFCTest. All rights reserved.
//

import UIKit
import CoreNFC

class ViewController: UIViewController {
    
    @IBOutlet weak var button: UIButton!
    private var rfidSession: NFCISO15693ReaderSession!
    private var rfidTags: [[NFCISO15693Tag]] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        rfidSession = NFCISO15693ReaderSession(delegate: self, queue: nil)
        rfidSession.alertMessage = "Чтобы прочитать метку, поместите iPhone над ней"
        
        button.layer.cornerRadius = 24
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.white.cgColor
        button.setTitle("Считать метку", for: .normal)
        button.setTitleColor(.white, for: .normal)
        
        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.startPoint = CGPoint(x: 0, y: 1)
        gradient.startPoint = CGPoint(x: 1, y: 0)
        gradient.colors = [UIColor.red.cgColor, UIColor.orange.cgColor, UIColor.yellow.cgColor]
        
        view.layer.insertSublayer(gradient, at: 0)
    }

    @IBAction func buttonAction(_ sender: UIButton) {
        rfidSession.begin()
    }
    
    fileprivate func showAlert(_ message: String) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
}

extension ViewController: NFCReaderSessionDelegate {
    
    public func readerSessionDidBecomeActive(_ session: NFCReaderSession) {
        
    }
    
    public func readerSession(_ session: NFCReaderSession, didDetect tags: [NFCTag]) {
        let rfidTag = tags.first as! NFCISO15693Tag
        
        let s = "- Is available: \(rfidTag.isAvailable)\n" + "- Type: \(rfidTag.type) \n" + "- IC Manufacturer Code: \(rfidTag.icManufacturerCode) \n" + "- IC Serial Number: \(rfidTag.icSerialNumber) \n" + "- Identifier: \(rfidTag.identifier)";
        
        DispatchQueue.main.async {
            self.showAlert(s)
        }
    }
    
    public func readerSession(_ session: NFCReaderSession, didInvalidateWithError error: Error) {
        
    }
    
}

