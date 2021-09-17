//
//  Utils.swift
//  WarmGreeting
//
//  Created by Olha Bilanyk on 17.09.2021.
//

import Foundation
public class Utils {
   public func evaluateProblem(problemNumber: Int, problemBlock: () -> Void) {
        let start = DispatchTime.now()
        problemBlock()
        let end = DispatchTime.now()
        let nanoTime = end.uptimeNanoseconds - start.uptimeNanoseconds
        let timeInterval = Double(nanoTime) / 1_000_000_000 //

        print("Time to evaluate problem \(problemNumber): \(timeInterval) seconds")
    }
}
