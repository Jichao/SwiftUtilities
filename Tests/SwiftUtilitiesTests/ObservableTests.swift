//
//  ObservableTests.swift
//  SwiftUtilities
//
//  Created by Jonathan Wight on 11/21/15.
//  Copyright © 2015 schwa.io. All rights reserved.
//

import XCTest

import SwiftUtilities

class ObservableTests: XCTestCase {
    
    func testAddObservable() {
        let o = ObservableProperty(1)
        let queue = DispatchQueue.main
        
        o.addObserver(self, queue: queue) { (value: Int) in
            print("value in observer=\(o.value) callbackValue=\(value)")
            //self.o.removeObserver(self)
            o.value = 3
        }
    }

    func testSimple() {
        
        let o = ObservableProperty(100)
        
        class C {
            init() {
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
        c = C()
        o.addObserver(c) { (i: Int) in
            print("new_i=\(i)")
        }
        o.value = 99

        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            print(c)
        }
    }
    
    func testPublisher() {
        
        let p = Publisher<String, String>()
        p.subscribe(self, messageKey: "Q") { (str) in
            print("got new message=\(str)")
        }
        _ = p.publish("Q", message: "first")
        
        p.unsubscribe(self)
        
        p.subscribe(self, messageKey: "Q") { (str) in
            print("got new message2=\(str)")
        }

        _ = p.publish("Q", message: "second")

        DispatchQueue.global().async {
            _ = p.publish("Q", message: "third")
            p.unsubscribe(self)
            _ = p.publish("Q", message: "no message")
        }
    }
}
