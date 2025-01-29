(define-map votes { voter: principal } { dish: (string-ascii 30) })
(define-map vote-counts { dish: (string-ascii 30) } { count: uint })

(define-data-var admin principal tx-sender)
(define-data-var voting-start uint 0)
(define-data-var voting-end uint 0)

(define-constant MAX_DISH_NAME_LEN 30)

(define-public (set-voting-period (start uint) (end uint))
    (begin
        (asserts! (is-eq tx-sender (var-get admin)) (err u100))
        (asserts! (> end start) (err u101))
        (var-set voting-start start)
        (var-set voting-end end)
        (ok true)
    )
)

(define-public (vote (dish-name (string-ascii MAX_DISH_NAME_LEN)))
    (begin
        (asserts! (is-some (map-get? votes { voter: tx-sender })) (err u102))
        (asserts! (>= block-height (var-get voting-start)) (err u103))
        (asserts! (<= block-height (var-get voting-end)) (err u104))
        (map-set votes { voter: tx-sender } { dish: dish-name })
        (map-insert vote-counts { dish: dish-name } { count: (+ (unwrap! (map-get? vote-counts { dish: dish-name }) { count: u0 }) u1) })
        (ok true)
    )
)

(define-read-only (get-vote (voter principal))
    (map-get? votes { voter: voter })
)

(define-read-only (get-vote-count (dish-name (string-ascii MAX_DISH_NAME_LEN)))
    (map-get? vote-counts { dish: dish-name })
)

(define-read-only (get-leaderboard)
    (map-fold vote-counts (fn (key value result)
        (let ((dish (get dish key)) (count (get count value)))
            (append result (list { dish: dish, count: count }))))
        '()
    )
)

