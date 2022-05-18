pragma solidity ^0.8.6;

import "erc721a/contracts/ERC721A.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract metatopia is ERC721A, Ownable{
    uint256 MAX_MINTS = 3;
    uint256 MAX_SUPPLY = 10000;
    uint256 public mintPrice = 0.001 ether;

    string public baseURI = "ipfs://bafybeia6o3qrdx7k53qsetrbwza74p2mmtkb43mcmrcg7bvogth6inelfm";

    constructor() ERC721A ("metatopia", "imfers"){}

    function mint(uint256 quantity) external payable {
    require(quantity + _numberMinted(msg.sender) <= MAX_MINTS, "exceeded minting amount");
    require(totalSupply() + quantity <=MAX_SUPPLY, "no tokens left");
    require(msg.value >= (mintPrice * quantity), "Not enough ether");
    _safeMint(msg.sender, quantity);
    }

    function withdraw() external payable onlyOwner{
        payable(owner()).transfer(address(this).balance);
    }

    function _baseURI() internal view override returns (string memory){
        return baseURI;
    }

    function setMintRate(uint256 _mintRate) public onlyOwner{
        mintPrice = _mintRate;
    }
}
