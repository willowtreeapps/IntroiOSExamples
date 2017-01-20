//
//  ViewController.swift
//  CustomTableCellsExample
//
//  Created by Jackson Taylor on 1/19/17.
//  Copyright © 2017 WillowTree Apps, Inc. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {

    var stories: [Story] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // first load the nib so that we can tell the tableview what to expect
        let nib = UINib(nibName: "CustomTableViewCell", bundle: nil)
        // next pass that nib into the table view so that it knows what a storyCell
        // looks like and what class it should use
        tableView.register(nib, forCellReuseIdentifier: "storyCell")
        
        // let's add some test data to the array so that our tableView will be
        // populated with some simple stories
        setupTestData()
        
        // now that we have some data we can then reload the tableView so that it
        // will fetch all of our new stories
        tableView.reloadData()
        
        // we set the row height to automatic so that it will use the constraints in
        // the CustomTableViewCell.xib file rather than us providing an exact dimension
        // This way depending on how long the story is the cell may be 100pt or 1000pt
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100.0
    }
    
    func setupTestData() {
        // just want to add some random stories here
        let story = Story(title: "The Essential Guide to Career Fair Success", description: "No matter what year you are, going to a career fair is both an exciting and daunting task. You’ll see representatives from really cool companies, along with organizations you’ve never heard of. And all of them will be talking to you about their company culture, available positions, and much more. How do you prepare?")
        stories.append(story)
        
        let story2 = Story(title: "Mobile Predictions for 2017 – Bots & Apps: Can’t they get along?", description: "Every year we make our projections for the coming year in mobile.   Some years it’s a Top 10, some a Top 5, but this year it’s a Top 1.   We haven’t felt more certain about any trend since the launches of the iPhone and iPad — this is going to be big. Bots or intelligent agents are everywhere in the press.  According to BI Intelligence, 59% of users 18-55 are using bots, at least occasionally.   But for those of us who have used bots, they remain a royal pain to use for all sorts of reasons.")
        stories.append(story2)
        
        let story3 = Story(title: "Get your OTT video app ready for Google Home", description: "With Black Friday and Cyber Monday past and the holiday season upon us, there are soon to be thousands more proud owners of Google Home, Google’s recent foray into the realm of the “smart” or “connected” home (as well as its answer to Amazon’s Echo). Home gives users all the search capabilities and assorted superpowers of Google Assistant, but with always-on voice-operated availability. Normally, to use Google Assistant you would either need a Pixel phone or you would need to download the Allo messaging app to your iOS or Android smartphone. Home conveniently turns Assistant into a virtual housemate ready to act on your every request.")
        stories.append(story3)
        
        let story4 = Story(title: "Introducing WillowTree Usability Labs", description: "On the WillowTree User Experience team, we pride ourselves on making beautiful mobile experiences. Every idea, pixel, and interaction work together in concert to create something that’s both great to look at and delightful to use. That mix doesn’t just happen in a vacuum. We are always sharing our designs and ideas with each other, our partners, and with real potential users to validate the design decisions and assumptions we’re making along the way.")
        stories.append(story4)
        
        let story5 = Story(title: "Video interviews can be awkward, but get used to them", description: "I was recently invited to talk to a group of students in a Masters Data Science program at a nearby university. Long story short, my mandate was to help prepare them to find jobs after graduation. There are worse positions to be in these days than having a Data Science degree, but many of these students have never interviewed for anything more than an internship so I covered everything from resumes through offer letters.")
        stories.append(story5)
        
        // checkout more of the WillowTree blogs: http://willowtreeapps.com/app-media/page/2/
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "storyCell", for: indexPath)
        
        if let storyCell = cell as? CustomTableViewCell {
            storyCell.setup(withStory: stories[indexPath.item])
        }
        
        return cell
    }
}
