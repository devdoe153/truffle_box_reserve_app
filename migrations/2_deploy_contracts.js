/* eslint-disable no-undef */
var Reservation = artifacts.require("./Reservation.sol");
var Room = artifacts.require("./Room.sol");
var TemaToken = artifacts.require("./TemaToken.sol");


module.exports = function(deployer) {
    //async operation, returns an addres
    deployer.deploy(TemaToken).then(() => {
        /**
         * If Reservation constructor has no args
         * deployer.deploy(Reservation)
         *
         * If Reservation constructor has n args
         * deployer.deploy(Reservation, arg1, arg2, ...argn)
         */
        deployer.deploy(Reservation,TemaToken.address);
    });


    deployer.deploy(Room);

};