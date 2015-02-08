//
//  NewBundleViewController.swift
//  Bundler
//
//  Created by Sujith Vishwajith on 2/8/15.
//  Copyright (c) 2015 Sujith Vishwajith. All rights reserved.
//

import UIKit

class ProductListCell : UITableViewCell {
    @IBOutlet weak var detailImage: UIImageView!
    @IBOutlet weak var detailTitle: UILabel!
    @IBOutlet weak var detailCost: UILabel!
    
    func loadDetail(#title: String, itemCost: Int, image: String) {
        detailImage.image = UIImage(named: image)
        detailTitle.text = title
        detailCost.text = "$" + String(itemCost)
    }
    
}

class NewBundleViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var bundleTitleField: UITextField!
    @IBOutlet weak var bundleItemField: UITextField!
    @IBOutlet weak var tableViewList: UITableView!
    
    var items: [(String, Int, String)] = [
        ("Magic Candles", 5, "party.png"),
        ("Magic Candles", 5, "party.png")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.hidden = false
        self.navigationController?.title = "New Bundle"
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.bundleItemField.delegate = self;
        self.bundleTitleField.delegate = self;
        
        var nib = UINib(nibName: "ProductTableViewCell", bundle: nil)
        tableViewList.registerNib(nib, forCellReuseIdentifier: "customCell")
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:ProductListCell = self.tableViewList.dequeueReusableCellWithIdentifier("customCell") as ProductListCell
        
        // this is how you extract values from a tuple
        var (title, itemCost, image) = items[indexPath.row]
        
        cell.loadDetail(title: title, itemCost: itemCost, image: image)
        
        return cell
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 45;
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 45;
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        println("You selected cell #\(indexPath.row)!")
        self.performSegueWithIdentifier("toDetailView", sender: self)
        
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count;
    }
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.view.endEditing(true);
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        self.view.endEditing(true);
        return false;
    }
    
    @IBAction func backToMain(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
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
    


}
