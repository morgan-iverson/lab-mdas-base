#!/bin/bash

# # from lab-k8s-fundamentals

# export OUTPUT_DIR=exercises

# ytt -f templates \
#   -v SESSION_NAMESPACE=$SESSION_NAMESPACE \
#   -v INGRESS_DOMAIN=$INGRESS_DOMAIN \
#   -v POLICY_ENGINE=$POLICY_ENGINE \
#   --output-files $OUTPUT_DIR

# #create ytt templates from files in templates dir
# # inject data values -v name=value
# # send output file to exercise folders (replacing old .yaml files)
# # creates output dir if it does not exist

# find $OUTPUT_DIR -type d -exec chmod 755 {} \; 
# # find exercises -type d: get all directories in exercises 
# # -exec : Use output in next command
# # chmod 0755: change permissions User
# # Each number represents a 3 bit binary
# # The first number is Owner Permissions = 7 => 111 (read, write execute)
# # The second number is Group Permissions = 5 => 101 (read, no write, execute)
# # The third number is Other Permissions = 5 => 101 (read, no write, execute)

# find $OUTPUT_DIR -type f -exec chmod 644 {} \; 
# # find exercises -type f: get all files in exercises
# # chmod 644
# # User = 6 = 110 = read write
# #Group & Other = 4 = 100 = read