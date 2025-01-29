(define-map votes { voter: principal } { dish: (string-ascii 30) })
(define-map vote-counts { dish: (string-ascii 30) } { count: uint })

(define-data-var admin principal tx-sender)
(define-data-var voting-start uint u0)
(define-data-var voting-end uint u0)

(define-constant MAX_DISH_NAME_LEN u30)

(define-public (set-voting-period (start uint) (end uint))
    (begin
        (asserts! (is-eq tx-sender (var-get admin)) (err u100))
        (asserts! (> end start) (err u101))
        (var-set voting-start start)
        (var-set voting-end end)
        (ok true)
    )
)

(define-public (vote (dish-name (string-ascii 30)))
    (begin
        (asserts! (not (is-some (map-get? votes { voter: tx-sender }))) (err u102))
        (asserts! (>= block-height (var-get voting-start)) (err u103))
        (asserts! (<= block-height (var-get voting-end)) (err u104))
        
        (let ((current-count (default-to u0 (get count (map-get? vote-counts { dish: dish-name })))))
            (map-set votes { voter: tx-sender } { dish: dish-name })
            (map-set vote-counts { dish: dish-name } { count: (+ current-count u1) })
            (ok true)
        )
    )
)

(define-read-only (get-vote (voter principal))
    (map-get? votes { voter: voter })
)

(define-read-only (get-vote-count (dish-name (string-ascii 30)))
    (map-get? vote-counts { dish: dish-name })
)

(define-read-only (get-vote-counts)
    (ok (map-get? vote-counts { dish: "example" }))
)