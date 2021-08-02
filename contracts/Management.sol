// SPDX-License-Identifier: MIT

pragma solidity ^0.8.5;

contract Management {
    struct Employee {
        address account;
        uint256 salary;
        uint256 recurrence;
        uint256 employed_at;
        uint256 last_payout;
    }
    mapping(address => bool) private _authorized;
    mapping(address => uint256) _employeesId;
    mapping(uint256 => Employee) private _employeesData;
    uint256 counter;

    modifier onlyAuthorized() {
        require(
            _authorized[msg.sender],
            "Management: reserved to authorized users"
        );
        _;
    }

    function employ(
        address account_,
        uint256 salary_,
        uint256 recurrence_
    ) public onlyAuthorized returns (bool) {
        counter++;
        _employeesId[account_] = counter;
        _employeesData[counter] = Employee({
            account: account_,
            salary: salary_,
            recurrence: recurrence_,
            employed_at: block.timestamp,
            last_payout: 0
        });
        return true;
    }

    function fire(address account) public onlyAuthorized returns (bool) {
        _employeesData[idOf(account)] = Employee({
            account: address(0),
            salary: 0,
            recurrence: 0,
            employed_at: 0,
            last_payout: 0
        });
        _employeesId[account] = 0;
        return true;
    }

    function idOf(address account) public view returns (uint256) {
        return _employeesId[account];
    }

    function salaryOf(address account) public view returns (uint256) {
        return _employeesData[idOf(account)].salary;
    }

    function payout() public onlyAuthorized returns (bool) {}

    function _inverseAuthorization(address account) private {
        _authorized[account] = !_authorized[account];
    }
}
