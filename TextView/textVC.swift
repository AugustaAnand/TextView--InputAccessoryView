//
//  textVC.swift
//  TextView
//
//  Created by Anand on 25/11/16.
//  Copyright © 2016 test. All rights reserved.
//

import UIKit

class textVC: UIViewController, UITextViewDelegate {

    var textViewYPosition: CGFloat = 64
    var textViewHeight: CGFloat = 0
    var deviceWidth: CGFloat = 0
    
    @IBOutlet var inputTextView: UITextView? = UITextView()
    let doneButton: UIButton = UIButton()
    let suggestioinScroll: UIScrollView = UIScrollView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        textViewHeight = UIScreen.main.bounds.size.height - textViewYPosition
        deviceWidth = UIScreen.main.bounds.size.width
        
        inputTextView?.text = "Add a comments, review or story \n Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda."
        inputTextView?.frame = CGRect.init(x: 0, y: textViewYPosition, width: deviceWidth, height: textViewHeight)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: Identify Keyboard Hide and fill the balance space of the view
    func keyboardWillHide() -> Void {
        inputTextView?.frame = CGRect.init(x: 0, y: textViewYPosition, width: deviceWidth, height: textViewHeight)
    }
    
    //MARK: Identify Keyboard Show and reduce the height based on the keyboard height + suggestionView Height
    func keyboardWillShow(notification:NSNotification) {
        let userInfo:NSDictionary = notification.userInfo! as NSDictionary
        let keyboardFrame:NSValue = userInfo.value(forKey: UIKeyboardFrameEndUserInfoKey) as! NSValue
        let keyboardRectangle = keyboardFrame.cgRectValue
        let keyboardHeight = keyboardRectangle.height//toatl keyboard height(Keyboard + suggestionView)
        
        inputTextView?.frame = CGRect.init(x: 0, y: textViewYPosition, width: deviceWidth, height: textViewHeight - keyboardHeight)
    }

    
    @IBAction func tapOnClose(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        self.addSuggestionView(textView: textView)
        return true
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        if text == "@" {
            suggestioinScroll.isHidden = false
            doneButton.setTitle("@", for: UIControlState.normal)
            return false
        }else if text == " " {
            suggestioinScroll.isHidden = true
        }else if text == "#" {
            
        }
        
        return true
    }
    
    
    func addSuggestionView(textView: UITextView){
        let suggestionViewHeight: CGFloat = 50
        let suggestionWidth: Int = 150
        
        let suggestionView:UIView = UIView()
        suggestionView.frame = CGRect.init(x: 0, y: 0, width: 200, height: suggestionViewHeight)
        suggestionView.backgroundColor = UIColor.white
        textView.delegate = self
        
        let seprateLabel: UILabel = UILabel()
        seprateLabel.frame = CGRect.init(x: 0, y: 0, width: deviceWidth, height: 0.5)
        seprateLabel.backgroundColor = UIColor.black
        suggestionView.addSubview(seprateLabel)
        
        doneButton.frame = CGRect.init(x: (deviceWidth - 60), y: ((suggestionView.frame.size.height / 2) - 15), width: 50, height: 30)
        doneButton.setTitle("Done", for: UIControlState.normal)
        doneButton.backgroundColor = UIColor.clear
        doneButton.setTitleColor(UIColor.blue, for: UIControlState.normal)
        doneButton.addTarget(self, action: #selector(tapOnDone(_:)) , for: UIControlEvents.touchUpInside)
        suggestionView.addSubview(doneButton)
        
        suggestioinScroll.frame = CGRect.init(x: 0, y: 1, width: (deviceWidth - 60), height: (suggestionViewHeight - 1))
        suggestioinScroll.backgroundColor = UIColor.clear
        suggestionView.addSubview(suggestioinScroll)

        var dynamicViewX: Int = 10
        
        for i in 0 ..< 10 {
            
            let tempViewHeight: CGFloat = (suggestionViewHeight - 10)
          
            let tempView: UIView = UIView()
            tempView.frame = CGRect.init(x: dynamicViewX, y: 5, width: suggestionWidth, height: Int(tempViewHeight))
            tempView.backgroundColor = UIColor.clear
            suggestioinScroll.addSubview(tempView)
            
            let userImage: UIImageView = UIImageView()
            userImage.frame = CGRect.init(x: 0, y: 0, width: tempViewHeight, height: tempViewHeight)
            userImage.image = UIImage.init(named: "sj")
            userImage.layer.borderWidth = 0.5
            userImage.clipsToBounds = true
            userImage.layer.cornerRadius = userImage.frame.size.width / 2
            tempView.addSubview(userImage)
            
            let suggestionLabel: UILabel = UILabel()
            suggestionLabel.frame = CGRect.init(x: (Int(tempViewHeight + 5)), y: 2, width: (suggestionWidth -  (Int(tempViewHeight) + 10) ), height: 36)
            suggestionLabel.numberOfLines = 2
            suggestionLabel.font = UIFont.systemFont(ofSize: 12)
            if (i % 2 == 0){
                suggestionLabel.text = "Anand1 Anand2 Anand3 Anand4 Anand5 Anand6 Anand7 Anand8 Anand9 Anand10"
            } else {
                suggestionLabel.text = "Anand"
            }
            tempView.addSubview(suggestionLabel)
            
            let suggestionButton: UIButton = UIButton()
            suggestionButton.frame =  CGRect.init(x: 0, y: 0, width: suggestionWidth, height: Int(tempViewHeight))
            suggestionButton.backgroundColor = UIColor.red
            suggestionButton.addTarget(self, action: #selector(tapOnSuggestio(_:)), for: UIControlEvents.touchUpInside)
            suggestionButton.tag = i
            tempView.addSubview(suggestionButton)
            
            dynamicViewX = (dynamicViewX + suggestionWidth + 10)
        }
        
        suggestioinScroll.contentSize.width = CGFloat(((suggestionWidth + 10) * 10) + 10)

        suggestioinScroll.isHidden = true
        
        textView.inputAccessoryView = suggestionView
        return
    }
    
    @IBAction func tapOnSuggestio(_ sender: Any){
        
        inputTextView?.text = "\(inputTextView!.text as String) \((sender as AnyObject).tag)"
        //print("\((sender as AnyObject).tag)")
    }
    
    @IBAction func tapOnDone(_ sender: Any){
        view.endEditing(true)
        
    }
    
}





