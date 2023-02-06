pragma solidity >= 0.4.22 < 0.9.0;

contract Will{
    address owner;
    bool deceased;
    uint fortune;
    address payable[] heirs;
    uint heirCount;
    mapping(address => uint) inheritance;

    constructor() public payable{
        owner = msg.sender;
        fortune = msg.value;
        // heirCount = 0;
        deceased = false
    }

    modifier onlyOwner{
        require(msg.sender == owner);
        _;
    }

    modifier mustBeDeceased{
        require(deceased == true);
        _;
    }

    function setDeceased() public onlyOwner{
        deceased = true;
        fortune = address(this).balance;
    }

    function setHeir(address payable heir) public onlyOwner{
        heirs.push(heir);
        heirCount++;
    }

    function distributeInheritance() public mustBeDeceased{
        for(uint i = 0; i < heirCount; i++){
            inheritance[heirs[i]] = fortune/heirCount;
        }
    }

}