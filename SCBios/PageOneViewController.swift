//
//  PageOneViewController.swift
//  SCBios
//
//  Created by Attapon Peungsook on 8/7/2562 BE.
//  Copyright © 2562 SCB. All rights reserved.
//

import UIKit
import WebKit

class PageOneViewController: UIViewController, WKNavigationDelegate {

    @IBOutlet weak var mWebView:WKWebView!
    @IBOutlet weak var mActivityIndicator:UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        openWebView()
        //  ถ้าไม่ใส่ callback จะไม่ถูกเรียก
        //  self = delefate object
        self.mWebView.navigationDelegate = self
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        self.mActivityIndicator.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.mActivityIndicator.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if navigationAction.request.url?.absoluteString == "http://www.codemobiles.com/biz/contact.html" {
            self.navigationController?.popViewController(animated: true)
            decisionHandler(.cancel)
        } else {
            decisionHandler(.allow)
        }
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
