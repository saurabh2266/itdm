def getDashedMobileNumber(mobileNumber):
        number=mobileNumber.split(":")[-1]
        dashedMobileNumber=number[:4]+"-"+number[4:7]+"-"+number[7:]
        print("dashedMobileNumberdashedMobileNumberdashedMobileNumberdashedMobileNumber:",dashedMobileNumber)
        return dashedMobileNumber