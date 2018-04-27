#!/ust/bin/env python3
# coding:utf-8

# 查找三种资源文件
# 1.Sources（包括.m,.mm等可执行文件），起止符如下：
# /* Begin PBXSourcesBuildPhase section */
# /* End PBXSourcesBuildPhase section */
# 2.Frameworks（主要是添加的框架及库，包括.framework, .tdb, .a等），起止符如下：
# /* Begin PBXFrameworksBuildPhase section */
# /* End PBXFrameworksBuildPhase section */
# 3.Resources (主要是资源文件，包括xib, bundle, strings，xcassets等)，起止符如下：
# /* Begin PBXResourcesBuildPhase section */
# /* End PBXResourcesBuildPhase section */
# 各targets的文件添加数量上的不同，基本上都在以上这三个里面了


# 基本思想是，把该三类文件分别装入各target的临时文件，然后比较各文件的不同


import sys
import os
import subprocess

#步骤1，创建各targets临时文件，起止符如下：
# /* Begin PBXNativeTarget section */
# /* End PBXNativeTarget section */

pbxprojPath = sys.argv[1] + '/project.pbxproj'

print pbxprojPath
f = open(pbxprojPath)

fileReadLines = f.readlines()

fileContent = str(fileReadLines)

targetBegin = fileContent.find('/* Begin PBXNativeTarget section */') + len('/* Begin PBXNativeTarget section */')
targetEnd = fileContent.find('/* End PBXNativeTarget section */')

targetInfo = fileContent[targetBegin:targetEnd]

targetInfosList = targetInfo.split('};')

targetNamesList = []

tabLen = len("'\\t\\t\\t\\t")
for target in targetInfosList:
	targetSplits = target.split(' ')
	if len(targetSplits) >= 4: #如果没有第四个元素
		targetName = targetSplits[3]
		if targetName.find('Tests') == -1: #过滤带Tests的target
			targetNamesList.append(targetName)
			# sourcesIndex = targetSplits.index("Sources")
			# sourcesStr = targetSplits[sourcesIndex - 2]
			# sourcesList.append(sourcesStr[tabLen:])

			# frameworksIndex =  targetSplits.index("Frameworks")
			# frameworksStr = targetSplits[frameworksIndex - 2]
			# frameworksList.append(frameworksStr[tabLen:])

			# resourcesIndex =  targetSplits.index("Resources")
			# resourcesStr = targetSplits[resourcesIndex - 2]
			# resourcesList.append(resourcesStr[tabLen:])

			f1 = open(targetName, "w")
			#此两步清空文件
			f1.seek(0)
			f1.truncate() 
			f1.close()

# 步骤二 查找Sources
sourcesBegin = fileContent.find('/* Begin PBXSourcesBuildPhase section */') + len('/* Begin PBXSourcesBuildPhase section */')
sourcesEnd = fileContent.find('/* End PBXSourcesBuildPhase section */')
sourcesInfo = fileContent[sourcesBegin:sourcesEnd]

sourcesInfoList = sourcesInfo.split('};')

for sources in sourcesInfoList:
	sourcesIndex = sourcesInfoList.index(sources)
	sourcesList = []

	if sources.find('files = (') != -1 and sourcesIndex < len(targetNamesList):
		filesBegin = sources.index('files = (') + len('files = (')
		filesEnd = sources.index(');')
		filesStr = sources[filesBegin:filesEnd]
		filesInfoList = filesStr.split('*/,')

		for filesInfo in filesInfoList:
			filesInfoStr = filesInfo.split(' ')
			if len(filesInfoStr) >= 3:
					sourcesList.append(filesInfoStr[3])
		sourcesList.sort()
		f2 = open(targetNamesList[sourcesIndex], 'r+')
		for i in sourcesList:
			f2.write(str(i)+'\r\n')
		f2.close()

# 步骤三 查找framework
f.seek(0)
frameworksBegin = fileContent.find('/* Begin PBXFrameworksBuildPhase section */') + len('/* Begin PBXFrameworksBuildPhase section */')
frameworksEnd = fileContent.find('/* End PBXFrameworksBuildPhase section */')
frameworksInfo = fileContent[frameworksBegin:frameworksEnd]

frameworksInfoList = frameworksInfo.split('};')

for frameworks in frameworksInfoList:
	frameworksIndex = frameworksInfoList.index(frameworks)
	frameworksList = []

	if frameworks.find('files = (') != -1 and frameworksIndex < len(targetNamesList):
		filesBegin = frameworks.index('files = (') + len('files = (')
		filesEnd = frameworks.index(');')
		filesStr = frameworks[filesBegin:filesEnd]
		filesInfoList = filesStr.split('*/,')

		for filesInfo in filesInfoList:
			filesInfoStr = filesInfo.split(' ')
			if len(filesInfoStr) >= 3:
					frameworksList.append(filesInfoStr[3])
		frameworksList.sort()
		f3 = open(targetNamesList[frameworksIndex], 'a+')
		for i in frameworksList:
			f3.write(str(i)+'\r\n')
		f3.close()

# 第三步 查找resources
f.seek(0)
resourcesBegin = fileContent.find('/* Begin PBXResourcesBuildPhase section */') + len('/* Begin PBXResourcesBuildPhase section */')
resourcesEnd = fileContent.find('/* End PBXResourcesBuildPhase section */')
resourcesInfo = fileContent[resourcesBegin:resourcesEnd]

resourcesInfoList = resourcesInfo.split('};')

for resources in resourcesInfoList:
	resourcesIndex = resourcesInfoList.index(resources)
	resourcesList = []

	if resources.find('files = (') != -1 and resourcesIndex < len(targetNamesList):
		filesBegin = resources.index('files = (') + len('files = (')
		filesEnd = resources.index(');')
		filesStr = resources[filesBegin:filesEnd]
		filesInfoList = filesStr.split('*/,')

		for filesInfo in filesInfoList:
			filesInfoStr = filesInfo.split(' ')
			if len(filesInfoStr) >= 3:
					resourcesList.append(filesInfoStr[3])
		resourcesList.sort()
		f4 = open(targetNamesList[resourcesIndex], 'a+')
		for i in resourcesList:
			f4.write(str(i)+'\r\n')
		f4.close()
f.close()


subprocess.call(['diff', targetNamesList[0], targetNamesList[1]])

for file in targetNamesList:
	os.remove(file)
