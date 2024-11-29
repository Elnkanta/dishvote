# DishVote

DishVote is a simple decentralized voting application built on the Stacks blockchain using Clarity. It allows users to cast their vote for their favorite dish from a pre-defined list, ensuring transparency and immutability of the voting process.

## Features
- **Decentralized Voting**: Users can vote for their favorite dish from a fixed list of options.
- **Immutable Records**: Votes are stored transparently on the blockchain.
- **Minimal Complexity**: The application avoids complex state management and external dependencies.

## How it Works
1. A pre-defined list of dishes is available for voting.
2. Users cast their vote, and the app securely records it on the blockchain.
3. The total votes for each dish can be queried at any time.

## Requirements
- **Clarinet**: Ensure you have Clarinet installed for development and testing.
- **Stacks Blockchain**: DishVote operates on the Stacks blockchain using Clarity smart contracts.

## Usage
1. Clone the repository.
2. Navigate to the project directory.
3. Run `clarinet check` to verify the contract.
4. Deploy the contract to the Stacks blockchain using the appropriate tools.
5. Interact with the smart contract via the blockchain interface to vote and query results.

## Notes
- DishVote is designed to be simple and easy to use, avoiding unnecessary complexity in the contract logic.
- Ensure all dependencies are correctly installed before deployment.