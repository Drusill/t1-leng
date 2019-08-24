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
Verifica si un tipo Polynomial se encuentra en forma normal:
- los exponentes exp son listados de mayor a menor (estricto)
- los monomios de coeficiente coef igual a 0 se omiten
nf? ::= Polynomial -> Boolean
|#
(define (nf? poly)
  (match poly
    [(nullp) #t]
    [(plus coef exp rem)
     (if (and (> exp (get-exp rem)) (not (zero? coef)))
         (nf? rem)
         #f)]))

#|
Función auxiliar para la normalización de un polinomio. Suma el monomio (c * x^m) al
polinomio poly, que está en forma normal, y devuelve el resultado en normalizado.
sumaMon ::= Number Integer Polynomial -> Polynomial
|#
(define (sumaMon c m poly)
  (match poly
    [(nullp) (plus c m (nullp))]
    [(plus coef exp rem)
     (cond
       [(= c 0) poly]
       [(= coef 0) rem]
       [(> exp m) (plus coef exp (sumaMon c m rem))]
       [(< exp m) (plus c m poly)]
       [(= exp m) (if (zero? (+ coef c))
                      rem
                      (plus (+ coef c) exp rem))])]))

#|
Normaliza el polinomio bajo los criterios de la funcion nf?
normalize ::= Polynomial -> Polynomial
|#
(define (normalize poly)
  (match poly
    [(nullp) poly]
    [(plus coef exp rem)
     (cond
       [(nf? poly) poly]
       [(= coef 0) (normalize rem)]
       [(< exp (get-exp rem)) (normalize (sumaMon coef exp rem))]
       [(> exp (get-exp rem)) (normalize (plus (plus-coef rem)
                                               (plus-exp rem)
                                               (sumaMon coef exp (plus-rem rem))))])]))

;;;;;;;;;;;;;;;;;;;;;;     EJERICIO 2      ;;;;;;;;;;;;;;;;;;;;;;

#|
Retorna el grado de un polinomio no nulo
degree ::= Polynomial -> Integer
|#
(define (degree poly)
  (let ([n-poly (normalize poly)])
    (match n-poly
      [(nullp) (error "El polinomio nulo no tiene grado")]
      [(plus coef exp rem)
       (if (nullp? rem)
           exp
           (max exp (degree rem)))])))

#|
Función auxiliar
Retorna el coeficiente asociado al exponente exp del polinomio normalizado poly
coefficient-normalized ::= Integer Polynomial -> Number
|#
(define (coefficient-normalized exp-n poly)
  (match poly
    [(nullp) 0]
    [(plus coef exp rem)
     (if (= exp exp-n)
         coef
         (coefficient-normalized exp-n rem))]))

#|
Retorna el coeficiente asociado al exponente exp del polinomio poly
coefficient ::= Integer Polynomial -> Number
|#
(define (coefficient exp poly)
  (coefficient-normalized exp (normalize poly)))
    
