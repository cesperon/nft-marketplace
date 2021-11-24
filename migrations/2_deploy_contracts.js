// eslint-disable-next-line no-undef
const HoopSpace = artifacts.require("HoopSpace");
//grab contract name not file name deploy contract
export default function (deployer) {
  deployer.deploy(HoopSpace);
}
