const MyShinyToken = artifacts.require("MyShinyToken");

module.exports = function(deployer) {
	deployer.deploy(MyShinyToken);
};