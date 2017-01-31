//
//  ViewController.swift
//  Chatter
//
//  Created by Harman on 31/01/17.
//  Copyright © 2017 Harman. All rights reserved.
//

import UIKit
import Intents

extension String{
    var toNS: NSString{
        get{
            return (self as NSString)
        }
    }
}

class ViewController: UIViewController {
    var to = ""
    var content = ""
    @IBOutlet weak var contentArea: UITextView!
    @IBOutlet weak var toLabel: UITextField!
    @IBOutlet weak var label: UILabel!
    let wormhole = MMWormhole(applicationGroupIdentifier: "group.amadeus.wormhole.example", optionalDirectory: "chatter")

    override func viewDidLoad() {
        super.viewDidLoad()
        INPreferences.requestSiriAuthorization {(a) in
            
        }
        // Do any additional setup after loading the view, typically from a nib.{
        wormhole.listenForMessage(withIdentifier: "numberClicked"){(result) in
            if let finalResult = result{
                self.display(result: (finalResult as! String))
            }
        }
        
        toLabel.text = to
        contentArea.text = content
    }

    func display(result: String){
        label.text = "Label: \(result)"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        wormhole.listenForMessage(withIdentifier: "tomsg") { (res) in
            if let message = res{
                self.to = message as! String
            }
        }
        
        wormhole.listenForMessage(withIdentifier: "contentmsg") { (res) in
            if let message = res{
                self.content = message as! String
            }
        }
        self.viewDidLoad()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btn1(_ sender: UIButton) {
        wormhole.passMessageObject("1".toNS, identifier: "numberClicked")
    }

    @IBAction func btn2(_ sender: UIButton) {
        wormhole.passMessageObject("2".toNS, identifier: "numberClicked")
    }
}

