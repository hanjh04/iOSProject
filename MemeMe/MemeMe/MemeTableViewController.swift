//
//  MemeTableViewController.swift
//  MemeMe
//
//  Created by connect on 2017. 1. 25..
//  Copyright © 2017년 udacity. All rights reserved.
//

import Foundation
import UIKit

class MemeTableViewController: UITableViewController{
    
    // MARK: outlets
    @IBOutlet var tView: UITableView!
    //meme 이미지 사용을 위한 변수 설정
    var memes = [Meme]()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    
    // MARK: Life cycles
    
    override func viewWillAppear(_ animated: Bool) {
        tView.reloadData()//전체 데이터 다 다시읽기
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
    }
    
    
    // MARK: 테이블뷰 설정
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let memes = self.appDelegate.memes
        print("memes.count in tableviewcontroller : \(memes.count)")
        return memes.count
    }
    
    //재사용가능한 셀 있는 지 살펴보고 없으면 새로운 셀 만든다.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemeTableViewCell", for: indexPath) as! MemeTableViewCell//, for:indexPath) as UITableViewCell
        let meme = self.appDelegate.memes[indexPath.row]
        cell.memedImageView.image = meme.memedImage
        cell.topLabel.text = meme.topText
        cell.bottomLabel.text = meme.bottomText

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailViewController = self.storyboard!.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
        detailViewController.meme = appDelegate.memes[(indexPath as NSIndexPath).row]
        self.navigationController!.pushViewController(detailViewController, animated: true)
    }
}
