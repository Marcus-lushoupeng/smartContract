// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts@4.7.1/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts@4.7.1/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts@4.7.1/security/Pausable.sol";
import "@openzeppelin/contracts@4.7.1/access/Ownable.sol";
import "@openzeppelin/contracts@4.7.1/utils/Counters.sol";

contract MyToken is ERC721, ERC721Enumerable, Pausable, Ownable {
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIdCounter;

    constructor() ERC721("MyToke11n", "MT111K") {}

    function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
    }

    // function safeMint(address to) public  {
    //     uint256 tokenId = _tokenIdCounter.current();
    //     _tokenIdCounter.increment();
    //     _safeMint(to, tokenId);
    // }
    event print(uint);
    function safeMint(uint i) public payable {
        uint256  tokenId = _tokenIdCounter.current();
        require((balanceOf(msg.sender)+i)<6,"please don't take too much NFT");
        for(uint n=0; n<i; n++){
            // emit print(i);
            // emit print(tokenId);
        _safeMint(msg.sender, tokenId+n+1);
        _tokenIdCounter.increment();
        }

    }





    function _beforeTokenTransfer(address from, address to, uint256 tokenId)
        internal
        whenNotPaused
        override(ERC721, ERC721Enumerable)
    {
        super._beforeTokenTransfer(from, to, tokenId);
    }

    // The following functions are overrides required by Solidity.

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721Enumerable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}
