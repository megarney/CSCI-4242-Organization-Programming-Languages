
import std/random
import std/strutils
import std/math
import times, os

let start = epochTime()

randomize()

var
    randomFile: string
    min, max, mean, median: int
    randomSeq, mode: seq[int]
    sd: float

proc writeRandomNumbers() = 
    writeFile("randomNumbers.txt", "")
    let f = open("randomNumbers.txt", fmwrite)
    defer: f.close()

    for i in countup(1,100000):
        f.writeLine(rand(100000))
writeRandomNumbers()

proc readRandomNumbers() =
    for line in lines "randomNumbers.txt":
        randomSeq.add(parseInt(line))
readRandomNumbers()

template loop(body: untyped): typed = 
    while true:
        body

template until(cond: typed): typed = 
    if cond: break

proc sortSeq() =
    for i in countup(1, randomSeq.len-1):
        var j = i
        loop:
            if randomSeq[j] < randomSeq[j-1]: 
                var temp = randomSeq[j]
                randomSeq[j] = randomSeq[j-1]
                randomSeq[j-1] = temp
                j = j-1
            until j <= 0 or randomSeq[j] >= randomSeq[j-1]
sortSeq()

proc findMin() =
    min = randomSeq[0]
    echo "Min: ", min
findMin()

proc findMax() = 
    max = randomSeq[randomSeq.len-1]
    echo "Max: ", max
findMax()

proc findMeanMode() = 
    var count = 1
    var current = 1
    mode.add(randomSeq[0])
    for i in countup(0, randomSeq.len-1):
        if i > 0 and randomSeq[i] == randomSeq[i-1]:
            if randomSeq[i] == randomSeq[i-current]:
                current = current+1
            else:
                current = 2
            if current > count:
                count = current
                mode = @[]
                mode.add(randomSeq[i])
            elif current == count:
                mode.add(randomSeq[i])
        elif i > 0 and current == 1:
            mode.add(randomSeq[i])
        mean += randomSeq[i]
    mean = mean div randomSeq.len
    echo "Mean:", mean
    echo "Mode:", mode
findMeanMode()

proc findMedian() = 
    if(randomSeq.len mod 2 == 0):
        median = (randomSeq[randomSeq.len div 2] + randomSeq[(randomSeq.len div 2) - 1]) div 2
    else:
        median = randomSeq[(randomSeq.len div 2)]
    echo "Median:", median
findMedian()

proc findStandardDeviation() = 
    var current = 0
    sd = 0
    for i in countup(0, randomSeq.len-1):
        current = (randomSeq[i] - mean)
        sd = sd + (current.float*current.float)
    sd = sd / (randomSeq.len).float
    sd = sqrt(sd)
    echo "Standard Deviation:", sd.formatFloat(format = ffDecimal, precision = 3)
findStandardDeviation()

let fin = epochTime() - start
echo "Time: ", fin.formatFloat(format = ffDecimal, precision = 3), "s"