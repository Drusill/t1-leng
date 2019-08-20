#lang play

#|
Tarea 1 - Lenguajes de Programación
Primavera 2019
--------------
Raúl Cid
Victor Caro
|#

;;;;;;;;;;;;;;;;;;;;;;       DEFTYPE       ;;;;;;;;;;;;;;;;;;;;;;

#|
Representacion de Polinomios
<Polynomial> ::= (nullp)
               | (plus <Number> <Integer> <Polynomial>)
|#
(deftype Polynomial
  (nullp)
  (plus coef exp rem))

;;;;;;;;;;;;;;;;;;;;;;     EJERICIO 1      ;;;;;;;;;;;;;;;;;;;;;;

#|
Función auxiliar para obtener el exponente de un elemento del polinomio
get-exp ::= Polynomial -> Integer
|#
(define (get-exp poly)
  (match poly
    [(nullp) -1]
    [(plus coef exp rem) exp]))


#|
Función que verifica si un tipo Polynomial se encuentra en forma normal:
- los exponentes son listados de mayor a menor (estricto)
- los monomios de coeficiente 0 se omiten
nf? ::= Polynomial -> Boolean
|#
(define (nf? poly)
  (match poly
    [(nullp) #t]
    [(plus coef exp rem)
     (if (and (> exp (get-exp rem)) (not (zero? coef)))
         (nf? rem)
         #f)]))

