#!/usr/bin/env python3
import argparse
import socket
import time

'''
Quickly send a udp packet to a required ip and port
'''

parser = argparse.ArgumentParser(description="Quickly send a UDP packet to a required port")

messageType = parser.add_mutually_exclusive_group(required=True)
messageType.add_argument('-m', '--message', metavar='', help="An ASCII message or string to send", type=str)
messageType.add_argument('-b', '--byte', metavar='', help="An integer representation of raw bytes to send", nargs='*', type=int)
messageType.add_argument('-x', '--hex', metavar='', help="A hex representation of raw bytes to send", nargs='*', type=str)

parser.add_argument('-a', '--ipAddress', metavar = '', help="Destination IP Address to send the packet to")
parser.add_argument('-p', '--port', metavar = '', help="Desitnation port to send to", type = int)
parser.add_argument('-v', '--verbose', help="Make it verbose!", action='store_true')
parser.add_argument('-r', '--repeat', metavar = '',help="How many times to resend the packet.", type = int)
parser.add_argument('-t', '--time', metavar = '', help = "Delay of resend packets", type = float, default=1.0)

args = parser.parse_args()

if args.verbose:
    print(args)


def sendPacket():
    s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    s.bind(('', 0))
    if args.message:
        message = bytes(args.message.encode('utf-8'))
    elif args.byte:
        message = bytearray(args.byte)
    elif args.hex:
        message = bytearray([int(x, 16) for x in args.hex])

    repeats = args.repeat if args.repeat else 1
    sleepTime = args.time if args.repeat else 0
    if args.verbose:
        print(f"Sending {message} on {socket.gethostname()} {repeats} time{'s' if repeats > 1 else ''} with a delay of {sleepTime}")
    for i in range(args.repeat if args.repeat else 1 ):
        s.sendto(message, (args.ipAddress if args.ipAddress else '0.0.0.0', args.port if args.port else 1234))
        time.sleep(sleepTime)
    s.close()

if __name__ == "__main__":
    
    sendPacket()