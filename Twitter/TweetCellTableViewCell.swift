//
//  TweetCellTableViewCell.swift
//  Twitter
//
//  Created by William Daugherty on 10/4/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class TweetCellTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var tweetContent: UILabel!
    
    @IBOutlet weak var FavoriteButton: UIButton!
    
    @IBOutlet weak var retweetButton: UIButton!
    
    @IBAction func favoriteTweet(_ sender: Any) {
        let tobeFavorited = !favorited
        if (tobeFavorited) {
            TwitterAPICaller.client?.favoriteTweet(tweetId: tweetId, success: { self.setFavorite(true)
            }, failure: { (error) in
                print("Error: could not favorite tweet. \(error)")
            })
        } else {
            TwitterAPICaller.client?.unfavoriteTweet(tweetId: tweetId, success: { self.setFavorite(false)
                }, failure: { (error) in
                    print("Error: could not unfavorite tweet. \(error)")
                })
        }
    }
    
    @IBAction func retweet(_ sender: Any) {
        TwitterAPICaller.client?.reTweet(tweetId: tweetId, success: {
            self.setRetweeted(true)
        }, failure: { (error) in
            print("Error retweeting. \(error)")
            
        })
    }
    
    var favorited:Bool = false
    var tweetId:Int = -1
    //var retweeted:Bool = false
    func setFavorite(_ isFavorited:Bool){
        favorited = isFavorited
        if(favorited) {
            FavoriteButton.setImage(UIImage(named:"favor-icon-red"), for: UIControl.State.normal)
        } else {
            FavoriteButton.setImage(UIImage(named:"favor-icon"), for: UIControl.State.normal)
        }
    }
    func setRetweeted(_ isRetweeted:Bool) {
        if (isRetweeted) {
            retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: UIControl.State.normal)
            retweetButton.isEnabled = false
        } else {
            retweetButton.setImage(UIImage(named: "retweet-icon"), for: UIControl.State.normal)
            retweetButton.isEnabled = true
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
