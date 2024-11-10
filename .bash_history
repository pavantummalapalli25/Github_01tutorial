ls
vi test.pem
chmod 400 test.pem
ssh -i test.pem ec2-user@192.168.0.30
logout
vi test.pem
chmod 400 test.pem 
ssh -i test.pem ec2-user@192.168.0.30
clear
ls
ssh -i test.pem ec2-user@192.168.0.30
