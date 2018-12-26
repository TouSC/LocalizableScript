import os
import sys
import re

def getFileContent(path):
	file = open(path)
	content = file.read()
	return content

def getAllFile(path):
	filepaths = []
	for filename in os.listdir(path):
		filepath = os.path.join(path, filename)
		if (os.path.isdir(filepath)):
			filepaths += getAllFile(filepath)
		elif (filepath.endswith(".m")):
			filepaths += [filepath]
	return filepaths

filepaths = getAllFile(sys.argv[1])

readTranslates = []
filename = "Localizable.strings"
if os.path.exists('./'+filename):
	#read content
	readFile = open(filename, 'r')
	content = readFile.read()
	readTranslates = content.split('\n')
	readTranslates = list(map(lambda x: x+"\n", readTranslates))
	readTranslates = list(filter(lambda x: x!="\n", readTranslates))
	readFile.close()

wirteFile = open(filename, 'w')

translates = []
for filepath in filepaths:
	filename = os.path.basename(filepath)
	filename = filename.split(".")[0]
	if (filename=="Pods" or filename=="Index" or filename.endswith("Tests")):
		continue
	# translate = "//"+filename+"\n"+""
	content = getFileContent(filepath)
	rules = ['@"([@|%|\w|\u4e00-\u9fa5|\s]+)"']
	for rule in rules:
		regex = re.compile(rule)
		result = regex.findall(content)
		#print(result)
		
		for text in result:
			translates += ["\""+text+"\""+" = "+"\""+"\""+";\n"]
	
translates = sorted(translates, key=str.lower)	

lastTranslate = ""

if len(readTranslates)>0:
	print(translates)
	print("Override")
	i=0
	j=0

	while j<len(translates):
		translate = translates[j]
		readTranslate = readTranslates[i]
		if translate.split("=")[0]!=readTranslate.split("=")[0]:
			readTranslates+=[translates[j]]
			j+=1
		else:
			if i<len(readTranslates)-1:
				i+=1
			j+=1

	translates = sorted(readTranslates, key=str.lower)
for translate in translates:
	if translate==lastTranslate:
		continue
	lastTranslate = translate
	wirteFile.write(translate)
wirteFile.close()

print("Done")
		


