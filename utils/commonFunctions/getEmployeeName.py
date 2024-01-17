def getEmployeeName(name):
    firstName = name.split()[0]
    lastName = name.split()[-1]

    fullname = {
        "firstName": firstName,
        "lastName": lastName
    }

    return fullname


