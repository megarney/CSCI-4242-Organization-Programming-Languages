# cd to right directory
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
        f.writeLine($(rand(100000)))
writeRandomNumbers()

var randomArray: array[10, int]

proc readRandomNumbers() =
    var index = 0
    for line in lines "randomNumbers.txt":
        randomArray[index] = parseInt(line)
        index += 1
readRandomNumbers()