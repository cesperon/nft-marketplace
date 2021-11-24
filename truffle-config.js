export const networks = {
  // Useful for testing. The `development` name is special - truffle uses it by default
  // if it's defined here and no other network is specified at the command line.
  // You should run a client (like ganache-cli, geth or parity) in a separate terminal
  // tab if you use this network and you must also set the `host`, `port` and `network_id`
  // options below to some value.
  //
  development: {
    host: "127.0.0.1", // Localhost (default: none)
    port: 7545, // Standard Ethereum port (default: none)
    network_id: "*", // Any network (default: none)
  },

  //direct truffle to contracts directory
  contracts_directory: "./src/contracts",
  contracts_build_directory: "./src/abis",
};
export const mocha = {
  // timeout: 100000
};
export const compilers = {
  solc: {
    //default version ^0.8.0
    version: "0.8.10", // Fetch exact version from solc-bin (default: truffle's version)
    // docker: true,        // Use "0.5.1" you've installed locally with docker (default: false)
    settings: {
      // See the solidity docs for advice about optimization and evmVersion
      optimizer: {
        enabled: false,
        runs: 200,
      },
      //  evmVersion: "byzantium"
    },
  },
};
