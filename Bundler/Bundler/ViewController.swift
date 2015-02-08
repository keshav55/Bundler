//
//  ViewController.swift
//  Bundler
//
//  Created by Sujith Vishwajith on 2/7/15.
//  Copyright (c) 2015 Sujith Vishwajith. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var searchTextView: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationController?.title = "Search"
        self.searchTextView.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.navigationBar.hidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.view.endEditing(true);
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        self.view.endEditing(true);
        return false;
    }
    
    @IBAction func search(sender: AnyObject) {
        self.performSegueWithIdentifier("toTableView", sender: self)
    }
}

func save(shoppingList : [Bundle]) {
    
    var saveString = String();
    for Bundle in shoppingList {
        saveString += Bundle.name + "$$" ;
        for stringz in Bundle.myArray {
            saveString += stringz + "$$";
        }
        saveString += "##";
    }
    NSUserDefaults.standardUserDefaults().setObject(saveString, forKey: "bundles")
    //NSUserDefaults.standardUserDefaults().setObject(newValue as [NSString], forKey: "food")
    NSUserDefaults.standardUserDefaults().synchronize()
}


func retrieve() -> [Bundle]{
    
    var returnArray = [Bundle]();
    let prefs = NSUserDefaults.standardUserDefaults();
    var saveString = prefs.stringForKey("bundles");
    let scanner = NSScanner(string: saveString!)
    var space = String();
    space = "$$";
    var hashtag = "##";
    
    while (!scanner.atEnd)
    {
        var altResult:NSString?
        var bundle = Bundle();
        scanner.scanUpToString(space, intoString:&altResult);
        scanner.scanString(space, intoString: nil);
        bundle.name = altResult!;
        var newString :NSString?
        scanner.scanUpToString(hashtag, intoString:&newString);
        scanner.scanString(hashtag, intoString: nil);
        let scanner2 = NSScanner(string: newString!)
        while (!scanner2.atEnd)
        {
            var string2  : NSString?;
            scanner2.scanUpToString(space, intoString: &string2)
            scanner2.scanString(space, intoString: nil);
            bundle.myArray.append(string2!);
        }
        
        returnArray.append(bundle );
        
    }
    return returnArray;
    
}


