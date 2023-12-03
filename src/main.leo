// This example demonstrates an example of a minting and transferring a token in Leo.
program simple_token_7io10jj.aleo {
    // The `Token` record datatype.
    record Token {
        // The token owner.
        owner: address,
        // The token amount.
        amount: u64,
    }

    // The `mint` function initializes a new record with the
    // specified number of tokens assigned to the specified receiver.
    //
    // You can try this transition function by running: 
    // leo run mint aleo1mgfq6g40l6zkhsm063n3uhr43qk5e0zsua5aszeq5080dsvlcvxsn0rrau 100u64

    transition mint(owner: address, amount: u64) -> Token {
        return Token {
            owner: owner,
            amount: amount,
        };
    }

    // The `transfer` function sends the specified number of tokens
    // to the receiver from the provided token record.
    //
    // You can try this transition function by running: 
    // leo run transfer "{owner: aleo1mgfq6g40l6zkhsm063n3uhr43qk5e0zsua5aszeq5080dsvlcvxsn0rrau.private, amount: 100u64.private, _nonce: 0group.public}" aleo1mgfq6g40l6zkhsm063n3uhr43qk5e0zsua5aszeq5080dsvlcvxsn0rrau 50u64
    
    transition transfer(token: Token, to: address, amount: u64) -> (Token, Token) {

        // Checks the given token record has sufficient balance.
        // This `sub` operation is safe, and the proof will fail
        // if an overflow occurs.
        // `difference` holds the change amount to be returned to sender.
        let difference: u64 = token.amount - amount;

        // Produce a token record with the change amount for the sender.
        let remaining: Token = Token {
            owner: token.owner,
            amount: difference,
        };

        // Produce a token record for the specified receiver.
        let transferred: Token = Token {
            owner: to,
            amount: amount,
        };

        // Output the sender's change record and the receiver's record.
        return (remaining, transferred);
    }
}
