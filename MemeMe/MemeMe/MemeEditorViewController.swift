//
//  MemeEditorViewController.swift
//  MemeMe
//
//  Created by connect on 2017. 1. 20..
//  Copyright © 2017년 udacity. All rights reserved.
//

import UIKit
import Photos

class MemeEditorViewController: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate, UITextFieldDelegate{

    // MARK: outlets
    //view outlets
    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var imagePickerView: UIImageView!
    //textfield outlets
    @IBOutlet weak var buttomTextField: UITextField!
    @IBOutlet weak var topTextField: UITextField!
    //bar outlets
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var navBar: UINavigationItem!
    //button outlets
    @IBOutlet weak var albumButton: UIBarButtonItem!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var resetLocationButton: UIBarButtonItem!
    @IBOutlet weak var prevViewButton: UIBarButtonItem!

    //store textfield's location
    var location = CGPoint(x: 0, y: 0)
    var bottomTextFieldLocation = CGPoint(x:0, y: 0)
    var topTextFieldLocation = CGPoint(x:0, y:0)
    //textfield attributes
    let myAttributes = [
        NSStrokeColorAttributeName : UIColor.black,
        NSForegroundColorAttributeName : UIColor.white,
        NSFontAttributeName : UIFont(name: "Arial", size : 40)!,
        NSStrokeWidthAttributeName : -1.0
        ] as [String : Any]
    
    
    // MARK: LIFECYCLE
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //키보드 호출, 화면전환 notification 등록
        subscribeToKeyboardNotifications()
        subscribeToChangedOrientation()
        
        //뷰 초기화
        initViews()
        
        //텍스트필드  delegate 설정
        buttomTextField.delegate = self
        topTextField.delegate = self
        
        //텍스트필드 이동을 위한 설정
        let topGesture = UIPanGestureRecognizer(target: self, action: #selector(topTextFieldDragged))
        let bottomGesture = UIPanGestureRecognizer(target: self, action: #selector(bottomTextFieldDragged))
        buttomTextField.addGestureRecognizer(bottomGesture)
        buttomTextField.isUserInteractionEnabled = true
        topTextField.addGestureRecognizer(topGesture)
        topTextField.isUserInteractionEnabled = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        shareButton.isEnabled = false
        //텍스트필드의 위치 저장
        setTextFieldLocation()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: Initiation and Modify TextField
    
    func initViews(){
        //init textField
        buttomTextField.defaultTextAttributes = myAttributes
        topTextField.defaultTextAttributes = myAttributes
        buttomTextField.textAlignment = .center
        topTextField.textAlignment = .center
        //init button
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField.text == "TOP" || textField.text == "BOTTOM"{
            textField.text = ""
        }
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if(textField.text == ""){
            if(textField.restorationIdentifier == "topTextField"){
                textField.text = "TOP"
            }else{
                textField.text = "BOTTOM"
            }
        }
        return true
    }
    
    
    // MARK: MOVE TEXTFIELD
    
    func bottomTextFieldDragged(gesture: UIPanGestureRecognizer){
        var loc = gesture.location(in: self.view)
        loc.y = loc.y-60
        if(loc.y < self.view.frame.maxY - 130 && loc.y > 20){
            self.buttomTextField.center = loc
        }
    }
    
    func topTextFieldDragged(gesture: UIPanGestureRecognizer){
        var loc = gesture.location(in: self.view)
        loc.y = loc.y-60
        if(loc.y < self.view.frame.maxY - 130 && loc.y > 20){
            self.topTextField.center = loc
        }
    }
    
    func subscribeToChangedOrientation(){
        NotificationCenter.default.addObserver(self, selector: #selector(setTextFieldLocation), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
    }
    
    func setTextFieldLocation() {
        bottomTextFieldLocation = buttomTextField.center
        topTextFieldLocation = topTextField.center
    }
    
    @IBAction func resetLocationOfTextField(_ sender: Any) {
        buttomTextField.center = bottomTextFieldLocation
        topTextField.center = topTextFieldLocation
    }

//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        let touch: UITouch! = touches.first! as UITouch
//        location = touch.location(in: self.view)
//        
//        if buttomTextField.frame.contains(location){
//            buttomTextField.center = location
//        }else if topTextField.frame.contains(location){
//            topTextField.center = location
//        }
//        
//    }
//
//    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        let touch: UITouch! = touches.first! as UITouch
//        location = touch.location(in: self.view)
//        if buttomTextField.frame.contains(location){
//            buttomTextField.center = location
//        }else if topTextField.frame.contains(location){
//            topTextField.center = location
//        }
//    }

    
    // MARK: Pick an Image from Camera or PhotoLibrary
    
    @IBAction func pickAnImage(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
        shareButton.isEnabled = true
    }
    
    @IBAction func pickAnImageFromCamera(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
        shareButton.isEnabled = true
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[(UIImagePickerControllerOriginalImage) as String] as? UIImage{
            imagePickerView.image = image
            dismiss(animated: true, completion: nil)
            shareButton.isEnabled = true
            prevViewButton.title = "Remove Image"
        }else{
            print("error!!")
        }
    }

    
    // MARK: Share Image
    
    @IBAction func shareImage(_ sender: Any) {
        //generate a meme image
        //define an instance of the activityViewController
        //pass the activityViewController a memedimage as an activity item
        //present the activity view controller
        let memedImage = generateMemedImage()
        var sharingItems = [AnyObject]()
        sharingItems.append(memedImage)
        let activityViewController = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
//        activityViewController.completionWithItemsHandler = {(str, saved, items, error) in
//            if !saved{
//                            }
//        }
        self.save()

        present(activityViewController, animated: true, completion: nil)
        navigationController?.popToRootViewController(animated: true)
    }
    
 
    // MARK: Hide and Show Keyboard When Modifying TextField
    
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            let touch: UITouch! = touches.first! as UITouch
            location = touch.location(in: self.view)
    
            if buttomTextField.frame.contains(location){
                buttomTextField.center = location
            }else if topTextField.frame.contains(location){
                topTextField.center = location
            }
            
        }

    func keyboardWillShow(_ notification:Notification) {
        let keyboardHeight = getKeyboardHeight(notification)
        if (buttomTextField.isEditing && buttomTextField.frame.maxY > keyboardHeight) ||
            (topTextField.isEditing && topTextField.frame.maxY > keyboardHeight){
            view.frame.origin.y = 0 - getKeyboardHeight(notification)
        }
    }
    
    func keyboardWillHide(_ notification: Notification){
        view.frame.origin.y = 0
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
    }
    
    
    // MARK: Generate and Save MemedImage

    func generateMemedImage() -> UIImage{
        //TODO: Hide toolba and navbar
        toolBar.isHidden = true
        navBar.accessibilityElementsHidden = true
        
        //Render view to an image
        UIGraphicsBeginImageContext(imagePickerView.frame.size)//self.view.frame.size)
        
        innerView.drawHierarchy(in: imagePickerView.frame, afterScreenUpdates: true)
        let memedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        //TODO: Show toolbar and navbar
        toolBar.isHidden = false
        navBar.accessibilityElementsHidden = false
        
        return memedImage
    }

    func save() {
        let meme = Meme(topText: topTextField.text!, bottomText: buttomTextField.text!, originalImage: imagePickerView.image!, memedImage: generateMemedImage())
        //add it to the memes array on the application delegate
        (UIApplication.shared.delegate as! AppDelegate).memes.append(meme)
        print("count in editorviewcontroller : \((UIApplication.shared.delegate as! AppDelegate).memes.count)")
    }
    
    // MARK: show prev viewcontroller state
    @IBAction func showPrevViewState(_ sender: Any) {
        if imagePickerView.image != nil{
            imagePickerView.image = nil
            prevViewButton.title = "MoveBack"
            shareButton.isEnabled = false
        }else{
            navigationController?.popToRootViewController(animated: true)
        }
    }
    
}


