pragma solidity ^0.4.24;

contract Reputation {
    enum Grade {VeryGood, Good, Normal, NotBad, Bad}

    // 평판 정보
    struct ReputationInfo {
        address writer;
        string comment;
        Grade grade;
    }

    // 호스트 평판
    mapping (address => ReputationInfo[]) hostReputation;
    // 게스트 평판
    mapping (address => ReputationInfo[]) guestReputation;

    // 호스트 평판 등록
    function setHostReputation(
        address _host,
        string _comment,
        uint8 _grade
    )
        internal
    {
        require(_host != msg.sender);
        ReputationInfo memory reputation = ReputationInfo(msg.sender, _comment, Grade(_grade));
        hostReputation[_host].push(reputation);
    }

    // 게스트 평판 등록
    function setGuestReputation(
        address _guest,
        string _comment,
        uint8 _grade
    )
        internal
    {
        require(_guest != msg.sender);
        ReputationInfo memory reputation = ReputationInfo(msg.sender, _comment, Grade(_grade));
        guestReputation[_guest].push(reputation);
    }

    // 등록 된 호스트 평판 개수
    function getHostReputationNumber(address _host)
    public
    view
    returns(uint256)
    {
        return hostReputation[_host].length;
    }

    function getGuestReputationNumber(address _guest)
    public
    view
    returns(uint256)
    {
        return guestReputation[_guest].length;
    }

    function getHostReputation(address _host, uint256 _id)
    public
    view
    returns(address writer, string comment, Grade grade)
    {
        ReputationInfo memory reputation = hostReputation[_host][_id];
        return (reputation.writer, reputation.comment, reputation.grade);
    }

    function getGuestReputation(address _guest, uint256 _id)
    public
    view
    returns(address writer, string comment, Grade grade)
    {
        ReputationInfo memory reputation = guestReputation[_guest][_id];
        return (reputation.writer, reputation.comment, reputation.grade);
    }
}