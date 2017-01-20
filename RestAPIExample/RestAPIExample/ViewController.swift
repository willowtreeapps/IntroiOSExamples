//
//  ViewController.swift
//  RestAPIExample
//
//  Created by Jackson Taylor on 1/18/17.
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
import Alamofire

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var pokemon: [Pokemon] = []
    
    // the API that we are using just for an example
    let apiURL = "https://pokeapi.co/api/v2/pokemon/"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // we are going to hide the table until the data has been loaded
        tableView.isHidden = true
        
        loadPokemon()
    }

    func loadPokemon() {
        // Let's make an API call to the url and have it respond with JSON
        // Checkout: https://github.com/Alamofire/Alamofire
        // Use that link to get some docs on exactly how the API works
        Alamofire.request(apiURL).responseJSON { [weak self] response in
            if let jsonValue = response.result.value as? JSON,
                let jsonArray = jsonValue["results"] as? [JSON] {
                // Now that we have a valid response, let's interpret that response
                // and make a bunch of Pokemon objects
                
                let pokemon = jsonArray.flatMap { return Pokemon(json: $0) }
                // if any of the json objects are improperly formatted, then we will just
                // ignore them for now. So what flatMap does is it will check to see if 
                // any of the values are nil, and if they are just ignore them.
                
                // let's set the array we have to the global array so the tableView can use
                // it
                self?.pokemon = pokemon
                
                // next let's reload the data on the table view so that the new pokemon will
                // show up
                self?.tableView.reloadData()
                
                // and then of course let's reshow the table view
                self?.tableView.isHidden = false
            }
            else {
                // We could set something here to let the user know that the API call
                // failed. Maybe show an alert or something
            }
        }
    }

    // we only need one section in our table view so let's just return a static 1 for now
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // we want the tableView to show all of the pokemon we have so let's return the count
    // of the array
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemon.count
    }
    
    // now that we have a pokemon object, we can actually just fill out the tableViewCell with
    // the information in the pokemon. So let's just use the name and url for now. If you want extra
    // data then that's something you can definitely add! :) 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "basicCell", for: indexPath)
        
        let pokemon = self.pokemon[indexPath.item]
        
        cell.textLabel?.text = pokemon.name
        cell.detailTextLabel?.text = pokemon.url
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // A table cell was selected by the user
    }
}

