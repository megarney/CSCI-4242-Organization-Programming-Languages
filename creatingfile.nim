# cd to right directory - C:\Users\Meg\Documents\GitHub\CSCI-4242-Organization-Programming-Languages\creatingfile.nim
# run with nim c -r creatingfile.nim

import std/random
import std/strutils

# Call randomize() once to initialize the default random number generator
# If this is not called, the same results will occur every time
randomize()

var
    randomFile: string
    min, max, mean, median, mode, sd: int

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
    for i in countup(1,10):
        # $() is a method of converting an int to a string
        # rand([number]) will return a random int between 0 and [number]
        f.writeLine(rand(100000))
writeRandomNumbers()

# nim's sequence is similar to an arraylist
var randomSeq: seq[int]

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
    echo "Min:" 
    echo min
findMin()

proc findMax() = 
    max = randomSeq[randomSeq.len-1]
    echo "Max:" 
    echo max
findMax()

proc findMean() = 
    for i in countup(0, randomSeq.len-1):
        mean += randomSeq[i]
    mean = mean div randomSeq.len
    echo "Mean:"
    echo mean
findMean()

echo randomSeq

proc findMedian() = 
    if(randomSeq.len mod 2 == 0):
        median = (randomSeq[randomSeq.len div 2] + randomSeq[(randomSeq.len div 2) - 1]) div 2
    else:
        median = randomSeq[(randomSeq.len div 2)]
    echo "Median:"
    echo median
findMedian()