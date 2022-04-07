pragma solidity ^0.8.13;

contract Escrow{

    address agent;
    mapping(address => uint256) public deposits;

    constructor(){
        agent = msg.sender;
    }

    modifier onlyAgent(){
        require(msg.sender == agent);
        _;
    }

    function deposit(address payee)public payable{
        uint256 amount = msg.value;
        deposits[payee] = deposits[payee] + amount;
    }

    function withdraw(address payable payee, address payable recipient) public onlyAgent{
        uint256 payment = deposits[payee];
        deposits[payee] = 0;
        recipient.transfer(payment);
    }
}