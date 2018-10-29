# [H]ERC777 : The Human Protocol 

# AS OF 10/29/2018 HERCULES SEZC WILL NOT BE LAUNCHING ON THE 777 STANDARD 
`in an emergency pivot we have decided to rely on the ERC20 Standard we know and love. This will ensure the security and stability of our token moving forward as better scientists iron out the details of the 777 Standard`
 

(H)ERC777 is a new supply chain token standard that relies on ERC820 (Contract pseudo-introspection registry)
 and solves ERC20’s problems, such as lack of transaction handling mechanisms that led to the loss of millions of dollars 
from the Ethereum ecosystem. In short, (H)ERC777 focuses on adoption by offering a wide range of transaction handling 
mechanisms and global value chain methods. 

# Benefits
The main advantage of (H)ERC777 is that it uses a new method of recognizing the contract interface. 
This standard assumes that there is a central registry of contracts on Ethereum’s network  (this is defined in ERC820). 
Everyone can invoke this registry to know if a certain address (it doesn’t matter if this address is a contract or not)
 supports a certain set of functions i.e. `interface`.

One of the main problems of Ethereum is the inability to know what functions the contract implements. 
ERC820 is intended to solve this. (H)ERC777 takes advantage of this approach and allows for easier logic handling in 
the Hercules dApp.
--------
On the other hand, the HERC tokens implements ERC20’s default functions alongside with the new (H)ERC777 functions 
(ie backward compatible). This guarantees a good network effect for this new token standard and faster adoption. 
As the industry has shown, the fluctuation of token price is due to their placement on exchanges. 

Token developers leveraging the (H)ERC777 will be able to deploy to most any exchange due to the backward compatibility. 
It is easier for exchanges to support a token that implements legacy ERC20 functions (it doesn’t matter if these functions 
contain bugs or not) without any research on newer functionalities of new token standards. The easier it is for exchanges
 to support tokens on a new standard, the more developers will use it. This boosts the adoption of (H)ERC777, while ERC223 
lacks this property.

# What’s different?
This token standard defines a completely new set of functions i.e. `send` functions instead of `transfer` functions. 
`authoriseOperator` instead of `approve`. `tokensReceived` handler function instead of `tokenFallback` handler function.

Such an approach can guarantee that the functions of this standard will not cross and override with functions of any other 
token standard, thus it is possible to make a token that will be compatible with (H)ERC777 and ERC820 standards simultaneously.

# At last, 
(H)ERC777 standardizes Mint and Burn functionality of tokens which is important for the mintableAssetToken (mAT)
 protocol in which the first use of is the AnthemGold (AGLD). The AGLD is minted when a gold bar is validated through the 
supply chain to the vault. The HERC tokens are burned at a rate of .000068 HERC / transaction to elevate the scarcity model 
of the ecosystem.

Ropsten : 
https://ropsten.etherscan.io/token/0xc443f11cfa23c1b5a098a46cefb76cc998089a46
