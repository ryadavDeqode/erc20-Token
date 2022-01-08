// SPDX-License-Identifier: GPL-3.0;
pragma solidity >=0.5.0;

// RYD Coin Smart Contract

contract RYD_ERC20 {

    // Coin name,symbol and decimals defined below
    string public constant name = "RYD Coin";
    string public constant symbol = "RYD";
    uint8 public constant decimals = 18;

    mapping(address => uint256) balances;

    mapping(address => mapping (address => uint256)) allowed;

    address owneradd; 

    // constructor to set the value of owner to the address of actuall owner 
    // of the contract


    // declaring the modifier to be used with the addPerson method
    /*
        this modifier makes sure that the method is accessed only by the actual owner.

    */
    modifier onlyOwner() {
        require(msg.sender == owneradd); // if returns true then only the method having this modifier will get executed
        _;
    }

    

    event Transfer(address indexed from, address indexed to, uint tokens);
    event Approval(address indexed tokenOwner, address indexed spender, uint tokens);

    uint256 totalSupply_;

    constructor(uint256 total) {
    owneradd = msg.sender;
    totalSupply_ = total;
    balances[msg.sender] = totalSupply_;
    }

    function totalSupply() public view returns (uint256) {
      return totalSupply_;
    }

    function balanceOf(address tokenOwner) public view returns (uint) {
        return balances[tokenOwner];
    }

    function transfer(address receiver, uint numTokens) public onlyOwner returns (bool) {
        require(numTokens <= balances[msg.sender]);
        balances[msg.sender] -= numTokens;
        balances[receiver] += numTokens;
        emit Transfer(msg.sender, receiver, numTokens);
        return true;
    }

    function approve(address delegate, uint numTokens) public onlyOwner returns (bool) {
        allowed[msg.sender][delegate] = numTokens;
        emit Approval(msg.sender, delegate, numTokens);
        return true;
    }

    function allowance(address owner, address delegate) public view returns (uint) {
        return allowed[owner][delegate];
    }

    function transferFrom(address owner, address buyer, uint numTokens) public onlyOwner returns (bool) {
        require(numTokens <= balances[owner]);
        require(numTokens <= allowed[owner][msg.sender]);

        balances[owner] -= numTokens;
        allowed[owner][msg.sender] -= numTokens;
        balances[buyer] += numTokens;
        emit Transfer(owner, buyer, numTokens);
        return true;
    }
}
