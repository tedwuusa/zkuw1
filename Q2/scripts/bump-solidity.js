const fs = require("fs");
const solidityRegex = /pragma solidity \^\d+\.\d+\.\d+/

const verifierRegex = /contract Verifier|contract PlonkVerifier/

var names = ["HelloWorld", "Multiplier3", "Multiplier3Plonk"];

for (const name of names) {
    let content = fs.readFileSync(`./contracts/${name}Verifier.sol`, { encoding: 'utf-8' });
    let bumped = content.replace(solidityRegex, 'pragma solidity ^0.8.0');
    bumped = bumped.replace(verifierRegex, `contract ${name}Verifier`);
    
    fs.writeFileSync(`./contracts/${name}Verifier.sol`, bumped);
}
