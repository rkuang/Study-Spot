//
//  NewReviewViewController.swift
//  Study Spot
//
//  Created by Ricky Kuang on 12/4/18.
//  Copyright © 2018 Ricky Kuang. All rights reserved.
//

import UIKit
import Cosmos
import FirebaseFirestore

class NewReviewViewController: UIViewController, UITextViewDelegate {
    
    var titleLabelText: String!
    var docRef: DocumentReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingSlider: CosmosView!
    @IBOutlet weak var noiseSlider: UISlider!
    @IBOutlet weak var activitySlider: UISlider!
    @IBOutlet weak var comfortSlider: UISlider!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var hintLabel: UILabel!

    var textViewFrame: CGRect!
    var keyboardHeight: CGFloat!
    
    func setupViews() {
        titleLabel.text = titleLabelText
        
        textView.delegate = self
        textView.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        textView.textContainer.lineFragmentPadding = 0
        textView.addDoneButtonOnKeyboard()
        
        ratingSlider.didFinishTouchingCosmos = { rating in
            if rating != 0 {
                self.containsRating = true
            }
            self.checkRequiredFields()
        }
    }
    
    // MARK: - UITextViewDelegate
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textViewFrame = textView.frame
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            print("did begin editing")
            self.textView.frame = CGRect(x: self.textView.frame.minX, y: 24, width: self.textView.frame.width, height: self.view.frame.height - self.keyboardHeight)
            self.hintLabel.frame = CGRect(x: self.textView.frame.minX, y: 24, width: self.hintLabel.frame.width, height: self.hintLabel.frame.height)
        }, completion: nil)
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            print("did end editing")
            self.textView.frame = self.textViewFrame
            self.hintLabel.frame = CGRect(x: self.textView.frame.minX, y: self.textView.frame.minY, width: self.hintLabel.frame.width, height: self.hintLabel.frame.height)
        }, completion: nil)
    }
    
    var containsText = false
    var containsRating = false
    
    func textViewDidChange(_ textView: UITextView) {
        if !textView.text.isEmpty {
            hintLabel.isHidden = true
            containsText = true
        } else {
            hintLabel.isHidden = false
            containsText = false
        }
        checkRequiredFields()
    }
    
    @IBOutlet weak var postReviewButton: UIBarButtonItem!
    func checkRequiredFields() {
        if containsText && containsRating {
            postReviewButton.isEnabled = true
        } else {
            postReviewButton.isEnabled = false
        }
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRect = keyboardFrame.cgRectValue
            print(keyboardRect.minY)
            keyboardHeight = keyboardRect.height + 24 + 16
        }
    }
    
    @IBAction func postReviewAction(_ sender: Any) {
        let dictionary: [String: Any] = [
            "text": self.textView.text!,
            "rating": self.ratingSlider.rating,
            "timestamp": Timestamp(),
            "environment": [
                "noise": Double(self.noiseSlider.value),
                "activity": Double(self.activitySlider.value),
                "comfort": Double(self.comfortSlider.value)
            ]
        ]
        let uiBusy = UIActivityIndicatorView()
        uiBusy.startAnimating()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: uiBusy)
        if let review = Review(dictionary: dictionary) {
            self.docRef.collection("reviews").addDocument(data: review.dictionary) { (err) in
                if let err = err {
                    print("There was an error: \(err)")
                } else {
                    self.performSegue(withIdentifier: "unwindToStudySpotDetail", sender: self)
                }
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
}

extension UITextView {
    
    func addDoneButtonOnKeyboard() {
        let doneToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonAction))
        
        doneToolbar.items = [flexSpace, done]
        doneToolbar.sizeToFit()
        
        self.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction() {
        self.resignFirstResponder()
    }
}
