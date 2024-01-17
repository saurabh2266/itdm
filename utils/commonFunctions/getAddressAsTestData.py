def getAddressAsTestData(address):
    _address=address.strip().split(",")
    lastline=address.strip().split(",")[-1].split(" ")
    adressWithoutLastLine=address.strip().split(",")[:-1]
    lastLineAsTestData=lastline[1][0]+lastline[2][0]+" "+lastline[3].split("\n")[0]
    # addressNumber=lastline[3].split("\n")[0]
    addressAsTestData=adressWithoutLastLine+[lastLineAsTestData]
    # print("", ".join(addressAsTestData).strip()----------------------->",",".join(addressAsTestData).strip())
    # return addressAsTestData
    return " ,".join(addressAsTestData).strip()

