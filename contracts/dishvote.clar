;; DishVote - A decentralized voting application
;; Allows users to vote for their favorite dish from a predefined list

;; Constants
(define-constant ERR-INVALID-DISH u100)
(define-constant ERR-ALREADY-VOTED u101)
(define-constant MAX-DISHES u3)

;; Data variables
(define-data-var votes-dish1 uint u0)
(define-data-var votes-dish2 uint u0)
(define-data-var votes-dish3 uint u0)
(define-data-var total-votes uint u0)

;; Dish names
(define-constant dish1 "Jollof Rice")
(define-constant dish2 "Egusi Soup")
(define-constant dish3 "Pounded Yam")

;; Map to track if a user has voted
(define-map user-voted principal bool)

;; Vote function
(define-public (vote (dish uint))
    (let ((caller tx-sender))
        (asserts! (not (default-to false (map-get? user-voted caller))) (err ERR-ALREADY-VOTED))
        (asserts! (<= dish MAX-DISHES) (err ERR-INVALID-DISH))
        (map-set user-voted caller true)
        (var-set total-votes (+ (var-get total-votes) u1))
        (if (is-eq dish u1)
            (ok (var-set votes-dish1 (+ (var-get votes-dish1) u1)))
            (if (is-eq dish u2)
                (ok (var-set votes-dish2 (+ (var-get votes-dish2) u1)))
                (ok (var-set votes-dish3 (+ (var-get votes-dish3) u1)))
            )
        )
    )
)

;; Get all votes
(define-read-only (get-votes)
    {
        dish1: (var-get votes-dish1),
        dish2: (var-get votes-dish2),
        dish3: (var-get votes-dish3),
        total: (var-get total-votes)
    }
)

;; Get votes for a specific dish
(define-read-only (get-dish-votes (dish uint))
    (if (is-eq dish u1)
        (ok (var-get votes-dish1))
        (if (is-eq dish u2)
            (ok (var-get votes-dish2))
            (if (is-eq dish u3)
                (ok (var-get votes-dish3))
                (err ERR-INVALID-DISH)
            )
        )
    )
)

;; Check if a user has voted
(define-read-only (has-voted (user principal))
    (default-to false (map-get? user-voted user))
)

;; Get the winning dish
(define-read-only (get-winning-dish)
    (let (
        (votes1 (var-get votes-dish1))
        (votes2 (var-get votes-dish2))
        (votes3 (var-get votes-dish3))
    )
    (if (and (>= votes1 votes2) (>= votes1 votes3))
        (ok dish1)
        (if (>= votes2 votes3)
            (ok dish2)
            (ok dish3)
        )
    ))
)

