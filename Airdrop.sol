pragma solidity ^0.4.11;

contract Ownable {
  address public owner;

  function Ownable() {
    owner = msg.sender;
  }

  modifier onlyOwner() {
    if (msg.sender != owner) {
      throw;
    }
    _;
  }
  function transferOwnership(address newOwner) onlyOwner {
    if (newOwner != address(0)) {
      owner = newOwner;
    }
  }
}

contract Token{
  function transfer(address to, uint value) returns (bool);
}

contract Airdrop is Ownable {
    
    function multisend(address _tokenAddr, address[] _to, uint256[] _value, uint limit)
    returns (bool _success) {
        require(_to.length == _value.length);
        require(_to.length <= limit);
        // loop through to addresses and send value
        for (uint i = 0; i < _to.length; i++) {
                require((Token(_tokenAddr).transfer(_to[i], _value[i])) == true);
            }
            return true;
        }
}
