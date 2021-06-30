import Foundation

class CoronaClass {
 
     var seats = [Int]()
     var chairs = [Int]()
    
     init(n: Int) {
        for _ in 0..<n {
            chairs.append(0)
        }
     }
     
     func seat() -> Int {
        if seats.count == 0 {
            chairs[0] = 1
            seats.append(0)
            return 0
        }
        
        var result = -1
        var maxDistance = -1
        for i in 0..<chairs.count {
            if chairs[i] == 0 {
                var leftDist = -1
                var rightDist = -1
                
                if i != chairs.count - 1 {
                    for j in i + 1..<chairs.count {
                        if chairs[j] == 1 {
                            rightDist = abs(j - i)
                            break
                        }
                    }
                }
                if i != 0 {
                    for j in (0...i - 1).reversed() {
                        if chairs[j] == 1 {
                            leftDist = abs(j - i)
                            break
                        }
                    }
                }
                let dist: Int
                if rightDist == -1 {
                    dist = leftDist
                } else if leftDist == -1 {
                    dist = rightDist
                } else {
                    dist = min(leftDist, rightDist)
                }
                if dist > maxDistance {
                    maxDistance = dist
                    result = i
                }
            }
        }
        chairs[result] = 1
        seats.append(result)
        seats = seats.sorted()
        return result
     }
     
     func leave(_ p: Int) {
        chairs[p] = 0
        if let index = seats.firstIndex(of: p) {
            seats.remove(at: index)
        }
     }
}
