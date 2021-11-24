// eslint-disable-next-line no-undef
const Migrations = artifacts.require("Migrations");

export default function (deployer) {
  deployer.deploy(Migrations);
}
