# cd to right directory - C:\Users\Meg\Documents\GitHub\CSCI-4242-Organization-Programming-Languages\creatingfile.nim
# run with nim c -r creatingfile.nim

import std/random
import std/strutils
import std/math
import times, os

let start = epochTime()

# Call randomize() once to initialize the default random number generator
# If this is not called, the same results will occur every time
randomize()

var
    randomFile: string
    min, max, mean, median: int
    # nim's sequence is similar to an arraylist
    randomSeq, mode: seq[int]
    sd: float

# proc refers to a procedure
proc writeRandomNumbers() = 
    # Create and open a file
    writeFile("randomNumbers.txt", "")
    # fmwrite constant specifies that we are opening the file for writing
    let f = open("randomNumbers.txt", fmwrite)
    # defer is an equivalent for a try..catch statement
    # will also close file object when you are done with it
    defer: f.close()

    # Write 100,000 random numbers from
    for i in countup(1,100000):
        # $() is a method of converting an int to a string
        # rand([number]) will return a random int between 0 and [number]
        f.writeLine(rand(100000))
writeRandomNumbers()

# read in the random numbers generated into the sequence
proc readRandomNumbers() =
    for line in lines "randomNumbers.txt":
        randomSeq.add(parseInt(line))
readRandomNumbers()

# loop and until function as a do while loop, because the tradition
# do while loop does not exist in Nim. Loop defines the do and until
# defines the condition(s) that must occur in order for the loop to 
# break
template loop(body: untyped): typed = 
    while true:
        body

template until(cond: typed): typed = 
    if cond: break

# Insertion Sort
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
                # sequence = @[] clears the sequence
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