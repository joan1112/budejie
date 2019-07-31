//
//  ListTableViewController.swift
//  SwiftDemo
//
//  Created by qiong on 2019/7/12.
//  Copyright © 2019 qiong. All rights reserved.
//

import UIKit

class ListTableViewController: UITableViewController {

    let names = ["其它像按钮可以只设置左或右对齐，顶部的间距即可，最后一个控件设置bottom与父视图为0（这样就可以删除之前登录视图自定义的那个高度了","其它像按钮可以只设置左或右对齐，顶部的间距即可，最后一个控件设置bottom与父视图为0（这样就可以删除之前登录视图自定义的那个高度了其它像按钮可以只设置左或右对齐，顶部的间距即可，最后一个控件设置bottom与父视图为0（这样就可以删除之前登录视图自定义的那个高度了","其它像按钮可以只设置左或右对齐，顶部的间距即可，最后一个控件设置bottom与父视图为0（这样就可以删除之前登录视图","其它像按钮可以只设置左或右对齐，顶部的间距即可，最后一个控件设置bottom与父视图为0（这样就可以删除之前登录视图自定义的那个高度了其它像按钮可以只设置左或右对齐，顶部的间距即可，最后一个控件设置bottom与父视图为0（这样就可以删除之前登录视图自定义的那个高度了其它像按钮可以只设置左或右对齐，顶部的间距即可，最后一个控件设置bottom与父视图为0（这样就可以删除之前登录视图自定义的那个高度了","其它像按钮可以只设置左或右对齐，顶部的间距即可，最后一个控件设置bottom与父视图为0（这样就可以删除之前登录视图自定义的那个高度了其它像按钮可以只设置左或右对齐，顶部的间距即可，最后一个控件设置bottom与父视图为0（这样就可以删除之前登录视图自定义的那个高度了其它像按钮可以只设置左或右对齐，顶部的间距即可，最后一个控件设置bottom与父视图为0（这样就可以删除之前登录视图自定义的那个高度了","其它像按钮可以只设置左或右对齐，顶部的间距即可，最后一个控件设置bottom与父视图为0（这样就可以删除之前登录视图自定义的那个高度了其它像按钮可以只设置左或右对齐，"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = UITableView.automaticDimension;
        self.tableView.estimatedRowHeight = 140;
        let dataList = PeopleModel.getData()
        print(dataList);
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 10;
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row%2==0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! ListPeopleCell
             return cell;
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as! SeconTextViewCell
            
            let num = indexPath.row/2 + 1;
            
            cell.nameLab.text = names[num];
            return cell;
        }
        


       
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
