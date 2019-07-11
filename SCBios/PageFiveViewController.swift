//
//  PageFiveViewController.swift
//  SCBios
//
//  Created by Attapon Peungsook on 8/7/2562 BE.
//  Copyright © 2562 SCB. All rights reserved.
//

import UIKit
import Alamofire

class PageFiveViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

//    Controller มันเปรียบเสมือหน้าจอนั้นแหละ
    var mImagePickerController:UIImagePickerController!
    @IBOutlet weak var mPreviewImage:UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.mImagePickerController = UIImagePickerController()
//        self.mImagePickerController.sourceType = .photoLibrary
        self.mImagePickerController.sourceType = .camera
        self.mImagePickerController.delegate = self
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // dismiss คือการปิด
        picker.dismiss(animated: true, completion: nil)
        let image = info[.originalImage] as! UIImage
        self.mPreviewImage.image = image
    }
    
    @IBAction func browerImage(){
        // เวลาอยากให้หน้าจอขึ้นต้อง present
        self.present(self.mImagePickerController, animated: true, completion: nil)
    }
    
    @IBAction func uploadImage(){
        let data = self.mPreviewImage.image?.jpegData(compressionQuality: 1.0)
        let name = "\(arc4random()).jpeg"
        self.upload("http://172.20.10.3:3000/uploads",name,data!)
    }
    
    func upload(_ url:String,_ name:String,_ data:Data){
        // stub
        let params = ["username":"admin", "password":"1234"]
        AF.upload(multipartFormData: { (formData) in
            // implement your form data
            
            formData.append(data, withName: "userfile", fileName: name, mimeType: "image/jpg")
            for(key,value) in params{
                formData.append(value.data(using: .utf8)!, withName: key)
            }
            
        }, to: url).responseString { response in
            // implement your response
            
            switch response.result {
            case let .success(value):
                print(value)
//                self.showNormalAlert(message:value)
                self.showCloseOutSideAlert(message:value)
                break
            case let .failure(error):
                print(error)
                break
            }
        }
    }
    
    func showCloseOutSideAlert(message:String) {
        let alertVC = UIAlertController(title: "Result", message: message, preferredStyle: .alert)
        //        อะไรที่เป็น VC ส่วนใหญ่ใช้ present, เมื่อ dialog เกิดจะเข้าใน closure box
        self.present(alertVC, animated: true) {
//            view คือ alert /superview คือ container
//            addGesture ทำให้ ui ที่ไม่สามารถดัก event ได้สามารถทำได้ ex ใช้รูปภาพดัก gesture
            alertVC.view.superview?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.closeAlert)))
        }
    }
    
    @objc
    func closeAlert(){
        self.dismiss(animated: true, completion: nil)
    }
    
    func showNormalAlert(message:String) {
        let alertVC = UIAlertController(title: "Result", message: message, preferredStyle: .alert)
//        add ปุ่มปิด
        alertVC.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
//        อะไรที่เป็น VC ส่วนใหญ่ใช้ present
        self.present(alertVC, animated: true, completion: nil)
    }
    
}
