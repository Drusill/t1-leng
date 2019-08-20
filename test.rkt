#lang play

(require "base.rkt")

(print-only-errors #t)


;; Agregue aqui todos sus tests

;;;;;;;;;;;;;;;;;;;;;;     EJERICIO 1      ;;;;;;;;;;;;;;;;;;;;;;
;; get-exp
(test (get-exp (nullp)) -1)
(test (get-exp (plus 0 4 (plus 0 2 (plus 0 1 (nullp))))) 4)
(test (get-exp (plus 4 5 (plus 3 2 (plus 5 0 (nullp))))) 5)

;; nf?
(test (nf? (nullp)) #t)
(test (nf? (plus 0 4 (plus 0 2 (plus 0 1 (nullp))))) #f)
(test (nf? (plus 3 2 (plus 4 5 (plus 5 0 (nullp))))) #f)
(test (nf? (plus 4 5 (plus 3 2 (plus 5 0 (nullp))))) #t)

;; sumaMon
(test (sumaMon 6 6 (plus 4 4 (plus 2 2 (nullp)))) (plus 6 6 (plus 4 4 (plus 2 2 (nullp)))))
(test (sumaMon 3 3 (plus 4 4 (plus 2 2 (nullp)))) (plus 4 4 (plus 3 3 (plus 2 2 (nullp)))))
(test (sumaMon 10 2 (plus 4 4 (plus 2 2 (nullp)))) (plus 4 4 (plus 12 2 (nullp))))
(test (sumaMon -2 2 (plus 4 4 (plus 2 2 (nullp)))) (plus 4 4 (nullp)))



;;;;;;;;;;;;;;;;;;;;;;     EJERICIO 2      ;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;     EJERICIO 3      ;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;     EJERICIO 4      ;;;;;;;;;;;;;;;;;;;;;;