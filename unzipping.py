# #!/usr/bin/python
import os
from zipfile import ZipFile
PATH = "E:\\Emulation\\Roms\\compiled"
os.chdir(PATH)
for filename in os.listdir("."):
    if filename.endswith(".zip"):
        print(filename)
        try:
            with ZipFile(filename, 'r') as zObject:
                zObject.extractall(
                    path=PATH)
            # os.remove(filename)
        except:
            print('BROKEN!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!')







# # importing the zipfile module
# from zipfile import ZipFile
  
# # loading the temp.zip and creating a zip object
# with ZipFile("C:\\Users\\sai mohan pulamolu\\\
#             Desktop\\geeks_dir\\temp\\temp.zip", 'r') as zObject:
  
#     # Extracting all the members of the zip 
#     # into a specific location.
#     zObject.extractall(
#         path="C:\\Users\\sai mohan pulamolu\\Desktop\\geeks_dir\\temp")


# for filename in os.listdir("."):
#     if filename.endswith(".zip"):
#         print filename
#         name = os.path.splitext(os.path.basename(filename))[0]
#         if not os.path.isdir(name):
#             try:
#                 zip = zipfile.ZipFile(filename)
#                 os.mkdir(name)
#                 zip.extractall(path=name)
#             except zipfile.BadZipfile, e:
#                 print "BAD ZIP: "+filename
#                 try:
#                     os.remove(filename)
#                 except OSError as e: # this would be "except OSError, e:" before Python 2.6
#                     if e.errno != errno.ENOENT: # errno.ENOENT = no such file or directory
#                         raise # re-raise exception if a different error occured  