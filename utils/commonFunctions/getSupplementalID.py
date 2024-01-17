def getSupplementalID (id):
      idwithnoBrac=id.split(',')[0].split(':')[1]
      return(idwithnoBrac[:-1])