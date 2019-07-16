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
import SwiftyJSON

class ViewController: UIViewController {
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var sentimentLabel: UILabel!

    let sentimentClassifier = TweetSentimentClassifier()
    
    let swifter = Swifter(consumerKey: valueForAPIKey(named: "TWITTER_CONSUMER_KEY"), consumerSecret: valueForAPIKey(named: "TWITTER_CONSUMER_SECRET"))
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func predictPressed(_ sender: Any) {
    
        if let searchText = textField.text {
            swifter.searchTweet(using: "@Apple", lang: "en", count: 100, tweetMode: .extended, success: { (results, metadata) in
                
                var tweets = [TweetSentimentClassifierInput]()
                
                for index in 0..<100 {
                    
                    if let tweet = results[index]["full_text"].string {
                        let convertedTweet = TweetSentimentClassifierInput(text: tweet)
                        tweets.append(convertedTweet)
                    }
                    
                }
                
                do {
                    
                    let predictions = try self.sentimentClassifier.predictions(inputs: tweets)
                    
                    var sentimentScore = 0
                    
                    for prediction in predictions {
                        
                        let sentiment = prediction.label
                        
                        if sentiment == "Pos" {
                            sentimentScore += 1
                        }
                        else if sentiment == "Neg" {
                            sentimentScore -= 1
                        }
                        
                    }
                    print(sentimentScore)
                }
                catch {
                    print("There was an error making a prediction, \(error)")
                }
                
                
            }) { (error) in
                print("There was an error with Twitter API request, \(error)")
            }
        }
        
    }
    
}

