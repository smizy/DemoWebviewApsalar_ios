//
//  MainController.swift
//  DemoAppWebview
//
//  Created by usr0300789 on 2014/11/14.
//  Copyright (c) 2014年 smizy. All rights reserved.
//

import UIKit

class MainController: UITableViewController, UIWebViewDelegate {
    

    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var stopButton: UIBarButtonItem!
    @IBOutlet weak var refreshButton: UIBarButtonItem!
    @IBOutlet weak var rewindButton: UIBarButtonItem!
    @IBOutlet weak var forwardButton: UIBarButtonItem!
    
    @IBAction func doStop(sender: AnyObject) {
        webView.stopLoading()
    }
    
    @IBAction func doRefresh(sender: AnyObject) {
        webView.reload()
    }
    
    @IBAction func doRewind(sender: AnyObject) {
        if webView.canGoBack {
            webView.goBack()
        }
    }
    @IBAction func doForwad(sender: AnyObject) {
        if webView.canGoForward {
            return webView.goForward()
        }

    }
    
    func webView(view: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
   
        let url = request.URL
        let ext = url.pathExtension

        if url.scheme == "local" && ext == "html" {
            var basename = url.lastPathComponent?.stringByDeletingPathExtension
            if (basename != nil) {
                let myURL = NSBundle.mainBundle().URLForResource(basename!, withExtension: ext)
                let requestObj = NSURLRequest(URL: myURL!)
                webView.loadRequest(requestObj)
            }
            return false
        }
        println(url)
        println("shouldStartLoading:" + view.stringByEvaluatingJavaScriptFromString("typeof(Apsalar)")! )
        
        if view.stringByEvaluatingJavaScriptFromString("typeof(Apsalar)") == "undefined"  {
            // Inject Apsalar.JS in to the HTMLs
            if let path = NSBundle.mainBundle().pathForResource("Apsalar", ofType: "js") {
                if let possibleContent = String(contentsOfFile:path, usedEncoding: nil, error: nil) {
                    view.stringByEvaluatingJavaScriptFromString(possibleContent)
                }
            }
        }
        if Apsalar.processJSRequest(view, withURL:request) {
            // if processJSRequest handled this request it will return TRUE so
            // return NO (should not start load with request)
            return false;
        }
        return true
    }
    
    func webViewDidFinishLoad(view: UIWebView) {
        println("webViewDidFinishLoad:" + view.stringByEvaluatingJavaScriptFromString("typeof(Apsalar)")! )
        
//        if view.stringByEvaluatingJavaScriptFromString("typeof(Apsalar)") == "undefined"  {
//            // Inject Apsalar.JS in to the HTMLs
//            if let path = NSBundle.mainBundle().pathForResource("Apsalar", ofType: "js") {
//                if let possibleContent = String(contentsOfFile:path, usedEncoding: nil, error: nil) {
//                    view.stringByEvaluatingJavaScriptFromString(possibleContent)
//                }
//            }
//        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.s
        
        let myURL = NSBundle.mainBundle().URLForResource("index", withExtension: "html")
        
        let requestObj = NSURLRequest(URL: myURL!)
        webView.loadRequest(requestObj)
        
        webView.delegate = self
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}