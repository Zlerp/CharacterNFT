# CharacterNFT with API3 QRNG Randomness
https://www.notion.so/modtech/Randomness-Onchain-621d4659b9df48828f8187f382b432a7
[https://github.com/api3dao/qrng-example/blob/main/contracts/QrngExample.sol](https://github.com/api3dao/qrng-example/blob/main/contracts/QrngExample.sol)

Using [API3](https://docs.api3.org/qrng) we can get VRF on chain.

Once you have your contract ready, when you deploy you need the `_AIRNODERRP` (make sure you select the network the you are deploying to):

[https://docs.api3.org/qrng/reference/chains.html](https://docs.api3.org/qrng/reference/chains.html)

Once deployed you need to set the QRNG Parameters:

[https://docs.api3.org/qrng/reference/providers.html#airnode](https://docs.api3.org/qrng/reference/providers.html#airnode)

The Sponsor wallet is the one making the request, it must be preloaded with funds to make the request.

```bash
// airnode:
0x9d3C147cA16DB954873A498e0af5852AB39139f2

****// xpub:
xpub6DXSDTZBd4aPVXnv6Q3SmnGUweFv6j24SK77W4qrSFuhGgi666awUiXakjXruUSCDQhhctVG7AQt67gMdaRAsDnDXv23bBRKsMWvRzo6kbf

// endpoint (single):
0xfb6d017bb87991b7495f563db3c8cf59ff87b09781947bb1e417006ad7f55a78

// endpoint (array):
0x27cc2713e7f968e4e86ed274a051a5c8aaee9cca66946f23af6f29ecea9704c3
```

Now we need to tell the Airnode which address we are going to have as the sponsor address by running this in our terminal:

the sponsor address is the contract address making the request to QRNG.

[https://docs.api3.org/airnode/v0.7/reference/packages/admin-cli.html#derive-sponsor-wallet-address](https://docs.api3.org/airnode/v0.7/reference/packages/admin-cli.html#derive-sponsor-wallet-address)

```bash
npx @api3/airnode-admin derive-sponsor-wallet-address \
  --airnode-xpub xpub6DXSDTZBd4aPVXnv6Q3SmnGUweFv6j24SK77W4qrSFuhGgi666awUiXakjXruUSCDQhhctVG7AQt67gMdaRAsDnDXv23bBRKsMWvRzo6kbf \
  --airnode-address 0x9d3C147cA16DB954873A498e0af5852AB39139f2 \
  --sponsor-address 0x6ABc5733E5E92E9d5635a640Ee8aae4D6423B244
```

This will return us a address to send funds to to load for the the VRF transaction cost.\

```bash
zhper@DESKTOP-VSM8UFM MINGW64 ~/Dev/nft/randomCharacter (main)
$ npx @api3/airnode-admin derive-sponsor-wallet-address \
>   --airnode-xpub xpub6DXSDTZBd4aPVXnv6Q3SmnGUweFv6j24SK77W4qrSFuhGgi666awUiXakjXruUSCDQhhctVG7AQt67gMdaRAsDnDXv23bBRKsMWvRzo6kbf \
>   --airnode-address 0x9d3C147cA16DB954873A498e0af5852AB39139f2 \
>   --sponsor-address 0x6ABc5733E5E92E9d5635a640Ee8aae4D6423B244
npx: installed 97 in 19.213s
Sponsor wallet address: 0xE19491fa82a738BA67c9670B65F15f4F5b227fb1
```

Now on your smart contract you can submit the Sponsor wallet address that was returned, and load it with funds top prep for VRF:

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/e0dd1776-4fb7-4f9e-a03f-fa72e3a379c6/Untitled.png)

[Moonbuilders Workshop: Using API3 QRNG for Randomness on Moonbeam](https://www.youtube.com/watch?v=SZm1apO9Bqw)

`Airnode`

0x9d3C147cA16DB954873A498e0af5852AB39139f2
`endpoint`

0xfb6d017bb87991b7495f563db3c8cf59ff87b09781947bb1e417006ad7f55a78

`sponsor wallet`

0xE19491fa82a738BA67c9670B65F15f4F5b227fb1
