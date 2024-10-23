//
//  BSViewController.swift
//  BSDemo
//
//  Created by Rezaul Karim on 23/10/24.
//

import UIKit

class BSFirstViewController: UIViewController {
    
    class func initWithStoryboard() -> BSFirstViewController {
        let controller = UIStoryboard.mainStoryBoard.instantiateViewController(withIdentifier: BSFirstViewController.className) as! BSFirstViewController
        return controller
    }
    
    @IBOutlet weak var container : UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.initializeContainer()
        print("started")
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
        
        
    }

}


// MARK: ---------- EXTENSION : BSFirstViewController(UITableViewDataSource) ----------
extension BSFirstViewController : UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 15
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: BSDemoCell.className) as! BSDemoCell
    return cell
  }
}
// MARK: ---------- EXTENSION : BSFirstViewController(UITableViewDelegate) ----------
extension BSFirstViewController : UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
    return UITableView.automaticDimension
  }
}
