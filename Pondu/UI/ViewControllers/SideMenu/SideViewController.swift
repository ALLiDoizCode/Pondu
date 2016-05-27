//
//  SideViewController.swift
//  Pondu
//
//  Created by Jonathan Green on 5/13/16.
//  Copyright © 2016 Jonathan Green. All rights reserved.
//

import UIKit
import Material

enum DrawerSection: Int {
    case ViewSelection
    case DrawerWidth
    case ShadowToggle
    case OpenDrawerGestures
    case CloseDrawerGestures
    case CenterHiddenInteraction
    case StretchDrawer
}

class SideViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let editProfileVC = EditProfileViewcontroller()
    let accountSettintsVC = AccountViewController()
    
    var tableView: UITableView!
    let drawerWidths: [CGFloat] = [160, 200, 240, 280, 320]
    
    let accountDetails = ["Edit Pofile","Account Settings","Notifications",""]
    let accoutIcons = ["round","cogwheel","sound",""]
    let accoutIcon = "key"
    
    let legal = ["Help","Terms of Service","Privacy Policy","Pondu-app.com",""]
    let legalIcons = ["people","tool","security","window",""]
    let legalIcon = "legal"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView = UITableView(frame: self.view.frame, style: .Grouped)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.view.addSubview(self.tableView)
        self.tableView.autoresizingMask = [ .FlexibleWidth, .FlexibleHeight ]
        
        self.tableView.backgroundColor = UIColor.darkGrayColor()
        self.tableView.separatorStyle = .None
        
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 161 / 255, green: 164 / 255, blue: 166 / 255, alpha: 1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor(red: 55 / 255, green: 70 / 255, blue: 77 / 255, alpha: 1.0)]
        
        //self.view.backgroundColor = UIColor.darkGrayColor()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // See https://github.com/sascha/DrawerController/issues/12
        self.navigationController?.view.setNeedsLayout()
        
        self.tableView.reloadSections(NSIndexSet(indexesInRange: NSRange(location: 0, length: self.tableView.numberOfSections - 1)), withRowAnimation: .None)
    }
    
     func contentSizeDidChange(size: String) {
        self.tableView.reloadData()
    }
    
    // MARK: - UITableViewDataSource
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return accountDetails.count
        case 1:
            return legal.count
        default:
            return 0
        }
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let CellIdentifier = "Cell"
        
        var cell: MaterialTableViewCell! = tableView.dequeueReusableCellWithIdentifier(CellIdentifier) as! MaterialTableViewCell?
        
        if cell == nil {
            cell = SideDrawerTableViewCell(style: .Default, reuseIdentifier: CellIdentifier)
            cell.selectionStyle = .Blue
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        switch indexPath.section {
        case 0:
            
            cell.textLabel?.text = accountDetails[indexPath.row]
            cell.imageView?.image = UIImage(named: accoutIcons[indexPath.row])
            
        case 1:
            
            cell.textLabel?.text = legal[indexPath.row]
            
            cell.imageView?.image = UIImage(named: legalIcons[indexPath.row])

            
        default: break
            
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
        switch indexPath.section {
        case 0:
            
            switch indexPath.row {
                
            case 0:
                print(accountDetails[0])
                
                sideMenuController()?.setContentViewController(editProfileVC)
            case 1:
                
                print(accountDetails[1])
                
                sideMenuController()?.setContentViewController(accountSettintsVC)
                
            case 3:
                
                print(accountDetails[2])
                

            default:
                break
            }
            
        case 1:
            
            switch indexPath.row {
            case 0:
                print(legal[0])
            case 1:
                print(legal[1])
            case 2:
                print(legal[2])
            case 3:
                print(legal[3])
                let ponduWebSite = WebViewController()
                sideMenuController()?.setContentViewController(ponduWebSite)
            default:
                break
            }
            
        default: break
            
        }
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        tableView.headerViewForSection(section)?.textLabel?.textColor = UIColor.whiteColor()
        
        switch section {
        case 0:
            return "Account Details"
        case 1:
            return "Legal"

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
        
        header.textLabel?.textColor = title.textColor
    
    }

    
    // MARK: - UITableViewDelegate

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
