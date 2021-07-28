// SPDX-License-Identifier: MIT

pragma solidity ^0.8.5;

contract Management {
    mapping(address => bool) private _authorized;
    mapping(address => uint256) private _salarys;

    uint256 public constant TIME = 30 days;

    modifier onlyAuthorized() {
        require(
            _authorized[msg.sender],
            "Management: reserved to authorized users"
        );
        _;
    }

    function employ(address account, uint256 salary)
        public
        onlyAuthorized
        returns (bool)
    {
        _salarys[account] = salary;
        return true;
    }

    function fire(address account) public onlyAuthorized returns (bool) {
        _salarys[account] = 0;
        return true;
    }

    function salaryOf(address account) public view returns (uint256) {
        return _salarys[account];
    }

    function _inverseAuthorization(address account) private {
        _authorized[account] = !_authorized[account];
    }
}
