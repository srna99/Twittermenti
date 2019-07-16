//
//  ViewController.swift
//  Twittermenti
//
//  Created by Angela Yu on 17/07/2018.
//  Copyright © 2018 London App Brewery. All rights reserved.
//

import UIKit
import SwifteriOS
import CoreML

class ViewController: UIViewController {
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var sentimentLabel: UILabel!

    let sentimentClassifier = TweetSentimentClassifier()
    
    let swifter = Swifter(consumerKey: valueForAPIKey(named: "TWITTER_CONSUMER_KEY"), consumerSecret: valueForAPIKey(named: "TWITTER_CONSUMER_SECRET"))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        swifter.searchTweet(using: "@Apple", lang: "en", count: 100, tweetMode: .extended, success: { (results, metadata) in
            
            print(results)
            
        }) { (error) in
            print("There was an error with Twitter API request, \(error)")
        }
        
    }

    @IBAction func predictPressed(_ sender: Any) {
    
    
    }
    
}

