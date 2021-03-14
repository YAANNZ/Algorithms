//
//  ViewController.swift
//  algorithms
//
//  Created by ZHUYN on 2021/2/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let vc = AlgTestViewController()
        self.view.addSubview(vc.view)
        vc.view.frame = self.view.bounds
        self.addChild(vc)
        print(vc.view)
        
   
//        var a = Array<CGRect>.init()
//        a.append(CGRect.init())
        
//        var a = Array<String>.init()
//        a.append(CGRect.init())
        
//        var a = Array<Any>.init()
//        a.append(nil)
        
//        var aTuple = (10, "Xishi")
        
//        var aTuple = (index: 10, name: "Xishi")
        
        let result = mergeArray([2,3,4,5,8], [1,2,5,8])
        print(result)
        
        let resultAry = filterString("abbadgggfh")
        print(resultAry)
    }
    
    
    
}


func mergeArray(_ aryA: Array<Int>, _ aryB: Array<Int>) -> Array<Int> {
    var ACount = aryA.count - 1
    var BCount = aryB.count - 1
    var totalCount = aryA.count + aryB.count - 1
    
    var repeatCount = 0
    var resultAry = aryA + aryB
    while BCount >= 0 {
        if ACount < 0 {
            resultAry[totalCount] = aryB[BCount]
            BCount -= 1
            totalCount -= 1
        } else {
            if aryB[BCount] < aryA[ACount] {
                resultAry[totalCount] = aryA[ACount]
                ACount -= 1
                totalCount -= 1
            } else if aryB[BCount] == aryA[ACount] {
                resultAry[totalCount] = aryA[ACount]
                ACount -= 1
                BCount -= 1
                totalCount -= 1
                repeatCount += 1
            } else {
                resultAry[totalCount] = aryB[BCount]
                BCount -= 1
                totalCount -= 1
            }
        }
    }
    
    while repeatCount > 0 {
        resultAry.removeFirst()
        repeatCount -= 1
    }
    
    return resultAry
}

func filterString(_ originalString: String) -> Array<String> {
    let originalAry = Array(originalString)
    var resultAry: Array<String> = []
    var lowLocation: Int = -1
    var highLocation: Int = 0
    for i in 0..<originalAry.count-1 {
        
        if originalAry[i] == originalAry[i+1] {
            if highLocation == 0 {
                lowLocation = i
                highLocation = i + 1
            } else {
                highLocation = i + 1
            }
        } else {
            if highLocation != 0 {
                let singleStr = String(originalAry[highLocation])
                var tempStr = singleStr
                while highLocation > lowLocation {
                    tempStr = tempStr + singleStr
                    highLocation -= 1
                }
                resultAry.append(tempStr)
                highLocation = 0
            }
        }
    }
    
    return resultAry
}


// 便利构造器？？？
extension UILabel {
    convenience init(frame: CGRect, text: String) {
        
        self.init()
        
    }
}
