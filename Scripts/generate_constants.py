#!/usr/bin/env python

import sys, os
import xml.etree.ElementTree as et

PREFIX = ""

segueIdentifiers = {}
controllerIdentifiers = {}
reuseIdentifiers = {}

segueIDConst = "SegueID"
screenIDConst = "ScreenID"
cellIDConst = "CellID"

def addSegueIdentifier(identifier):
	key = identifier[0].upper() + identifier[1:]
	if not key.startswith(PREFIX.upper()):
		key = PREFIX.upper() + key
	
	segueIdentifiers[key] = identifier

def addControllerIdentifier(identifier):
    key = identifier[0].upper() + identifier[1:]
    if not key.startswith(PREFIX.upper()):
        key = PREFIX.upper() + key
    
    controllerIdentifiers[key] = identifier

def addReuseIdentifier(identifier):
  key = identifier[0].upper() + identifier[1:]
  if not key.startswith(PREFIX.upper()):
    key = PREFIX.upper() + key

  reuseIdentifiers[key] = identifier

def process_storyboard(file):
    tree = et.parse(file)
    root = tree.getroot()
    
    for segue in root.iter("segue"):
        segueIdentifier = segue.get("identifier")
        if segueIdentifier == None:
            continue
        segueIdentifier = segueIdentifier + segueIDConst
        addSegueIdentifier(segueIdentifier)
    
    for controller in root.findall(".//*[@storyboardIdentifier]"):
        controllerIdentifier = controller.get("storyboardIdentifier")
        if controllerIdentifier == None:
            continue
        controllerIdentifier = controllerIdentifier + screenIDConst
        addControllerIdentifier(controllerIdentifier)

    for cell in root.findall(".//*[@reuseIdentifier]"):
      reuseIdentifier = cell.get("reuseIdentifier")
      if reuseIdentifier == None:
        continue
      reuseIdentifier = reuseIdentifier + cellIDConst
      addReuseIdentifier(reuseIdentifier)

def writeHeader(file, identifiers):
    constants = sorted(identifiers.keys())
    
    for constantName in constants:
        file.write("extern NSString *const " + constantName + ";\n")

def writeImplementation(file, identifiers):
    constants = sorted(identifiers.keys())
    
    for constantName in constants:
        identifier = identifiers[constantName]

        print identifier

        if segueIDConst in identifier:
            print "1"
            identifier = identifier.replace(segueIDConst, "")
        elif screenIDConst in identifier:
            print "2"
            identifier = identifier.replace(screenIDConst, "")
        elif cellIDConst in identifier:
            print "3"
            identifier = identifier.replace(cellIDConst, "")
        
        file.write("NSString *const " + constantName + " = @\"" + identifier + "\";\n")

count = os.environ["SCRIPT_INPUT_FILE_COUNT"]
for n in range(int(count)):
    process_storyboard(os.environ["SCRIPT_INPUT_FILE_" + str(n)])

with open(sys.argv[1], "w+") as header:
    header.write("/* Generated document. DO NOT CHANGE */\n\n")
    header.write("/* Segue identifier constants */\n")
    header.write("@class NSString;\n\n")
    writeHeader(header, segueIdentifiers)
    
    header.write("\n")
    header.write("/* Controller identifier constants */\n")
    
    writeHeader(header, controllerIdentifiers)

    header.write("\n")
    header.write("/* Reuse identifier constants */\n")

    writeHeader(header, reuseIdentifiers)

    header.close()

with open(sys.argv[2], "w+") as implementation:
    implementation.write("/* Generated document. DO NOT CHANGE */\n\n")
    implementation.write("#import <Foundation/Foundation.h>\n\n")
    writeImplementation(implementation, segueIdentifiers)
    implementation.write("\n")
    
    writeImplementation(implementation, controllerIdentifiers)
    implementation.write("\n")

    writeImplementation(implementation, reuseIdentifiers)
    implementation.write("\n")

    implementation.close()

