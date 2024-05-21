def initReg(fileSrc, fileDst):
    ops = fileSrc.read()
    numWords = int(len(ops) / 8)
    for i in range(numWords):
        print("RAM[%d] <= 16'h%s"%(i, ops[i * 8:i * 8 + 8]), file=fileDst)
    return

fDst = open('initReg.txt', 'w')
fSrc = open('test.txt', 'r')

initReg(fSrc, fDst)

fDst.close()
fSrc.close()