// SPDX-License-Identifier: MIT

pragma solidity ^0.8.5;

contract Fork {
    struct Post {
        address author;
        string text;
        uint256 parent_id;
        uint256 created_at;
        uint256 like;
        uint256 level;
    }

    mapping(uint256 => Post) private _id;
    mapping(uint256 => mapping(address => bool)) private _liked;
    uint256 counter;

    constructor(string memory text_) {
        post(text_, 0);
    }

    function post(string memory text_, uint256 parent_id_) public {
        require(exist(uint256(parent_id_)));
        uint256 from_level = levelOf(parent_id_);
        _id[counter] = Post({
            author: msg.sender,
            text: text_,
            parent_id: parent_id_,
            created_at: block.timestamp,
            like: 0,
            level: from_level + 1
        });
        counter++;
    }

    function like(uint256 id_) public {
        _liked[id_][msg.sender] ? _id[id_].like-- : _id[id_].like++;
        _liked[id_][msg.sender] = !_liked[id_][msg.sender];
    }

    function authorOf(uint256 id_) public view returns (address) {
        return _id[id_].author;
    }

    function textOf(uint256 id_) public view returns (string memory) {
        return _id[id_].text;
    }

    function levelOf(uint256 id_) public view returns (uint256) {
        return _id[id_].level;
    }

    function parentOf(uint256 id_) public view returns (uint256) {
        return _id[id_].parent_id;
    }

    function creationOf(uint256 id_) public view returns (uint256) {
        return _id[id_].created_at;
    }

    function likeOf(uint256 id_) public view returns (uint256) {
        return _id[id_].like;
    }

    function exist(uint256 id_) public view returns (bool) {
        return creationOf(id_) != 0;
    }
}
