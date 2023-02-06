const fs = require("fs");

const buffer = fs.readFileSync(process.env.FILE);

const data = buffer.toString();

fs.writeFileSync("./key2.jks", Buffer.from(data, "base64"));