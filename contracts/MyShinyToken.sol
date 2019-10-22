pragma solidity ^0.5.0;

contract MyShinyToken {

	// total available supply of token
	uint256 constant supply = 1000000;
	
	// event to be emitted on transfer
  	event Transfer(address indexed _from, address indexed _to, uint256 _value);

 	// event to be emitted on approval
  	event Approval(address indexed _owner, address indexed _spender, uint256 _value);
	
	// set up balances dictionary
	mapping (address => uint) public balances;
	
	// set up allowances dictionary
	// outer address is `_spender`, inner address is `_owner`
	mapping (address => mapping (address => uint) ) public allowances;
	
	// implement `totalSupply`
	// `pure` shows that we don't need the state of the contract to execute the function
	function totalSupply() public pure returns (uint256) {
    	return supply;
  	}
  	
  	// original contract creator owns total supply
  	// `constructor` environment run only on contract initialisation 
  	 constructor() public {
  	 	balances[msg.sender] = supply;
  	 }

  	// implement `balanceOf`
  	function balanceOf(address _owner) public view returns (uint256 balance) {
  		return balances[_owner];
  	}
  	
  	// implement `transfer`
  	function transfer(address _to, uint256 _value) public returns (bool) {    
  		address _from = msg.sender;
  		
	    // verify that sender has enough tokens
	    require(_value <= balances[_from]);
	    
	    // remove tokens from sender
	    balances[_from] -= _value;
	    
	    // add tokens to receiver
	    balances[_to] += _value;
	    
	    // TODO: verify everything worked?
	    
	    // emit success event
	    emit Transfer(_from, _to, _value);
	    return true;
  	}
  	
  	// implement `allowance`
  	function allowance(address _owner, address _spender) public view returns (uint256 remaining) {
    	return allowances[_spender][_owner];
  	}
  	
  	// implement `approve`
  	function approve(address _spender, uint256 _value) public returns (bool) {
  		address _owner = msg.sender;
  		
  		// set the allowance
    	allowances[_spender][_owner] = _value;
    	
    	// check everything went well
    	if (allowance(_owner, _spender) == _value) {
    		emit Approval(_owner, _spender, _value);
    		return true;
    	}
  	}
  	
  	// implement `transferFrom`
  	function transferFrom(address _from, address _to, uint256 _value) public returns (bool) {
    	address _spender = msg.sender;
    	
    	// check `_from` has enough tokens and `_spender` has sufficient allowance
    	require(_value <= balances[_from] && allowances[_spender][_from] >= _value);
    	
    	// remove tokens from sender
	    balances[_from] -= _value;
	    
	    // add tokens to receiver
	    balances[_to] += _value;
	    
	    // update allowance
	    allowances[_spender][_from] -= _value;
	    
	    // TODO: verify everything worked?
	    
	    // emit success event
	    emit Transfer(_from, _to, _value);
	    return true;
  	}
	
}
