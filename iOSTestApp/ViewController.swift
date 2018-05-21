//
//  ViewController.swift
//  iOSTestApp
//
//  Created by Dmitry Malakhov on 4/18/18.
//  Copyright © 2018 schwa.io. All rights reserved.
//

import UIKit
import SwiftUtilities

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let o = ObservableProperty(100)
        
        class C {
            init(){
                print("init")
            }
            deinit {
                print("deinit")
            }
        }
        
        var c: C = C()
        
        o.addObserver(c) { (i: Int) in
            print("i=\(i)")
        }
        
        o.value = 99
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            c = C()
        }
        o.value = 101
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

