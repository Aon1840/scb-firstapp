//
//  PageOneViewController.swift
//  SCBios
//
//  Created by Attapon Peungsook on 8/7/2562 BE.
//  Copyright © 2562 SCB. All rights reserved.
//

import UIKit
import WebKit
import QRCodeReader

class PageOneViewController: UIViewController, WKNavigationDelegate, QRCodeReaderViewControllerDelegate {

    @IBOutlet weak var mWebView:WKWebView!
    @IBOutlet weak var mActivityIndicator:UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        openWebView()
        //  ถ้าไม่ใส่ callback จะไม่ถูกเรียก
        //  self = delefate object
        self.mWebView.navigationDelegate = self
    }
    
    func reader(_ reader: QRCodeReaderViewController, didScanResult result: QRCodeReaderResult) {
        reader.stopScanning()
        self.dismiss(animated: true, completion: nil)
        let alertVC = UIAlertController(title: "Scanning Result", message: result.value, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
    
    func readerDidCancel(_ reader: QRCodeReaderViewController) {
//
    }
    
//    lazy intial บอกว่าตัวแปรนี้มีค่านะ แต่รอก่อนนะ เดี๋ยวทยอยสร้าง
    
    lazy var readerVC: QRCodeReaderViewController = {
        let builder = QRCodeReaderViewControllerBuilder {
            $0.reader = QRCodeReader(metadataObjectTypes: [.qr], captureDevicePosition: .back)
            
            // Configure the view controller (optional)
            $0.showTorchButton        = false
            $0.showSwitchCameraButton = false
            $0.showCancelButton       = false
            $0.showOverlayView        = true
            $0.rectOfInterest         = CGRect(x: 0.2, y: 0.2, width: 0.6, height: 0.6)
        }
        
        return QRCodeReaderViewController(builder: builder)
    }()
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        self.mActivityIndicator.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.mActivityIndicator.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
//        Detect url if url == http://www.codemobiles.com/biz/contact.html
        if navigationAction.request.url?.absoluteString == "http://www.codemobiles.com/biz/contact.html" {

//            self.navigationController?.popViewController(animated: true)
            self.openScanner()
            decisionHandler(.cancel)
        } else {
            decisionHandler(.allow)
        }
    }
    
    func openScanner(){
        self.readerVC.delegate = self
        self.readerVC.modalPresentationStyle = .formSheet
        self.present(readerVC, animated: true, completion: nil)
    }

    
    @IBAction func onSegmentChanged(sender:AnyObject){
        switch sender.selectedSegmentIndex! {
        case 0:
            self.openWebView()
            break
        default:
            self.openPdf()
            break
        }
    }
    
    func openWebView(){
        print("Webview")
        
//        let url = URL(string: "https://www.pospos.co")

        let url = URL(string: "http://codemobiles.com")
        let req = URLRequest(url:url!)
        self.mWebView.load(req)
        
    }
    
    func openPdf(){
        print("Pdf")
        let pdfPath = Bundle.main.path(forResource: "product", ofType: "pdf")
        let pdfData = NSData(contentsOfFile: pdfPath!)
        self.mWebView.load(pdfData! as Data, mimeType: "application/pdf", characterEncodingName: "utf-8", baseURL: NSURL() as URL)
        print(pdfPath!)
    }

}
