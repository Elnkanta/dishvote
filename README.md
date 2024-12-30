# DishVote

DishVote is an enhanced decentralized voting application built on the Stacks blockchain using Clarity. It allows users to cast their vote for their favorite dish from a dynamic list, ensuring transparency and immutability of the voting process.

## Features

- **Decentralized Voting**: Users can vote for their favorite dish from a flexible list of options.
- **Immutable Records**: Votes are stored transparently on the blockchain.
- **Dynamic Dish Management**: Admins can add new dishes to the voting list.
- **Voting Control**: Functionality to pause and resume voting as needed.
- **Advanced Vote Counting**: Enhanced algorithm to determine the winning dish.
- **Flexible Dish Retrieval**: Only active dishes are returned in vote queries.

## How it Works

1. A list of dishes is available for voting, which can be expanded by admins.
2. Users cast their vote, and the app securely records it on the blockchain.
3. The total votes for each dish can be queried at any time.
4. Admins can pause or resume voting, and add new dishes to the list.
5. The contract automatically calculates and provides the current winning dish.

## Requirements

- **Clarinet**: Ensure you have Clarinet installed for development and testing.
- **Stacks Blockchain**: DishVote operates on the Stacks blockchain using Clarity smart contracts.

## Usage

1. Clone the repository.
2. Navigate to the project directory.
3. Run `clarinet check` to verify the contract.
4. Deploy the contract to the Stacks blockchain using the appropriate tools.
5. Interact with the smart contract via the blockchain interface to vote, query results, and manage the voting process.

## Admin Functions

- `pause-voting`: Temporarily halt the voting process.
- `resume-voting`: Restart the voting process after a pause.
- `add-dish`: Add a new dish to the voting list.

## Public Functions

- `vote`: Cast a vote for a specific dish.
- `get-votes`: Retrieve the current vote counts for all dishes.
- `get-dish-votes`: Get the vote count for a specific dish.
- `has-voted`: Check if a user has already voted.
- `get-winning-dish`: Determine the currently winning dish.

## Notes

- DishVote is designed to be flexible and feature-rich while maintaining simplicity in usage.
- The contract includes security measures to ensure only authorized actions are performed.
- Ensure all dependencies are correctly installed before deployment.
- This version of DishVote supports up to 5 dishes for voting.

## Future Enhancements

- Implement a time-bound voting period.
- Explore weighted voting or delegation features.
- Develop a user-friendly frontend interface for easier interaction.