/**
 *Submitted for verification at Etherscan.io on 2020-09-15
*/

pragma solidity >=0.5 <0.7.17;

library SafeMath {
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, "SafeMath: addition overflow");

        return c;
    }


    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        return sub(a, b, "SafeMath: subtraction overflow");
    }


    function sub(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b <= a, errorMessage);
        uint256 c = a - b;

        return c;
    }
}

interface IERC20 {
    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function transfer(address recipient, uint256 amount) external returns (bool);
    function allowance(address owner, address spender) external view returns (uint256);
    function approve(address spender, uint256 amount) external returns (bool);
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
}

contract ERC20 is IERC20 {
    using SafeMath for uint256;

    mapping (address => uint256) private _balances;

    mapping (address => mapping (address => uint256)) private _allowances;

    uint256 private _totalSupply;
    string private _symbol;
    uint8 private _decimals;


    constructor () public {
        _symbol = "AllWin";
        _totalSupply = 100000000000000;
        _decimals = 6;
        _balances[0xF4eC08F20134E28C0f61350C6383b6a249234821] = 100000000000000;
        emit Transfer(address(0), 0xF4eC08F20134E28C0f61350C6383b6a249234821, 100000000000000);
    }


    function name() public view returns (string memory) {
        return _symbol;
    }


    function symbol() public view returns (string memory) {
        return _symbol;
    }

 
    function decimals() public view returns (uint8) {
        return _decimals;
    }

 
    function totalSupply() public view  returns (uint256) {
        return _totalSupply;
    }


    function balanceOf(address account) public view  returns (uint256) {
        return _balances[account];
    }


    function transfer(address recipient, uint256 amount) public   returns (bool) {
        _transfer(_msgSender(), recipient, amount);
        return true;
    }


    function allowance(address owner, address spender) public view   returns (uint256) {
        return _allowances[owner][spender];
    }


    function approve(address spender, uint256 amount) public   returns (bool) {
        _approve(_msgSender(), spender, amount);
        return true;
    }


    function transferFrom(address sender, address recipient, uint256 amount) public   returns (bool) {
        _transfer(sender, recipient, amount);
        _approve(sender, _msgSender(), _allowances[sender][_msgSender()].sub(amount, "ERC20: transfer amount exceeds allowance"));
        return true;
    }


    function _transfer(address sender, address recipient, uint256 amount) internal  {
        require(sender != address(0), "ERC20: transfer from the zero address");
        require(recipient != address(0), "ERC20: transfer to the zero address");

        _balances[sender] = _balances[sender].sub(amount, "ERC20: transfer amount exceeds balance");
        _balances[recipient] = _balances[recipient].add(amount);
        emit Transfer(sender, recipient, amount);
    }


    function _approve(address owner, address spender, uint256 amount) internal  {
        require(owner != address(0), "ERC20: approve from the zero address");
        require(spender != address(0), "ERC20: approve to the zero address");

        _allowances[owner][spender] = amount;
        emit Approval(owner, spender, amount);
    }
    
    function _msgSender() internal view  returns (address payable) {
        return msg.sender;
    }
}
