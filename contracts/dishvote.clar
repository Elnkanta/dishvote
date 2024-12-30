;; DishVote - An enhanced decentralized voting application

;; Constants
(define-constant ERR-INVALID-DISH (err u100))
(define-constant ERR-ALREADY-VOTED (err u101))
(define-constant ERR-VOTING-CLOSED (err u102))
(define-constant ERR-UNAUTHORIZED (err u103))
(define-constant ERR-MAX-DISHES-REACHED (err u104))

;; Data variables
(define-data-var dish-count uint u3)
(define-data-var total-votes uint u0)
(define-data-var voting-open bool true)

;; Principal of the contract deployer
(define-data-var contract-owner principal tx-sender)

;; Map to store dish information
(define-map dishes uint {name: (string-ascii 50), votes: uint})

;; Map to track if a user has voted
(define-map user-voted principal bool)

;; Initialize dishes
(map-set dishes u1 {name: "Jollof Rice", votes: u0})
(map-set dishes u2 {name: "Egusi Soup", votes: u0})
(map-set dishes u3 {name: "Pounded Yam", votes: u0})

;; Vote function
(define-public (vote (dish uint))
    (let 
        (
            (caller tx-sender)
            (dish-data (unwrap! (map-get? dishes dish) ERR-INVALID-DISH))
        )
        (asserts! (var-get voting-open) ERR-VOTING-CLOSED)
        (asserts! (not (default-to false (map-get? user-voted caller))) ERR-ALREADY-VOTED)
        (asserts! (<= dish (var-get dish-count)) ERR-INVALID-DISH)
        (map-set user-voted caller true)
        (var-set total-votes (+ (var-get total-votes) u1))
        (ok (map-set dishes dish 
            {name: (get name dish-data), votes: (+ (get votes dish-data) u1)}))
    )
)

;; Get all votes
(define-read-only (get-votes)
    (let 
        ((votes (map get-dish-data (list u1 u2 u3))))
        {
            dishes: votes,
            total: (var-get total-votes)
        }
    )
)

;; Helper function to get dish data
(define-private (get-dish-data (id uint))
    (default-to {name: "Unknown", votes: u0} (map-get? dishes id))
)

;; Get votes for a specific dish
(define-read-only (get-dish-votes (dish uint))
    (match (map-get? dishes dish)
        dish-data (ok (get votes dish-data))
        ERR-INVALID-DISH
    )
)

;; Check if a user has voted
(define-read-only (has-voted (user principal))
    (default-to false (map-get? user-voted user))
)

;; Get the winning dish
(define-read-only (get-winning-dish)
    (fold check-winner (list u1 u2 u3) {id: u0, votes: u0, name: ""})
)

;; Helper function for finding the winner
(define-private (check-winner (id uint) (current-winner {id: uint, votes: uint, name: (string-ascii 50)}))
    (let ((dish-data (get-dish-data id)))
        (if (> (get votes dish-data) (get votes current-winner))
            {id: id, votes: (get votes dish-data), name: (get name dish-data)}
            current-winner
        )
    )
)

;; Admin function to pause voting
(define-public (pause-voting)
    (begin
        (asserts! (is-eq tx-sender (var-get contract-owner)) ERR-UNAUTHORIZED)
        (ok (var-set voting-open false))
    )
)

;; Admin function to resume voting
(define-public (resume-voting)
    (begin
        (asserts! (is-eq tx-sender (var-get contract-owner)) ERR-UNAUTHORIZED)
        (ok (var-set voting-open true))
    )
)

;; Admin function to add a new dish
(define-public (add-dish (name (string-ascii 50)))
    (begin
        (asserts! (is-eq tx-sender (var-get contract-owner)) ERR-UNAUTHORIZED)
        (asserts! (> (len name) u0) ERR-INVALID-DISH)
        (let ((new-id (+ (var-get dish-count) u1)))
            (asserts! (< new-id u255) ERR-MAX-DISHES-REACHED)
            (map-set dishes new-id {name: name, votes: u0})
            (var-set dish-count new-id)
            (ok new-id)
        )
    )
)