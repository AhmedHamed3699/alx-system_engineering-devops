This project is a Command line challenge.  
I used SFTP to transfer my screenshots to Sandbox, which is a remote machine.  

These are the steps I followed to transfer the images:  
- Navigate to directory containing images
- Run `sftp remote_hostname`
- Created a directory on the remote system
- Run `put ./*.png`
- Done! That's it 😃
