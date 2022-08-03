// SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@api3/airnode-protocol/contracts/rrp/requesters/RrpRequesterV0.sol";


contract CharacterNFT is Ownable, ERC721, RrpRequesterV0 {

    struct Character {
        uint256 strength;
        uint256 intelligence;
        string name;
    }

    Character[] public characters;

    address public airnode;
    bytes32 public endpointId;
    address public sponsorWallet;

    // Boolean set true if request has been fulfilled awaitingFullfillment
    mapping(bytes32 => bool) public awaitingRequestIDFullfillment;

    // maps the requestID to addrress so we know what address initiated request
    mapping(bytes32 => address) public requestIdToSender;

    // stores mapping of the name so we can reuse it when the response is back so that we can mint the NFT
    mapping(bytes32 => string) public requestToName;

    constructor(address _airnodeRrp) RrpRequesterV0(_airnodeRrp) ERC721("Scrap Token", "SCRAP") {

    }

    // sets the paramaters to enable use of QRNG
    function  setParameters(
        address _airnode,
        bytes32 _endpointId,
        address _sponsorWallet
    ) external onlyOwner {
        airnode = _airnode;
        endpointId = _endpointId;
        sponsorWallet = _sponsorWallet;
    }

    //requestRandom
    function requestCharacter( string memory _name) public returns (bytes32) {
        bytes32 requestId = airnodeRrp.makeFullRequest(
            airnode, // address of ANU node that fullfills QRNG
            endpointId, // ID of the endpoint the request is hitting
            address(this), // Sponsor Address
            sponsorWallet,
            address(this), // Address of contract that request get's fulfilled
            this.mintCharacter.selector, // which function we want to call in the contract
            "" // extra parameters you want to pass to request
        );
        awaitingRequestIDFullfillment[requestId] = true;
        requestIdToSender[requestId] = msg.sender;
        requestToName[requestId] = _name;
        return requestId;
    }

    // fullFillingRandomNumber
    // Only Airnode can call this function.
    // There is a function to get multiple random numbers in one call.
    function mintCharacter(bytes32 _requestId, bytes calldata data ) public onlyAirnodeRrp {
        require(awaitingRequestIDFullfillment[_requestId], "Request not waiting to be fulfilled");
        uint256 randomNumber = abi.decode(data, (uint256));
        uint256 id = characters.length;
        uint256 strength = randomNumber % 1000;
        uint256 intelligence = randomNumber % 100;
        characters.push(
            Character(strength, intelligence, requestToName[_requestId])
        );
        _safeMint(requestIdToSender[_requestId], id );
    }

    function viewCharacter( uint256 _tokenId) public view returns ( uint256, uint256) {
        return(characters[_tokenId].strength, characters[_tokenId].intelligence);
    }

}
