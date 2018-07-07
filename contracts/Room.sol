pragma solidity ^0.4.24;

contract Room {

    struct RoomInfo {
        address host;
        string title;
        uint price;
        bool isRegisted;
    }

    mapping(address => RoomInfo) public rooms;

    RoomInfo[] public roomByIndex;

    event RegistRoom(address _address, string _title, uint price);

    constructor() public{

    }


    function roomCount() public view returns (uint) {
        return roomByIndex.length;
    }

    function registRoom(string _title, uint _price) public{
        RoomInfo storage room = rooms[msg.sender];
        room.title = _title;
        room.price = _price;
        room.host = msg.sender;

        if (!room.isRegisted) {
            roomByIndex.push(room);
        }

        room.isRegisted = true;

        emit RegistRoom(msg.sender, _title, _price);
    }

    function getRoomName(address _address) public view returns(string){
        return rooms[_address].title;
    }

    function getRoomPrice(address _address) public view returns(uint){
        return rooms[_address].price;
    }

    function echoAccount(address _address) public pure returns(address){
        return _address;
    }

    function myAccount() public view returns(address){
        return msg.sender;
    }


}
