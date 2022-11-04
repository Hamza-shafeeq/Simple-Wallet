pragma solidity ^0.8.10;

import "./Allowance.sol";


contract SimpleWallet is Allowance{

    event MoneyReceived(address indexed _byWho ,uint _currentAmount, uint _oldAmount , uint _walletAmount);
    event moneyWithdrawn(address indexed  _byWho , uint _withdrawnAmount);

    function deposit() external payable{
        emit MoneyReceived(msg.sender , msg.value, (address(this).balance - msg.value) , address(this).balance);
    }

    function renounceOwnership() override public onlyOwner {
        revert("Cant do this");
    }

    function withdrawMoney(address payable _to, uint _amount) public ownerOrAllowed(_amount) {
        require(_amount <= address(this).balance , "Not enough Funds");
        if(!(msg.sender == owner())){
            reduceAllowance(msg.sender, _amount);
        }
        emit moneyWithdrawn(msg.sender, _amount);
        _to.transfer(_amount);
    }
    

      
 


}