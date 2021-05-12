//
//  Logger.swift
//  BaseNetwork
//
//  Created by Duy Truong on 10/05/2021.
//

import Foundation
import os.log

class Log {

    private static func log(tag: String, _ items: [Any]) {
        #if DEBUG
        let string = items.map { String(describing: $0) }.joined(separator: " ")
        print("\(tag) \(string)")
        #endif
    }

    static func d(_ items: Any...) {
        log(tag: "[DEBUG]", items)
    }

    static func i(_ items: Any...) {
        log(tag: "[INFO]", items)
    }

    static func w(_ items: Any...) {
        log(tag: "⚠️", items)
    }

    static func e(_ items: Any...) {
        log(tag: "‼️", items)
    }

    static func t(tag: String, _ items: Any...) {
        log(tag: tag, items)
    }

}
