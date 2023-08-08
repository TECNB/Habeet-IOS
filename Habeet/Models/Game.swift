//
//  Game.swift
//  Habeet
//
//  Created by TEC on 2023/8/8.
//

import Foundation

struct Game{
    var target:Int=Int.random(in: 1...100)
    var score:Int=0
    var round:Int=1
    
    func points(sliderValue:Int)->Int{
        var difference:Int
        if sliderValue>self.target {
            difference=sliderValue-self.target
        }else if sliderValue<self.target{
            difference=self.target-sliderValue
        }else{
            difference=0
        }
        let awardedPoints:Int=100-difference
        return awardedPoints
    }
}
