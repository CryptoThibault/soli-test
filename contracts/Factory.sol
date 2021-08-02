// SPDX-License-Identifier: MIT

pragma solidity ^0.8.5;

import "./Token.sol";
import "./Dao.sol";
import "./Management.sol";

contract Factory {
    struct Business {
        string name;
        string url;
        address author;
        uint256 creation;
        Token token;
        Dao dao;
        Management management;
    }

    mapping(uint256 => Business) private _businessIds;
    uint256 counter;

    function create(string memory name_, string memory url_)
        public
        returns (bool)
    {
        counter++;
        _businessIds[counter] = Business({
            name: name_,
            url: url_,
            author: msg.sender,
            creation: block.timestamp,
            token: new Token(),
            dao: new Dao(),
            management: new Management()
        });
        return true;
    }
}
