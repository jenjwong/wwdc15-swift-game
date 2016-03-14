//
//  ViewController.swift
//  Jenjwong
//
//  Created by Jen Wong on 4/20/15.
//  Copyright (c) 2015 Jen Wong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    
    var currentValue = 50
    var targetValue = 0
    var score = 0
    var round = 0
    
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    
    
    @IBAction func startOver() {
        startNewGame()
        updateLabels() }
    
    
    func startNewRound() {
        targetValue = 1 + Int(arc4random_uniform(100))
        slider.value = Float(currentValue)
        round += 1
    }
    
    func startNewGame() {
        score = 0
        round = 0
        startNewRound()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startNewGame()
        updateLabels()
        
        let thumbImageNormal = UIImage(named: "SliderThumb-Normal")
        slider.setThumbImage(thumbImageNormal, forState: .Normal)
        let thumbImageHighlighted = UIImage(named: "SliderThumb-Highlighted")
        slider.setThumbImage(thumbImageHighlighted, forState: .Highlighted)
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        if let trackLeftImage = UIImage(named: "SliderTrackLeft") {
            let trackLeftResizable =
            trackLeftImage.resizableImageWithCapInsets(insets)
            slider.setMinimumTrackImage(trackLeftResizable, forState: .Normal)
        }
        if let trackRightImage = UIImage(named: "SliderTrackRight") {
            let trackRightResizable = trackRightImage.resizableImageWithCapInsets(insets)
            slider.setMaximumTrackImage(trackRightResizable, forState: .Normal) }
        
        // images to slider
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // get rid of resources that can be recreated.
    }
    
    
    @IBAction func showAlert() {
        let difference = abs(targetValue - currentValue)
        var points = 100 - difference
        
        
        let message = "\nYou guessed: \(currentValue)" + "\n\nWouldn't be so homeless if you'd guessed: \(targetValue)"
        var title: String
        if difference == 0 {
            title = "#winning! you have achieved the impossible... likely through bribes. "
            points += 100
            
        } else if difference < 6 {
            title = "we really like you! you're a unicorn...it's just that you have a brass ring..."
            points += 50
            
            
        } else if difference < 11 {
            title = "we really like you! you're a unicorn... it's just that we were really looking for a unicorn with a bass ring..."
            points += 50
            
        } else if difference < 13 {
            title = "oh hi, come in! meet the gazillion other desperate appartment hunters... I thought I could save time by having you all over at once!"
            points += 50
            
        } else if difference < 17 {
            title = "you thought fresh baked cookies would seal the deal...ha! are you from the mid-west?!"
        } else {
            title = "you thought your credit score and impecable references meant something?! ha! try your luck in the east bay!"
            
        }
        score += points
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        let action = UIAlertAction(title: "Play Again!", style: .Default,
            handler: { action in
                self.startNewRound()
                self.updateLabels()
        })
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
        
    }
    @IBAction func sliderMoved(slider: UISlider) {
        currentValue = lroundf(slider.value)
        
    }
    
    func updateLabels() {
        targetLabel.text = String(targetValue)
        scoreLabel.text = String(score)
        roundLabel.text = String(round)
    }
}

