pragma solidity ^0.8.10;
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/math/SafeMath.sol";


contract Allowance is Ownable{
    
    

    using SafeMath for uint;

    event AllowanceChanged(address indexed _forWho, address indexed _fromWhom, uint _oldAmount, uint _newAmout );
    
    mapping (address => uint) public allowance; 

    function reduceAllowance(address _who , uint _amount) internal{
        emit AllowanceChanged(_who , msg.sender , allowance[_who] , allowance[_who].sub(_amount));
        allowance[_who] = allowance[_who].sub(_amount);
    }

    modifier ownerOrAllowed(uint _amount){
        require(msg.sender == owner() || _amount <= allowance[msg.sender] , "Not Allowed");
        _;
    }

    
    function addAllowance(address _who , uint _amount) public onlyOwner {
        emit AllowanceChanged(_who, msg.sender , allowance[_who],  _amount);
        allowance[_who] = _amount;
    }    
}