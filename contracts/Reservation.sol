pragma solidity ^0.4.24;

import "./Room.sol";
import "./TemaToken.sol";
import "./TemaTokenMarket.sol";
import "./Reputation.sol";

contract Reservation is Room, Reputation {
    using SafeMath for uint256;

    enum ReservationState { Reserved, CheckedIn, CheckedOut }

    mapping(address => ReservationInfo) public reserves;

    TemaToken temaToken;
    uint256 public reward = 10;

    struct ReservationInfo {
        address host;
        string from;
        uint duration;
        uint256 totalPrice;
        ReservationState state;
    }

    event NewReserve(address _host, address _guest, string from, uint _duration);

    constructor(address _temaTokenAddress) public {
        temaToken = TemaToken(_temaTokenAddress);
    }

    function reserve(address _host, string _from, uint _duration) public{
        address guest = msg.sender;

        RoomInfo memory room = rooms[_host];
        uint totalPrice = room.price * _duration;

        require(temaToken.balanceOf(guest) >= totalPrice);

        ReservationInfo storage reservation = reserves[guest];
        reservation.host = _host;
        reservation.from = _from;
        reservation.totalPrice = totalPrice;
        // reservation.state = ReservationState.Reserved; //우선 체크인상태로 바로 설정.
        reservation.state = ReservationState.CheckedIn;
        reservation.duration = _duration;

        emit NewReserve(_host, guest, _from, _duration);
    }

    function checkout(string _comment, uint8 _grade) public {
        ReservationInfo storage reservation = reserves[msg.sender];
        // 체크인 상태인지 확인
        require(reservation.state == ReservationState.CheckedIn);
        // 체크아웃으로 변경
        reservation.state = ReservationState.CheckedOut;
        // 평판 작성
        setHostReputation(reservation.host, _comment, _grade);
        /*        // 평판 작성 보상
                temaToken.transferFrom(this, msg.sender, reward);*/
    }

    function claim(address _from, string _comment, uint8 _grade) public {
        ReservationInfo storage reservation = reserves[_from];
        // 체크아웃 상태인지 확인
        require(reservation.state == ReservationState.CheckedOut);
        // 호스트에게 토큰 전달
        temaToken.transferFrom(_from, msg.sender, reservation.totalPrice);
        // 평판 작성
        setGuestReputation(_from, _comment, _grade);
        /*        // 평판 작성 보상
                temaToken.transferFrom(this, msg.sender, reward);*/
    }
}