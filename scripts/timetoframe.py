#!/usr/bin/python3

import argparse
import re

# Setup the arg parser
parser = argparse.ArgumentParser()
parser.add_argument("time", type=str, help="colon separated time")
parser.add_argument(
    "-f", "--framerate", type=int, help="30", default=30, choices=[24, 25, 29, 30, 60]
)

args = parser.parse_args()


# Setup our framerates...
framesPerSecond = args.framerate
framesPerMinute = framesPerSecond * 60
framesPerHour = framesPerMinute * 60

# Split the time
splitTimeString = re.split("[\.\:\;]", args.time)

assert len(splitTimeString) == 4, "Time should have 4 parts separated by a ':'"


splitTime = [int(x) for x in splitTimeString]

# print(splitTime[0] < 23)

assert 0 < splitTime[0] < 23, f"Hour needs to be between 0 and 23: {splitTime[0]} "
assert 0 < splitTime[1] < 59, f"Minute needs to be between 0 and 59: {splitTime[1]}"
assert 0 < splitTime[2] < 59, f"Second needs to be between 0 and 59: {splitTime[2]}"
assert (
    0 < splitTime[3] < args.framerate
), f"frames needs to be between 0 and {args.framerate}: : {splitTime[3]}"


frameCount = (
    (splitTime[0] * framesPerHour)
    + (splitTime[1] + framesPerMinute)
    + (splitTime[2] + framesPerSecond)
    + splitTime[3]
)

print(frameCount)