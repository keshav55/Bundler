//
//  DetailViewController.swift
//  Bundler
//
//  Created by Sujith Vishwajith on 2/7/15.
//  Copyright (c) 2015 Sujith Vishwajith. All rights reserved.
//

import UIKit

class DetailTableViewCell : UITableViewCell {
    @IBOutlet weak var detailImage: UIImageView!
    @IBOutlet weak var detailTitle: UILabel!
    @IBOutlet weak var detailCost: UILabel!
    
    func loadItem(title: String, itemCost: Int, image: String) {
        detailImage.image = UIImage(named: image)
        detailTitle.text = title
        detailCost.text = "$" + String(itemCost)
    }
    
}

class DetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var resultTable: UITableView!
    
    var items: [(String, Int, String)] = [
        ("Magic Candles", 5, "party.png")
    ]
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.navigationController?.navigationBar.hidden = false
        self.navigationController?.title = "Detail View"
        self.navigationItem.setHidesBackButton(true, animated: false)
        // Do any additional setup after loading the view.
        
        var nib = UINib(nibName: "DetailViewTableCell", bundle: nil)
        resultTable.registerNib(nib, forCellReuseIdentifier: "customCell")
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:DetailTableViewCell = self.resultTable.dequeueReusableCellWithIdentifier("customCell") as DetailTableViewCell
        
        // this is how you extract values from a tuple
        var (title, itemCost, image) = items[indexPath.row]
        
        cell.loadItem(title, itemCost: itemCost, image: image)
        
        return cell
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 70;
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 70;
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        println("You selected cell #\(indexPath.row)!")
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return false
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.navigationBarHidden = false
        self.navigationController?.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "Avenir Next", size: 20)!,  NSForegroundColorAttributeName: UIColor.whiteColor()]
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

}
