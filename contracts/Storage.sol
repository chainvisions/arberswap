// SPDX-License-Identifier: UNLICENSED

pragma solidity 0.7.6;

contract Storage {
    
    address admin;

    constructor() {
        admin = msg.sender;
    }

    function setAdmin(address _admin) public {
        require(msg.sender == admin, "Storage: Caller is not admin");
        admin = _admin;
    }

    function isAdmin(address account) public view returns (bool) {
        return (account == admin);
    }

}