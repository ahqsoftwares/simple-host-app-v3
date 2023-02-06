const fs = require("fs");

const buffer = process.env.FILE;

const data = buffer.toString();

fs.writeFileSync("./android/key.jks", Buffer.from(data, "base64"));