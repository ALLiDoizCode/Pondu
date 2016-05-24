//
//  AccountViewController.swift
//  Pondu
//
//  Created by Jonathan Green on 5/24/16.
//  Copyright © 2016 Jonathan Green. All rights reserved.
//

import UIKit
import Material
import Cartography

class AccountViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    
    let presenter = theUser()
    
    var tableView: UITableView!
    var currentTitle:UILabel!
    var backBtn:MaterialButton!
    var topView:UIView!
    
    let sections = ["Prefrences","Privacy/Blocked","Actions","",""]
    let prefences = ["Home School"]
    let privacyBlocked = ["Private Account","Blocked Users"]
    let actions = ["Clear Messages","Logout"]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = MaterialColor.white
        self.tableView = UITableView(frame: CGRectMake(0, 0, 0, 0), style: .Grouped)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.view.addSubview(self.tableView)
        setupUI()
        self.tableView.autoresizingMask = [ .FlexibleWidth, .FlexibleHeight ]
        
        self.tableView.backgroundColor = MaterialColor.grey.lighten2
        self.tableView.separatorStyle = .None
        
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 161 / 255, green: 164 / 255, blue: 166 / 255, alpha: 1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor(red: 55 / 255, green: 70 / 255, blue: 77 / 255, alpha: 1.0)]

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        
        self.navigationController?.view.setNeedsLayout()
        
        self.tableView.reloadSections(NSIndexSet(indexesInRange: NSRange(location: 0, length: self.tableView.numberOfSections - 1)), withRowAnimation: .None)
    }
    
    func setupUI() {
        
        currentTitle = UILabel()
        currentTitle.text = "Account Settings"
        currentTitle.textAlignment = .Center
        backBtn = MaterialButton()
        backBtn.setImage(UIImage(named:"arrows"), forState: UIControlState.Normal)
        topView = UIView()
        
        self.view.addSubview(topView)
        self.topView.addSubview(currentTitle)
        self.topView.addSubview(backBtn)
        
        constrain(tableView,currentTitle,backBtn,topView) { tableView,currentTitle,backBtn,topView in
            
            topView.top == (topView.superview?.top)!
            topView.left == (topView.superview?.left)!
            topView.height == (topView.superview?.height)! * 0.07
            topView.width == (topView.superview?.width)!
            currentTitle.center == (currentTitle.superview?.center)!
            backBtn.left == (backBtn.superview?.left)! + 5
            backBtn.centerY == (backBtn.superview?.centerY)!
            backBtn.width == 25
            backBtn.height == 25
            
            tableView.left == (tableView.superview?.left)!
            tableView.height == (tableView.superview?.height)! * 0.93
            tableView.width == (tableView.superview?.width)!
            tableView.bottom == (tableView.superview?.bottom)!
        }
    }
    
    func contentSizeDidChange(size: String) {
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return sections.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return prefences.count
        case 1:
            return privacyBlocked.count
        case 2:
            return actions.count
        case 3:
            return 0
        case 4:
            return 1
        default:
            break
        }
        
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let CellIdentifier = "Cell"
        
        var cell: UITableViewCell! = tableView.dequeueReusableCellWithIdentifier(CellIdentifier) as UITableViewCell?
        
        if cell == nil {
            cell = AccountTableViewCell(style: .Default, reuseIdentifier: CellIdentifier)
            cell.selectionStyle = .Blue
        }
        
        switch indexPath.section {
            
        case 0:
            cell.textLabel?.text = prefences[indexPath.row]
        case 1:
            cell.textLabel?.text = privacyBlocked[indexPath.row]
        case 2:
            cell.textLabel?.text = actions[indexPath.row]
        case 4:
            cell.textLabel?.text = "Delete Account"
        default:
            break
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let loginStoryBoard = UIStoryboard(name: "Login-SignUp", bundle: nil)
        let welcomeVC = loginStoryBoard.instantiateViewControllerWithIdentifier("Welcome") as! WelcomeViewController
        
        switch indexPath.section {
            
        case 2:
            
            switch indexPath.row {
     
            case 1:
                presenter.currentUser().logout()
                self.navigationController?.pushViewController(welcomeVC, animated: true)
            default:
                break
            }
        case 4:
            
            switch indexPath.row {
            case 0:
                
                presenter.deleteAccount({ (result) in
                    
                    if result == true {
                        
                        self.navigationController?.pushViewController(welcomeVC, animated: true)
                    }
                })
            default:
                break
            }
        default:
            break
        }
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        //tableView.headerViewForSection(section)?.textLabel?.textColor = MaterialColor.grey.lighten2
        
        switch section {
        case 0:
            return sections[section]
        case 1:
            return sections[section]
        case 2:
            return sections[section]
            
        default:
            return nil
        }
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        switch section {
        case 0:
            return 30
        default:
            return 20
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    func imageWithImage(image:UIImage,scaledToSize newSize:CGSize)->UIImage{
        
        UIGraphicsBeginImageContext( newSize )
        image.drawInRect(CGRect(x: 0,y: 0,width: newSize.width,height: newSize.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage.imageWithRenderingMode(.AlwaysTemplate)
    }
    
    
    func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let frame = CGRect(x: 10, y: view.frame.midY - 15, width: 20, height: 20)
        let title = UILabel(frame: CGRect(x: frame.origin.x + 200, y: view.frame.midY - 15, width: 20, height: 20))
        let imageView = UIImageView(frame:frame)
        imageView.contentMode = .ScaleAspectFit
        imageView.clipsToBounds = true
        view.addSubview(imageView)
        view.addSubview(title)
        
        title.font = UIFont(name: "Optima", size: 17)!
        title.textColor = UIColor.whiteColor()
        
        let header = view as! UITableViewHeaderFooterView
        
        header.textLabel?.textColor = MaterialColor.grey.base
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
