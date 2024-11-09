const { Client } = require('ssh2');
const fs = require('fs');
const path = require('path');

const conn = new Client();

const config = {
  host: '192.168.1.100',
  port: 22,
  username: 'pranav',
  password: process.env.UBUNTU1, // Access GitHub secret as environment variable
};

const localFilePath = path.resolve(__dirname, '../view_files.py');
const remoteFilePath = '/home/pranav/git_target/view_files.py';

conn.on('ready', () => {
  console.log('SSH connection established.');

  // Step 1: Copy the Python script to the remote server
  conn.sftp((err, sftp) => {
    if (err) {
      console.error(`SFTP Error: ${err.message}`);
      conn.end();
      return;
    }

    const readStream = fs.createReadStream(localFilePath);
    const writeStream = sftp.createWriteStream(remoteFilePath);

    writeStream.on('close', () => {
      console.log('File copied successfully.');

      // Step 2: Execute the Python script on the remote server
      conn.exec(`python3 ${remoteFilePath}`, (err, stream) => {
        if (err) {
          console.error(`Execution Error: ${err.message}`);
          conn.end();
          return;
        }

        stream
          .on('close', (code) => {
            console.log(`Script executed with exit code ${code}`);
            conn.end();
          })
          .on('data', (data) => {
            console.log(`OUTPUT: ${data}`);
          })
          .stderr.on('data', (data) => {
            console.error(`ERROR: ${data}`);
          });
      });
    });

    readStream.pipe(writeStream);
  });
}).connect(config);
