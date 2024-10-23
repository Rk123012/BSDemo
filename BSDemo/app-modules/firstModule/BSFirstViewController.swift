//
//  BSViewController.swift
//  BSDemo
//
//  Created by Rezaul Karim on 23/10/24.
//

import UIKit

class BSFirstViewController: UIViewController {
    
    var information = [String]()
    
    class func initWithStoryboard() -> BSFirstViewController {
        let controller = UIStoryboard.mainStoryBoard.instantiateViewController(withIdentifier: BSFirstViewController.className) as! BSFirstViewController
        return controller
    }
    
    @IBOutlet weak var container : UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.initializeContainer()
        print("started->", BSConstants.baseUrl)
        BSRequest.shared.callAPI(urlExtension: "/api/users?page=2", method: "GET", parametersDict: nil) { response, err, success in
            if let resp = response, let data = resp["data"] as? [[String:Any]]{
                self.information.removeAll()
                for dataItem in data{
                    #if DEV
                    if let name = dataItem["first_name"] as? String{
                        self.information.append(name)
                    }
                    #else
                    if let email = dataItem["email"] as? String{
                        self.information.append(email)
                    }
                    #endif
                }
            }
           
            DispatchQueue.main.async {
                self.container.reloadData()
            }
        }
        
    }

    private func initializeContainer() {
        self.container.dataSource = self
        self.container.delegate = self
        self.container.rowHeight = UITableView.automaticDimension
        self.container.estimatedRowHeight = UITableView.automaticDimension
        self.container.separatorStyle = .singleLine
        self.container.reloadData()
        self.container.showsVerticalScrollIndicator = false
        self.container.register(UINib(nibName: BSDemoCell.className, bundle:Bundle.main), forCellReuseIdentifier: BSDemoCell.className)
        self.container.reloadData()
        
    }

}


// MARK: ---------- EXTENSION : BSFirstViewController(UITableViewDataSource) ----------
extension BSFirstViewController : UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return self.information.count
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: BSDemoCell.className) as! BSDemoCell
      cell.setInformation(name: self.information[indexPath.row])
    return cell
  }
}
// MARK: ---------- EXTENSION : BSFirstViewController(UITableViewDelegate) ----------
extension BSFirstViewController : UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
    return UITableView.automaticDimension
  }
}
