// DishVote - A decentralized voting application
// Allows users to vote for their favorite dish from a predefined list

(define-data-var votes-dish1 uint 0)
(define-data-var votes-dish2 uint 0)
(define-data-var votes-dish3 uint 0)

(define-constant dish1 "Jollof Rice")
(define-constant dish2 "Egusi Soup")
(define-constant dish3 "Pounded Yam")

(define-public (vote (dish uint))
    (begin
        (if (is-eq dish u1)
            (ok (var-set votes-dish1 (+ (var-get votes-dish1) u1)))
            (if (is-eq dish u2)
                (ok (var-set votes-dish2 (+ (var-get votes-dish2) u1)))
                (if (is-eq dish u3)
                    (ok (var-set votes-dish3 (+ (var-get votes-dish3) u1)))
                    (err u100) ; Error code for invalid dish
                )
            )
        )
    )
)

(define-read-only (get-votes)
    {
        dish1: (var-get votes-dish1),
        dish2: (var-get votes-dish2),
        dish3: (var-get votes-dish3)
    }
)
